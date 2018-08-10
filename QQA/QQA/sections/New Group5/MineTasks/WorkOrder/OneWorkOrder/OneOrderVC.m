//
//  OneOrderVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderVC.h"
#import "OneOrder.h"
#import "OneOrderCell.h"
#import "OneOrderCommunicationVController.h"
#import "UIButton+WebCache.h"

#define kHEADERBTNSPACE  (iphoneWidth - 320) / 5 //button间隙

@interface OneOrderVC ()
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataOfHeaderOfTheDepartment;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;
@property (nonatomic, strong) NSMutableArray * leadersMArray;


@end
@implementation OneOrderVC
static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}
-(NSMutableArray *)leadersMArray{
    if (!_leadersMArray) {
        _leadersMArray = [NSMutableArray new];
    }
    return _leadersMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _dataOfHeaderOfTheDepartment = [NSMutableArray array];
    [self.navigationItem  setTitle:@"工单详情"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayaddNewOrEditWorkOrderView)];

    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneOrderCell class] forCellReuseIdentifier:identifier];
    [self getWorkOrderListFromServer:1];

}


-(void)displayaddNewOrEditWorkOrderView{
//    _workOrderTitle.text = @"新建工单";
//    _workOrderTextField.text = @"";
//    _messageTextView.text = @"";
//    _workOrderNameAgreeBtn.backgroundColor = [UIColor redColor];
//    _workOrderNameRejectBtn.backgroundColor = [UIColor whiteColor];
//    _agreeBTN = YES;
//    _addOrEditWorkOrderView.frame = CGRectMake(10, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
}


-(void)getWorkOrderListFromServer:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSArray * dataListArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"workListDetails"];
                                                        NSLog(@"dataBack:oneOrder:dataListArray::::%@", dataListArray);
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneOrder * oneOrder = [OneOrder new];
                                                            [oneOrder setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:oneOrder];
                                                        }
                                                        NSLog(@"self.datasourceMArray:%@", self.datasourceMArray);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    [self alert:@"获取失败"];
                                                }
                                            }else{
                                                [self alert:@"获取失败"];
                                            }
                                        }];
    [task resume];
}


#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OneOrder * oneOrder = self.datasourceMArray[indexPath.row];
    cell.oneOrder = oneOrder;
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

#pragma  viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, 120)];
    _headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_headerView];
    [self getSelectedLeadersFromServer];
    return _headerView;
}
-(void)getSelectedLeadersFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSMutableArray * leaderMArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"leaders"];
                                                        NSLog(@"self.datasourceMArrayleader:%@", self.datasourceMArray);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self addLeadersViews:leaderMArray];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    [self alert:@"获取失败"];
                                                }
                                            }else{
                                                [self alert:@"获取失败"];
                                            }
                                        }];
    [task resume];
}
-(void)addLeadersViews:(NSMutableArray *)mAry{
    _dataOfHeaderOfTheDepartment = mAry;
    for (int i = 0; i < _dataOfHeaderOfTheDepartment.count; i++) {
        UIButton * headerOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        headerOfDepartmentBtn.frame = CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 5, 80, 80);
        headerOfDepartmentBtn.backgroundColor = [UIColor redColor];
        headerOfDepartmentBtn.layer.cornerRadius = headerOfDepartmentBtn.frame.size.width / 2;
        headerOfDepartmentBtn.layer.masksToBounds = YES;
        
        NSString * urlStr = [NSString stringWithFormat:@"%@", [_dataOfHeaderOfTheDepartment[0] objectForKey:@"img"]];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        [headerOfDepartmentBtn setBackgroundImage:image forState:UIControlStateNormal];
        headerOfDepartmentBtn.tag = 50000 + i;
        [headerOfDepartmentBtn addTarget:self action:@selector(viewOrIncrease:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:headerOfDepartmentBtn];
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = [_dataOfHeaderOfTheDepartment[i] objectForKey:@"status"];
        [_headerView addSubview:nameLabel];
    }
    if(_dataOfHeaderOfTheDepartment.count < 4){
        UIButton * addNewHeaderOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addNewHeaderOfDepartmentBtn.frame = CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 5, 80, 80);
        addNewHeaderOfDepartmentBtn.backgroundColor = [UIColor greenColor];
        addNewHeaderOfDepartmentBtn.layer.cornerRadius = addNewHeaderOfDepartmentBtn.frame.size.width / 2;
        addNewHeaderOfDepartmentBtn.layer.masksToBounds = YES;
        addNewHeaderOfDepartmentBtn.tag = 51001;
        [addNewHeaderOfDepartmentBtn addTarget:self action:@selector(viewOrIncrease:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addNewHeaderOfDepartmentBtn];
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.text = @"添加部门负责人";
        [_headerView addSubview:nameLabel];
    }
}
-(void)viewOrIncrease:(UIButton *)sender{
    switch (sender.tag) {
        case 50000:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50001:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50002:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50003:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 51001:
            NSLog(@"%ld", (long)sender.tag);
            break;
        default:
            break;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OneOrderCommunicationVController * oneOrderCommunicationVController = [OneOrderCommunicationVController new];
    [self.navigationController pushViewController:oneOrderCommunicationVController animated:YES];
}



-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
//        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
//            [self undisplayaddOrEditWorkOrderView];
//            if ([str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
//                [self getWorkOrderListFromServer:_pageNum];
//            }
//        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
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
