//
//  AppTBViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppTBViewController.h"

#import "PunchClockViewController.h"
#import "MeViewController.h"


@interface AppTBViewController ()

@end

@implementation AppTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllChildViewControllers];
    
    
}


//初始化所有的控制器
- (void)setupAllChildViewControllers{
    
    //1.公司
    MeViewController *homePageVC = [[MeViewController alloc] init];
    [self setupChildViewController:homePageVC title:@"公司" imageName:@"first_ll" selectedImageName:@"first_h"];
    
    
    //2.审核
    MeViewController *allStyleViewController = [MeViewController new] ;
    [self setupChildViewController:allStyleViewController title:@"审核" imageName:@"styles" selectedImageName:@"styles_h"];
    
    
    //3.打卡
    PunchClockViewController *punchClockVC = [PunchClockViewController new];
    [self setupChildViewController:punchClockVC title:@"打卡" imageName:@"oversea_n" selectedImageName:@"oversea"];
    
    
    //4.我
    MeViewController *meVC = [[MeViewController alloc] init];
    [self setupChildViewController:meVC title:@"我" imageName:@"account" selectedImageName:@"me_normal"];
    
    self.viewControllers = [NSArray arrayWithObjects:homePageVC, allStyleViewController, punchClockVC, meVC, nil];

    self.selectedViewController = [self.viewControllers objectAtIndex:2];
    
}


- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    //2.包装一个导航控制器
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
 
    
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
