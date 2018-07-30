//
//  CompanyViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyNoticeViewController.h"
#import "CompanyinformationAndBylawsViewController.h"
#import "CompanyOrganizationalStructureViewController.h"
#import "RulesDetailViewController.h"
#import "CompanyBylawsViewController.h"
#import "CompanyTableViewCell.h"
#import "CycleScrollView.h"

@interface CompanyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) NSMutableArray * cyclePicturesDatasource;
@property (nonatomic, strong) NSMutableArray * datasourceRedpoint;
@property (nonatomic, strong) UITableView * examinationAndApprovel;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic , retain) CycleScrollView *mainScorllView;

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
-(NSMutableArray *)cyclePicturesDatasource{
    if (!_cyclePicturesDatasource) {
        self.cyclePicturesDatasource = [NSMutableArray array];
    }
    return _cyclePicturesDatasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"青青";
    [self.datasourceRedpoint addObject:@"0"];
//    [self getStartTimerAboutRedPoint];
    [self getCycleScrollPitures];

    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

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
    _examinationAndApprovel.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    NSMutableArray *viewsArray = [@[] mutableCopy];
    if (_cyclePicturesDatasource.count > 0) {
        for (int i = 0; i < 3; ++i) {
            NSURL * url = [NSURL URLWithString:_cyclePicturesDatasource[i]];
            NSData * data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
            [viewsArray addObject:imgView];
        }
    } else{
        for (int i = 0; i < 3; ++i) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"everyday_1"]];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
            [viewsArray addObject:imgView];
        }
    }
    
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3 ) animationDuration:1];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 3;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",(long)pageIndex);
    };
    [self.view addSubview:self.mainScorllView];

    
    return  view ;
}

-(void)getCycleScrollPitures{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/company/getImg", CONST_SERVER_ADDRESS]];
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
                                                    if ([[object objectForKey:@"message"] intValue] != 30001 ) {
                                                        NSLog(@"Notice服务获得到数据，但是数据异常");
                                                    }else {
                                                        
                                                        _cyclePicturesDatasource = [[object  objectForKey:@"data"] objectForKey:@"img"];
                                                        NSLog(@"_cyclePicturesDatasource:%@", _cyclePicturesDatasource);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.examinationAndApprovel reloadData];
                                                        });
                                                    }
                                                }
                                            }
                                        }];
    [task resume];
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
            detailVC.urlStr = [NSString stringWithFormat:@"%@/v1/api/company/index", CONST_SERVER_ADDRESS];
            if (detailVC.urlStr.length >0 ) {
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        } else if (indexPath.row == 3) {
            CompanyOrganizationalStructureViewController * organizationalStructurehVC = [CompanyOrganizationalStructureViewController new];
            [self.navigationController pushViewController:organizationalStructurehVC animated:YES];
        } else if (indexPath.row == 4) {
            [self alert:@"开发中、、、"];
        } else{
           
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
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(getRedpointOfNoticeFromServer) userInfo:nil repeats:YES];
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
