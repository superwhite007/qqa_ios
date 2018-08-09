//
//  WorkOrderNameLIstsViewController.m
//  QQA
//
//  Created by wang huiming on 2018/8/9.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderNameLIstsViewController.h"
#import "OneOrderVC.h"
#import "WorkOrderTVCell.h"
#import "WorkOrder.h"

#define kWORKORDERWIDTH  iphoneWidth - 20 //WORKORDERWIDTH
#define kWORKORDERORGINh  (iphoneHeight - iphoneWidth)/2   //iphoneHeight
#define kWORKORDERORGINHSPACE  (iphoneWidth - 20) / 20   //workOrderSpace


@interface WorkOrderNameLIstsViewController ()
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;


@end

@implementation WorkOrderNameLIstsViewController

static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[WorkOrderTVCell class] forCellReuseIdentifier:identifier];
    
//    [self addNewOREditWorkOrderView];
    [self getWorkOrderListFromServer:1];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}
-(void)gotoOneOrderVC{
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
}

#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkOrderTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    WorkOrder * workOrder = self.datasourceMArray[indexPath.row];
    cell.workOrder = workOrder;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self gotoOneOrderVC];
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

-(void)loadMoreData
{
    //记录不是下拉刷新
    self.isDownRefresh = NO;
    [self getWorkOrderListFromServer:++self.pageNum];
    [self.tableView.mj_footer endRefreshing];
}

-(void)getWorkOrderListFromServer:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workList/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    NSLog(@"mdict:::%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70001) {
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            //                                                            NSLog(@"dataBack::::dataListArray:%@", dataListArray);
                                                            WorkOrder * workOrder = [WorkOrder new];
                                                            [workOrder setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:workOrder];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
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

-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"]) {
//            [self undisplayaddOrEditWorkOrderView];
        }
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
