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
#import "CompanyViewController.h"


#import "UMFirstViewController.h"
#import "UMSecondViewController.h"

@interface AppTBViewController ()

@end

@implementation AppTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllChildViewControllers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:) name:@"userInfoNotification" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:) name:@"userInfoNotification" object:nil];
}
-(void)userInfoNotification:(NSNotification*)notification{
    
    NSDictionary *dict = [notification userInfo];
    NSString *type=[dict valueForKey:@"type"];
    NSLog(@"typetypetype:%@ dict:%@", type, dict);
//    if ([type isEqualToString:@"url"]) {
//        UMSecondViewController *secondvc=[[UMSecondViewController alloc]init];
//        secondvc.url=[dict valueForKey:@"content"];
//        [self.navigationController pushViewController:secondvc animated:YES];
//    }else if ([type isEqualToString:@"home"])
//    {
        UMFirstViewController *firstvc=[[UMFirstViewController alloc]init];
        //firstvc.url=[aps valueForKey:@"content"];
        [self.navigationController pushViewController:firstvc animated:YES];
//    }else if ([type isEqualToString:@"userinfo"])
//    {
//
//    };
    
}


//初始化所有的控制器
- (void)setupAllChildViewControllers{
    //1.公司
    CompanyViewController * companyVC = [[CompanyViewController alloc] init];
    [self setupChildViewController:companyVC title:@"公司" imageName:@"home_normal" selectedImageName:@"home_normal"];
    //2.审核
    ExaminationApprovalViewController * examinationApprovalVC = [[ExaminationApprovalViewController alloc] init];
    [self setupChildViewController:examinationApprovalVC title:@"审核" imageName:@"checkmark" selectedImageName:@"checkmark"];
    //3.打卡
    PunchClockViewController *punchClockVC = [PunchClockViewController new];
    [self setupChildViewController:punchClockVC title:@"打卡" imageName:@"clockin_normal" selectedImageName:@"clockin_normal"];
    //4.我
    MeInformationViewController *meVC = [[MeInformationViewController alloc] init];
    [self setupChildViewController:meVC title:@"我" imageName:@"me_normal" selectedImageName:@"me_normal"];
    self.viewControllers = [NSArray arrayWithObjects:companyVC, examinationApprovalVC, punchClockVC, meVC, nil];
    self.selectedViewController = [self.viewControllers objectAtIndex:1];
}


- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //2.包装一个导航控制器
//    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
//    [self addChildViewController:nav];
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
