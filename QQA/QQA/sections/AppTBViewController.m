//
//  AppTBViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppTBViewController.h"

#import "PunchClockViewController.h"
#import "MeInformationViewController.h"
#import "ExaminationApprovalViewController.h"
#import "ExaminationApprovalViewControllerNOCell.h"
#import "CompanyViewController.h"
#import "CompanyViewControllerNoCell.h"
#import "UMFirstViewController.h"
#import "UMSecondViewController.h"
#import "AppDelegate.h"
#import "AppCoverViewController.h"
#import "TaskVC.h"
#import "OneTaskDetailedListVC.h"
#import "StepDetailCommunicationListVC.h"

#import "WorkOrderNameLIstsViewController.h"
#import "OneOrderVC.h"
#import "OneOrderCommunicationVController.h"

@interface AppTBViewController ()<UITabBarControllerDelegate>
{
    NSTimer * timer;
    Boolean loginAgain;
}
@end

@implementation AppTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    loginAgain = NO;
    [self getStartTimerAboutRedPoint];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAllChildViewControllers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:) name:@"userInfoNotification" object:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self getRedpointFromServer];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:) name:@"userInfoNotification" object:nil];
}
-(void)userInfoNotification:(NSNotification*)notification{
    NSDictionary *dict = [notification userInfo];
    NSLog(@"通知：notification%@", dict);
    UMFirstViewController *firstvc=[[UMFirstViewController alloc]init];
    firstvc.notcieString=[NSString stringWithFormat:@"%@", [[dict objectForKey:@"aps"] objectForKey:@"alert"]];
    if ( [[dict objectForKey:@"type"]  intValue] == 1 ) {
        self.selectedViewController = [self.viewControllers objectAtIndex:0];
    }else if ([[dict objectForKey:@"type"]  intValue] == 2 ){
        self.selectedViewController = [self.viewControllers objectAtIndex:1];
    }else if ([[dict objectForKey:@"type"]  intValue] == 3 ){
        TaskVC * taskVC = [TaskVC new];
        taskVC.mineOrOthersStr = @"自己的任务";
        [self.navigationController pushViewController:taskVC animated:YES];
    }else if ([[dict objectForKey:@"type"]  intValue] == 4 ){
        TaskVC * taskVC = [TaskVC new];
        taskVC.mineOrOthersStr = @"下属任务";
        [self.navigationController pushViewController:taskVC animated:YES];
    }else if ([[dict objectForKey:@"type"]  intValue] == 5 ){
        OneTaskDetailedListVC * oneTaskDetailedListVC = [OneTaskDetailedListVC new];
        oneTaskDetailedListVC.taskIdStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"taskId"]];
        [self.navigationController pushViewController:oneTaskDetailedListVC animated:NO];
    }else if ([[dict objectForKey:@"type"]  intValue] == 6 ){
        StepDetailCommunicationListVC * stepDetailCommunicationListVC = [StepDetailCommunicationListVC new];
        stepDetailCommunicationListVC.subtaskIdStr =[NSString stringWithFormat:@"%@", [dict objectForKey:@"subTaskId"]];
        [self.navigationController pushViewController:stepDetailCommunicationListVC animated:YES];
    }
    NSInteger  typeNumber = [[dict objectForKey:@"type"]  intValue];
    switch (typeNumber) {
        case 7:
            [self gotoWorkOrderVC];
            break;
        case 8:
            [self gotoOneOrder:dict];
            break;
        case 9:
            [self gotoCommunication:dict];
            break;
        default:
            break;
    }
}
-(void)gotoWorkOrderVC{
    WorkOrderNameLIstsViewController * workOrderNameListVC = [WorkOrderNameLIstsViewController new];
    [self.navigationController pushViewController:workOrderNameListVC animated:YES];
}
-(void)gotoOneOrder:(NSDictionary *)dict{
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    oneOrderVC.workListIdStr = [NSMutableString stringWithFormat:@"%@", [dict objectForKey:@"workListId"]];
    oneOrderVC.isEdit = [NSMutableString stringWithFormat:@"%@", [dict objectForKey:@"isEdit"]];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
}
-(void)gotoCommunication:(NSDictionary *)dict{
        OneOrderCommunicationVController * oneOrderCommunicationVController = [OneOrderCommunicationVController new];
        oneOrderCommunicationVController.workListDetailIdSTR = [NSMutableString stringWithFormat:@"%@", [dict objectForKey:@"workListDetailId"]];
        oneOrderCommunicationVController.workListIdSTR = [NSMutableString stringWithFormat:@"%@", [dict objectForKey:@"workListId"]];
        [self.navigationController pushViewController:oneOrderCommunicationVController animated:YES];
}
//初始化所有的控制器
- (void)setupAllChildViewControllers{
    //1.公司
//    CompanyViewController * companyVC = [[CompanyViewController alloc] init];
//    [self setupChildViewController:companyVC title:@"公司" imageName:@"home_normal" selectedImageName:@"home_normal"];
//
    CompanyViewControllerNoCell * companyVC = [[CompanyViewControllerNoCell alloc] init];
    [self setupChildViewController:companyVC title:@"公司" imageName:@"home_normal" selectedImageName:@"home_normal"];
    
    
    //2.审核
//    ExaminationApprovalViewController * examinationApprovalVC = [[ExaminationApprovalViewController alloc] init];
//    [self setupChildViewController:examinationApprovalVC title:@"审核" imageName:@"checkmark" selectedImageName:@"checkmark"];
    ExaminationApprovalViewControllerNOCell * examinationApprovalVC = [[ExaminationApprovalViewControllerNOCell alloc] init];
    [self setupChildViewController:examinationApprovalVC title:@"审核" imageName:@"checkmark" selectedImageName:@"checkmark"];
    //3.打卡
    PunchClockViewController *punchClockVC = [PunchClockViewController new];
    [self setupChildViewController:punchClockVC title:@"打卡" imageName:@"clockin_normal" selectedImageName:@"clockin_normal"];
    //4.我
    MeInformationViewController *meVC = [[MeInformationViewController alloc] init];
    [self setupChildViewController:meVC title:@"我" imageName:@"me_normal" selectedImageName:@"me_normal"];
    self.viewControllers = [NSArray arrayWithObjects:companyVC, examinationApprovalVC, punchClockVC, meVC, nil];
//    self.viewControllers[0].tabBarItem.badgeValue = @"1";
    self.selectedViewController = [self.viewControllers objectAtIndex:1];
}


- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    childVC.tabBarItem.badgeValue = @"1";
    //2.包装一个导航控制器
//    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
//    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getStartTimerAboutRedPoint{
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getRedpointFromServer) userInfo:nil repeats:YES];
}


-(void)getRedpointFromServer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/table/unread", CONST_SERVER_ADDRESS]];
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
            NSLog(@"redpoint服务器返回错误：%@", error);
        }else {
            
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if ( [object isKindOfClass:[NSArray class]] ) {
                NSLog(@"出现异常，服务器约定为字典类型");
            }else if ([object isKindOfClass:[NSDictionary class]]){
//                NSLog(@"redpoint字典%@", object);
                if ([[object objectForKey:@"message"] intValue] != 20003 ) {
                    NSLog(@"服务获得到数据，但是数据异常");
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([[object objectForKey:@"messagesUnreadTotalNum"] intValue] > 0) {
                            self.viewControllers[0].tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", [object objectForKey:@"messagesUnreadTotalNum"]];
                        }else{
                            self.viewControllers[0].tabBarItem.badgeValue = nil;
                        }
                        if ([[object objectForKey:@"leavesUnreadTotalNum"] intValue] > 0) {
                            self.viewControllers[1].tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", [object objectForKey:@"leavesUnreadTotalNum"]];
                        }else{
                            self.viewControllers[1].tabBarItem.badgeValue = nil;
                        }
                    });
                }
            }
        }
    }];
    [task resume];
}

#pragma  mark  判断是否多台设备登录该账号

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(viewController == [tabBarController.viewControllers objectAtIndex:0])
    {
        return YES;
    }else{
        [self checkMoreMobleHadLogined];
        if (loginAgain) {
            [self alertAppCover:@"该账号已登录新设备或已销毁！"];
            return NO;
        } else{
            NSLog(@"第一次登录");
            return YES;
        }
    }
    
}

-(void)checkMoreMobleHadLogined{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/user/app/check", CONST_SERVER_ADDRESS]];
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
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                NSLog(@"HadLogin%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ( [[dataBack objectForKey:@"message"] intValue] == 1005 || [[dataBack objectForKey:@"message"] intValue] == 1006 ) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            loginAgain = YES;
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSLog(@"获取数据失败，问gitPersonPermissions");
                                                }
                                            }else{
                                                
                                            }
                                        }];
    [task resume];
}



-(void)goBbackToAPPcover{
    AppCoverViewController *appCoverVController = [AppCoverViewController new];
    UINavigationController * tbNC = [[UINavigationController alloc] initWithRootViewController:appCoverVController];
    ((AppDelegate *)([UIApplication sharedApplication].delegate)).window.rootViewController = tbNC;
}
-(void)alertAppCover:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"请联系开发人员";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self goBbackToAPPcover];
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
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
