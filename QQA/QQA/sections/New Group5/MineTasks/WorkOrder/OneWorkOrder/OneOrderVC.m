//
//  OneOrderVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderVC.h"
#define kHEADERBTNSPACE  (iphoneWidth - 320) / 5 //button间隙
#import "OneOrder.h"
#import "OneOrderCell.h"

@interface OneOrderVC ()
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataOfHeaderOfTheDepartment;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;

@end
@implementation OneOrderVC
static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _dataOfHeaderOfTheDepartment = [NSMutableArray array];
    [self.navigationItem  setTitle:@"工单详情"];
    [self addHeaderView];
    
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneOrderCell class] forCellReuseIdentifier:identifier];
//    [self getWorkOrderListFromServer:1];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    
    
    
}

#pragma getDataFServer
-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self getWorkOrderListFromServer:--self.pageNum];
    } else{
        [self getWorkOrderListFromServer:1];
    }
    [self.tableView.mj_header endRefreshing];
}

-(void)loadMoreData{
    self.isDownRefresh = NO;
    [self getWorkOrderListFromServer:++self.pageNum];
    [self.tableView.mj_footer endRefreshing];
}

-(void)getWorkOrderListFromServer:(int)page{
//    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workList/index", CONST_SERVER_ADDRESS]];
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    request.timeoutInterval = 10.0;
//    request.HTTPMethod = @"POST";
//    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
//    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
//    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
//    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
//    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
//    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
//    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
//    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
//    NSError * error = nil;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
//    request.HTTPBody = jsonData;
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionTask *task = [session dataTaskWithRequest:request
//                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                            if (data != nil) {
//                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
//                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70001) {
//                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
//                                                        [self.datasourceMArray removeAllObjects];
//                                                        for (NSDictionary * dict in dataListArray) {
//                                                            WorkOrder * workOrder = [WorkOrder new];
//                                                            [workOrder setValuesForKeysWithDictionary:dict];
//                                                            [self.datasourceMArray addObject:workOrder];
//                                                        }
//                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            [self.tableView  reloadData];
//                                                        });
//                                                    }
//                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
//                                                    [self alert:@"获取失败"];
//                                                }
//                                            }else{
//                                                [self alert:@"获取失败"];
//                                            }
//                                        }];
//    [task resume];
}


#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  self.datasourceMArray.count;
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    OneOrder * oneOrder = self.datasourceMArray[indexPath.row];
//    cell.oneOrder = oneOrder;
    return  cell;
}




-(void)addHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, 120)];
    _headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_headerView];
    
    [self headerViewAddHeadOfTheDepartmentButton];
}
-(void)headerViewAddHeadOfTheDepartmentButton{
    
    [self getHeadOfTheDepartmentFromServder];
}
-(void)getHeadOfTheDepartmentFromServder{
    [_dataOfHeaderOfTheDepartment addObject:@"test1"];
    [_dataOfHeaderOfTheDepartment addObject:@"test2"];
    [_dataOfHeaderOfTheDepartment addObject:@"test3"];
    NSLog(@"count:::::%lu", (unsigned long)_dataOfHeaderOfTheDepartment.count);
    //按照产品设计，最多四个候选人
    for (int i = 0; i < _dataOfHeaderOfTheDepartment.count; i++) {
        UIButton * headerOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        headerOfDepartmentBtn.frame = CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 5, 80, 80);
        headerOfDepartmentBtn.backgroundColor = [UIColor redColor];
        [_headerView addSubview:headerOfDepartmentBtn];
        headerOfDepartmentBtn.layer.cornerRadius = headerOfDepartmentBtn.frame.size.width / 2;
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        [_headerView addSubview:nameLabel];
    }
    if(_dataOfHeaderOfTheDepartment.count < 4){
        UIButton * addNewHeaderOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addNewHeaderOfDepartmentBtn.frame = CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 5, 80, 80);
        addNewHeaderOfDepartmentBtn.backgroundColor = [UIColor greenColor];
        [_headerView addSubview:addNewHeaderOfDepartmentBtn];
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.text = @"添加部门负责人";
        [_headerView addSubview:nameLabel];
    }
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
