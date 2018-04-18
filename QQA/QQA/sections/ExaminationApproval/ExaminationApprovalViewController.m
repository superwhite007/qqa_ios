//
//  ExaminationApprovalViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ExaminationApprovalViewController.h"
#import "LanchViewController.h"
#import "IInitiatedtheExaminationTableViewController.h"
#import "ACPApprovelViewController.h"
#import "RequestAndLeaveDetailsViewController.h"
#import "CompanyTableViewCell.h"

@interface ExaminationApprovalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) NSMutableArray * datasourceRedpoint;
@property (nonatomic, strong) UITableView * examinationAndApprovel;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation ExaminationApprovalViewController

static NSString *identifier = @"CELL";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return  _datasource;
}
-(NSMutableArray *)datasourceRedpoint{
    if (!_datasourceRedpoint) {
        self.datasourceRedpoint = [NSMutableArray array];
    }
    return _datasourceRedpoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    [self.datasourceRedpoint addObject:@"0"];
    [self.datasourceRedpoint addObject:@"0"];
    [self.datasourceRedpoint addObject:@"0"];
    [self.datasourceRedpoint addObject:@"0"];
    [self getStartTimerAboutRedPoint];
//    [self getRedpointOfNoticeFromServer];

//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:238  / 255.0 green:0  / 255.0 blue:0 / 255.0 alpha:0.5];
    [self.datasource addObject:@"发起审批"];
    [self.datasource addObject:@"待审批的"];
    [self.datasource addObject:@"已通过的"];
    [self.datasource addObject:@"未通过的"];
    [self.datasource addObject:@"抄送我的"];
    _examinationAndApprovel = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _examinationAndApprovel.dataSource = self;
    _examinationAndApprovel.delegate = self;
//    examinationAndApprovel.rowHeight = 60;
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        _examinationAndApprovel.rowHeight = 60;
    }else{
        _examinationAndApprovel.rowHeight = 60 * 4 / 5;
    }
    _examinationAndApprovel.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _examinationAndApprovel.scrollEnabled = NO;
    _examinationAndApprovel.sectionHeaderHeight =  [UIScreen mainScreen].bounds.size.width * 2 /3;
    [_examinationAndApprovel registerClass:[CompanyTableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:_examinationAndApprovel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.datasource[indexPath.row];
    
    if (indexPath.row == 1 && [self.datasourceRedpoint[0] intValue] > 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[0]];
        cell.nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row == 1 && [self.datasourceRedpoint[0] intValue] == 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        cell.nameShorthandLabel.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.row == 2 && [self.datasourceRedpoint[1] intValue] > 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[1]];
        cell.nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row == 2 && [self.datasourceRedpoint[1] intValue] == 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        cell.nameShorthandLabel.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.row == 3 && [self.datasourceRedpoint[2] intValue] > 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[2]];
        cell.nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row == 3 && [self.datasourceRedpoint[2] intValue] == 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        cell.nameShorthandLabel.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.row == 4 && [self.datasourceRedpoint[3] intValue] > 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[3]];
        cell.nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row == 4 && [self.datasourceRedpoint[3] intValue] == 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        cell.nameShorthandLabel.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc ] init];
    
    UIImageView * imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3)];
    [imageViewHeader setImage:[UIImage imageNamed:@"everyday_1"]];
    [self.view addSubview:imageViewHeader];
    
    return  view ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IInitiatedtheExaminationTableViewController * examinationVC = [[IInitiatedtheExaminationTableViewController alloc] initWithStyle:(UITableViewStylePlain)];
    if (indexPath.row == 0) {
        examinationVC.titleIdentifier = @"发起审批";
    } else if (indexPath.row == 1) {
        examinationVC.titleIdentifier = @"待审批的";
    } else if (indexPath.row == 2) {
        examinationVC.titleIdentifier = @"已通过的";
    } else if (indexPath.row == 3) {
        examinationVC.titleIdentifier = @"未通过的";
    } else if (indexPath.row == 4) {
        examinationVC.titleIdentifier = @"抄送我的";
    }
    [self.navigationController pushViewController:examinationVC animated:YES];
}

-(void)getStartTimerAboutRedPoint{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getRedpointOfNoticeFromServer) userInfo:nil repeats:YES];
}

-(void)getRedpointOfNoticeFromServer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/leave/unread", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
                                            if (error) {
                                                NSLog(@"审核red服务器返回错误：%@", error);
                                            }else {
                                                
                                                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                if ( [object isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"审核red出现异常，服务器约定为字典类型");
                                                }else if ([object isKindOfClass:[NSDictionary class]]){
//                                                    NSLog(@"审核redNoticeredpoint字典%@", object);
                                                    if ([[object objectForKey:@"message"] intValue] != 20002 ) {
                                                        NSLog(@"审核red服务获得到数据，但是数据异常");
                                                    }else {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            NSString * str = [NSString stringWithFormat:@"%@", [object objectForKey:@"leavesUnreadApprovedTotalNum"]];
                                                            NSString * str1 = [NSString stringWithFormat:@"%@", [object objectForKey:@"leavesUnreadAgreedTotalNum"]];
                                                            NSString * str2 = [NSString stringWithFormat:@"%@", [object objectForKey:@"leavesUnreadDenyedTotalNum"]];
                                                            NSString * str3 = [NSString stringWithFormat:@"%@", [object objectForKey:@"leavesUnreadCopyedTotalNum"]];
                                                            
                                                            [self.datasourceRedpoint removeAllObjects];
                                                            [self.datasourceRedpoint addObject:str];
                                                            [self.datasourceRedpoint addObject:str1];
                                                            [self.datasourceRedpoint addObject:str2];
                                                            [self.datasourceRedpoint addObject:str3];
//                                                            NSLog(@"self.datasourceRedpoint%@", self.datasourceRedpoint);
                                                            [self.examinationAndApprovel reloadData];
                                                        });
                                                    }
                                                }
                                            }
                                        }];
    [task resume];
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
