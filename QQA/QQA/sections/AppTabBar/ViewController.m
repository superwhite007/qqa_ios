//
//  ViewController.m
//  QQA
//
//  Created by wang huiming on 2017/10/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ViewController.h"
#import "MeViewController.h"


@interface ViewController ()<UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewCOntrollers];
    
    // Do any additional setup after loading the view.
}


-(void)setupAllChildViewCOntrollers{
    
    //me
    MeViewController * meVC1 = [[MeViewController alloc] init];
    [self setupChildViewController:meVC1 title:@"me1" imageName:@"account" selectedImageName:@"me_normal"];
    
    
    //me
    MeViewController * meVC2 = [[MeViewController alloc] init];
    [self setupChildViewController:meVC2 title:@"me2" imageName:@"account" selectedImageName:@"me_normal"];
    //me
    MeViewController * meVC3 = [[MeViewController alloc] init];
    [self setupChildViewController:meVC3 title:@"me3" imageName:@"account" selectedImageName:@"me_normal"];
    //me
    MeViewController * meVC = [[MeViewController alloc] init];
    [self setupChildViewController:meVC title:@"me" imageName:@"account" selectedImageName:@"me_normal"];
    

}

- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    //2.包装一个导航控制器
    //childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
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
