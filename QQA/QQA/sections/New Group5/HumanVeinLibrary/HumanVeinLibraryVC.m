//
//  HumanVeinLibraryVC.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanVeinLibraryVC.h"
#import "DataModel.h"
#define searchBarHeigint 60
#import "NewContactViewController.h"
#import "Human.h"
#import "HumanCell.h"
#import "HumanDetailVC.h"

@interface HumanVeinLibraryVC ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray * tableData;
@property (nonatomic, strong) NSMutableArray * resultData;
@property (nonatomic, strong) NSArray * tableIndexData;
@property (nonatomic, strong) NSMutableArray * resultIndexData;
@property (nonatomic, assign) BOOL  searchActive;
@property (nonatomic, strong) UISearchBar * bar;

@property(nonatomic, strong) NSMutableArray * humanReinAllInformationMArray;
@property(nonatomic, strong) NSMutableArray * humanNamesMArray;

@end

@implementation HumanVeinLibraryVC

static NSString *identifier = @"CELL";

-(NSMutableArray *)humanReinAllInformationMArray{
    if (!_humanReinAllInformationMArray) {
        _humanReinAllInformationMArray = [NSMutableArray array];
    }
    return _humanReinAllInformationMArray;
}
-(NSMutableArray *)humanNamesMArray{
    if (!_humanNamesMArray) {
        _humanNamesMArray = [NSMutableArray array];
    }
    return _humanNamesMArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"人脉库"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newContact)];
    [self getHumanVeinLibraryFromServer];//获取人脉库人员列表
    [self  addtableView];
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    [self.tableView reloadData];
//}

-(void)getHumanVeinLibraryFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/connection/index", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 40003) {
                                                        [self.humanReinAllInformationMArray removeAllObjects];
                                                        [self.humanNamesMArray removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            Human * human = [Human new];
                                                            [human setValuesForKeysWithDictionary:dict];
                                                            [self.humanReinAllInformationMArray addObject:human];
                                                            [self.humanNamesMArray addObject:[dict objectForKey:@"name"]];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                            [self addSearchBar];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                NSLog(@"HUMan5获取数据失败，问gitPersonPermissions");
                                            }
                                        }];
    [task resume];
}


-(void)addtableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + searchBarHeigint, self.view.bounds.size.width, self.view.bounds.size.height - searchBarHeigint - 64) style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.tableView registerClass:[HumanCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _searchActive ? _resultData.count : _tableData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchActive ? [_resultData[section] count] : [_tableData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
//    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!aCell) {
//        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    DataModel * m = _searchActive ? _resultData[indexPath.section][indexPath.row] : _tableData[indexPath.section][indexPath.row];
//    aCell.textLabel.text = m.aName;
    
    HumanCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HumanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Human * human = _searchActive ? _resultData[indexPath.section][indexPath.row] : _tableData[indexPath.section][indexPath.row]; 
    cell.human = human;
    switch (indexPath.row % 10) {
        case 0:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
            break;
        case 1:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
            break;
        case 2:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
            break;
        case 3:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
            break;
        case 4:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
            break;
        case 5:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 37/ 255.0 green:155 / 255.0 blue: 35 / 255.0 alpha:1];
            break;
            
        case 6:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed:0 green:151 / 255.0 blue: 136 / 255.0 alpha:0.8];
            break;
        case 7:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 238/ 255.0 green:23 / 255.0 blue: 39 / 255.0 alpha:1];
            break;
            
        case 8:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed: 254/ 255.0 green:65 / 255.0 blue: 129 / 255.0 alpha:1];
            break;
            
        case 9:
            cell.nameFamilyLabel.backgroundColor = [UIColor colorWithRed:62/ 255.0 green:80 / 255.0 blue: 182 / 255.0 alpha:1];
            break;
        default:
            break;
    }
    return  cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _searchActive ? _resultIndexData : _tableIndexData;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
//返回当用户触摸到某个索引标题时列表应该跳至的区域的索引。
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * tempLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    tempLab.text = _searchActive ? _resultIndexData[section] : _tableIndexData[section];
    tempLab.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    return tempLab;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    NewContactViewController * newContactVC = [NewContactViewController new];
//    [self.navigationController pushViewController:newContactVC animated:NO];
    
    Human * human = _searchActive ? _resultData[indexPath.section][indexPath.row] : _tableData[indexPath.section][indexPath.row];
    
    HumanDetailVC * humanDetailVC = [HumanDetailVC new];
    humanDetailVC.connectionIdStr = [NSString stringWithFormat:@"%@", human.connectionId];
    if ([human.isShow intValue] == 0) {
        [self alert:@"您无权查看该联系人\n请与创建者联系！"];
    }else{
        [self.navigationController pushViewController:humanDetailVC animated:NO];
    }
   
}
-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"请注意!";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
}


-(void)addSearchBar{
    _bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0 , 0, iphoneWidth, searchBarHeigint)];
    _bar.backgroundColor = [UIColor yellowColor];
    _bar.placeholder = @"搜索联系人";
    _bar.showsCancelButton = YES;
    _bar.delegate = self;
    for(id cc in [_bar subviews]){
        for (id subView in [cc subviews]) {
            if ([subView isKindOfClass:[UITextField class]]) {
                // 更改输入框内区域的背景色为灰色
                UITextField *textF = (UITextField *)subView;
                textF.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0f];
            }else if([subView isKindOfClass:[UIButton class]]){
                // 修改取消按钮
                UIButton *btn = (UIButton *)subView;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(cancelButton) forControlEvents:UIControlEventTouchUpInside];
//                [btn setTitleColor:[UIColor cyanColor] forState:(UIControlStateNormal)];
            }
        }
    }
    [self.view addSubview:_bar];
    
    NSLog(@"_humanNamesMArray222222222222:%@", _humanNamesMArray);
    NSArray *testArr = _humanNamesMArray;
//    NSArray *testArr = @[@"张三",@"李四",@"王五",@"赵六",@"田七",@"王小二",@"阿三", @"北京", @"啊北", @"必答", @"次次", @"达达", @"夫妇", @"哥哥", @"哈哈", @"爱你", @"久久", @"希望", @"北方", @"你好", @"哈啊哈", @"岁月", @"美好", @"咩咩", @"灭李", @"美丽", @"美的", @"妹妹", @"米恶化", @"眯会"];
    
    NSArray * tempArray = [self sringSectioncompositor:_humanReinAllInformationMArray withSelector:@selector(name)isDeleEmptyArray:YES];
    self.tableData = tempArray[0];
    self.tableIndexData = tempArray[1];
    [self.tableView  reloadData];
}


-(void)cancelButton{
   [_bar resignFirstResponder];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_bar resignFirstResponder];
    return indexPath;
}
//// 滑动的时候 searchBar 回收键盘
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_bar resignFirstResponder];
//}

//将汉字转为拼音 是否支持全拼可选
- (NSString *)transformToPinyin:(NSString *)aString isQuanPin:(BOOL)quanPin
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    if (quanPin)
    {
        int count = 0;
        for (int  i = 0; i < pinyinArray.count; i++)
        {
            for(int i = 0; i < pinyinArray.count;i++)
            {
                if (i == count) {
                    [allString appendString:@"#"];
                    //区分第几个字母
                }
                [allString appendFormat:@"%@",pinyinArray[i]];
            }
            [allString appendString:@","];
            count ++;
        }
    }
    
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:[s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    return allString;
}

//将传进来的对象按通讯录那样分组排序，每个section中也排序  dataarray是中存储的是一组对象，selector是属性名
- (NSArray *)sringSectioncompositor:(NSArray *)dataArray withSelector:(SEL)selector isDeleEmptyArray:(BOOL)isDele
{
    UILocalizedIndexedCollation  *collation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray * indexArray = [NSMutableArray arrayWithArray:collation.sectionTitles];
    NSUInteger sectionNumber = indexArray.count;
    //建立每个section数组
    NSMutableArray * sectionArray = [NSMutableArray arrayWithCapacity:sectionNumber];
    for (int n = 0; n < sectionNumber; n++){
        NSMutableArray *subArray = [NSMutableArray array];
        [sectionArray addObject:subArray];
    }
    for (Human *model in _humanReinAllInformationMArray){
        //        根据SEL方法返回的字符串判断对象应该处于哪个分区
        NSInteger index = [collation sectionForObject:model collationStringSelector:selector];
        NSMutableArray *tempArray = sectionArray[index];
        [tempArray addObject:model];
    }
    for (NSMutableArray *tempArray in sectionArray){
        //        根据SEL方法返回的string对数组元素排序
        NSArray* sorArray = [collation sortedArrayFromArray:tempArray collationStringSelector:selector];
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:sorArray];
    }
    //    是否删除空数组
    if (isDele)
    {
        [sectionArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.count == 0)
            {
                [sectionArray removeObjectAtIndex:idx];
                [indexArray removeObjectAtIndex:idx];
            }
        }];
    }
    //返回第一个数组为table数据源  第二个数组为索引数组
    return @[sectionArray, indexArray];
}
#pragma mark -- UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    //这里最好放在数据库里面再进行搜索，效率会更快一些
    if (searchText.length == 0)
    {
        _searchActive = NO;
        [self.tableView reloadData];
        return;
    }
    _searchActive = YES;
    _resultData = [NSMutableArray array];
    _resultIndexData = [NSMutableArray array];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
        [self.tableData enumerateObjectsUsingBlock:^(NSMutableArray * obj, NSUInteger aIdx, BOOL * _Nonnull stop) {
            //刚进来 && 第一个数组不为空时 插入一个数组在第一个位置
            if (_resultData.count == 0 || [[_resultData lastObject] count] != 0)
            {
                [_resultData addObject:[NSMutableArray array]];
            }
            
            [obj enumerateObjectsUsingBlock:^(Human * model, NSUInteger bIdx, BOOL * _Nonnull stop) {
                
                NSString *tempStr = model.name;
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr isQuanPin:NO];
                
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0)
                {
                    //把搜索结果存放self.resultArray数组
                    [_resultData.lastObject addObject:model];
                    if (_resultIndexData == 0 || ![_resultIndexData.lastObject isEqualToString:_tableIndexData[aIdx]])
                    {
                        [_resultIndexData addObject:_tableIndexData[aIdx]];
                    }
                }
            }];
        }];
        //回到主线程
        if ([_resultData.lastObject count] == 0)
        {
            [_resultData removeLastObject];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
#pragma mark - Scroll View Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}



-(void)newContact{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256  / 255.0 green:arc4random() % 256  / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    NewContactViewController * newContactVC = [NewContactViewController new];
    newContactVC.receivedStr = @"新建联系人";
    [self.navigationController pushViewController:newContactVC animated:NO];
}


-(void)viewDidAppear:(BOOL)animated{
    [self getHumanVeinLibraryFromServer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
