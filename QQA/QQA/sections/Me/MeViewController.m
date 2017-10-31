//
//  MeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/10/31.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MeViewController.h"

//# define iphoneWidth    [[UIScreen mainScreen] bounds].size.width
//# define iphoneHeight    [[UIScreen mainScreen] bounds].size.height


@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, iphoneWidth, iphoneHeight);
    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"app_face2.png"];
    [imgView setImage:image];
    [self.view addSubview:imgView];
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    
    UIButton  * welcomeButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [welcomeButton setFrame:CGRectMake( (iphoneWidth - 100) / 2,  (iphoneHeight - 30) - 100, 100, 30)];
    [welcomeButton setTitle:@"V00.00.01" forState:UIControlStateNormal];
    [welcomeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //    welcomeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    //    welcomeButton.titleLabel.text = @"V00.00.01";
    //    welcomeButton.titleLabel.textColor = [UIColor redColor];
    
    [imgView addSubview:welcomeButton];
    imgView.userInteractionEnabled=YES;
    
    
    
    
    
    // Dispose of any resources that can be recreated.
}



- (void)clicked:(id)sender{
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"事件响应" message:@"我是个照相机！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //    [alert show];
    
//    AppTabBarViewController * appTabBarVC = [[AppTabBarViewController alloc] init];
    //    self.window.rootViewController = appTabBarVC;
    
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
