//
//  StepDetailCommunicationListVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "StepDetailCommunicationListVC.h"
#import "StepDetailCommunication.h"
#import "StepDetailCommunicationTVCell.h"

@interface StepDetailCommunicationListVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation StepDetailCommunicationListVC

static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self.navigationItem setTitle:@"任务交流"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addTaskCommunication)];
    [self getOneTaskStepCommunicationListFromServer];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[StepDetailCommunicationTVCell class] forCellReuseIdentifier:identifier];
    
    
}

-(void)addTaskCommunication{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
}
-(void)getOneTaskStepCommunicationListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/comment/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"1" forKey:@"pageNum"];
    [mdict setObject:_subtaskIdStr forKey:@"subtaskId"];
    NSLog(@"66666%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"T1276543234565432:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60005) {
                                                        NSLog(@"TaskList2:%@", dataBack);
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        NSLog(@"dataListArray:%@", dataListArray);
                                                        for (NSDictionary * dict in dataListArray) {
                                                            StepDetailCommunication * stepDetailCommunication = [StepDetailCommunication new];
                                                            [stepDetailCommunication setValuesForKeysWithDictionary:dict];
                                                            [self.datasource addObject:stepDetailCommunication];
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

#pragma mark  tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    StepDetailCommunicationTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    StepDetailCommunication * stepDetailCommunication = self.datasource[indexPath.row];
    cell.stepDetailCommunication = stepDetailCommunication;
    return cell;
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
