//
//  CompanyViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyViewController.h"
#import "LanchViewController.h"
#import "CompanyNoticeViewController.h"
#import "CompanyinformationAndBylawsViewController.h"
#import "CompanyOrganizationalStructureViewController.h"
#import "RulesDetailViewController.h"
#import "CompanyBylawsViewController.h"

#import "CompanyTableViewCell.h"

@interface CompanyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) NSMutableArray * datasourceRedpoint;
@property (nonatomic, strong) UITableView * examinationAndApprovel;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation CompanyViewController

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
    self.tabBarController.navigationItem.title = @"青青";
    [self.datasourceRedpoint addObject:@"0"];
    [self getStartTimerAboutRedPoint];

    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:238  / 255.0 green:0  / 255.0 blue:0 / 255.0 alpha:0.5];
    [self.datasource addObject:@"公司通知"];
    [self.datasource addObject:@"规章制度"];
    [self.datasource addObject:@"公司信息"];
    [self.datasource addObject:@"组织架构与通讯录"];
    [self.datasource addObject:@"公司云盘"];
    _examinationAndApprovel = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _examinationAndApprovel.dataSource = self;
    _examinationAndApprovel.delegate = self;
//    examinationAndApprovel.rowHeight = 60;
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        _examinationAndApprovel.rowHeight = 60;
    }else{
        _examinationAndApprovel.rowHeight = 60 * 4 / 5;
    }
    _examinationAndApprovel.scrollEnabled = NO;
    //03设置分割线
    //    examinationAndApprovel.separatorColor = [UIColor orangeColor];
    _examinationAndApprovel.sectionHeaderHeight =  [UIScreen mainScreen].bounds.size.width * 2 /3;
//    [examinationAndApprovel registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [_examinationAndApprovel registerClass:[CompanyTableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:_examinationAndApprovel];
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
        //if语句中可以为单元格中一些通用的属性赋值，例如可以在其辅助视图类型赋值,标示所有单元格都一直
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLabel.text = self.datasource[indexPath.row];
    if (indexPath.row == 0 && [self.datasourceRedpoint[0] intValue] > 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[0]];
        cell.nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row == 0 && [self.datasourceRedpoint[0] intValue] == 0 ) {
        cell.nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        cell.nameShorthandLabel.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc ] init];
//    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
//    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    punchCLockImageTileButton.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
//    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
//    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"everyday_1"] forState:UIControlStateNormal];
//    [view addSubview:punchCLockImageTileButton];
    
    UIImageView * imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3)];
    [imageViewHeader setImage:[UIImage imageNamed:@"everyday_1"]];
    [self.view addSubview:imageViewHeader];
    
    return  view ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
          CompanyNoticeViewController * companyNoticeVC = [CompanyNoticeViewController new];
          [self.navigationController pushViewController:companyNoticeVC animated:YES];
        } else if (indexPath.row == 1) {
            CompanyBylawsViewController * companyBylawsVC = [CompanyBylawsViewController new];
            companyBylawsVC.transmitTitleLabel = @"规章制度";
            [self.navigationController pushViewController:companyBylawsVC animated:YES];
        } else if (indexPath.row == 2) {
//            CompanyinformationAndBylawsViewController * companyBylawsVC = [CompanyinformationAndBylawsViewController new];
//            companyBylawsVC.transmitTitleLabel = @"公司信息";
//            [self.navigationController pushViewController:companyBylawsVC animated:YES];
            RulesDetailViewController * detailVC = [[RulesDetailViewController alloc] init];
            detailVC.urlStr = [NSString stringWithFormat:@"http://qqoatest.youth.cn/v1/api/company/index"];
            if (detailVC.urlStr.length >0 ) {
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        } else if (indexPath.row == 3) {
            CompanyOrganizationalStructureViewController * organizationalStructurehVC = [CompanyOrganizationalStructureViewController new];
            [self.navigationController pushViewController:organizationalStructurehVC animated:YES];
        } else if (indexPath.row == 4) {
//            LanchViewController * lanchVC = [LanchViewController new];
//            [self.navigationController pushViewController:lanchVC animated:YES];
            [self alert:@"开发中、、、"];
        } else{
            LanchViewController * lanchVC = [LanchViewController new];
            [self.navigationController pushViewController:lanchVC animated:YES];
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

-(void)getStartTimerAboutRedPoint{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getRedpointOfNoticeFromServer) userInfo:nil repeats:YES];
}

-(void)getRedpointOfNoticeFromServer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/message/unread", CONST_SERVER_ADDRESS]];
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
                                                NSLog(@"Noticeredpoint服务器返回错误：%@", error);
                                            }else {
                                                
                                                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                if ( [object isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Notice出现异常，服务器约定为字典类型");
                                                }else if ([object isKindOfClass:[NSDictionary class]]){
//                                                    NSLog(@"Noticeredpoint字典%@", object);
                                                    if ([[object objectForKey:@"message"] intValue] != 20001 ) {
                                                        NSLog(@"Notice服务获得到数据，但是数据异常");
                                                    }else {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                NSString * str = [NSString stringWithFormat:@"%@", [object objectForKey:@"messagesUnreadTotalNum"]];
                                                                [self.datasourceRedpoint removeAllObjects];
                                                                [self.datasourceRedpoint addObject:str];
                                                                [self.examinationAndApprovel reloadData];
                                                        });
                                                    }
                                                }
                                            }
                                        }];
    [task resume];
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
