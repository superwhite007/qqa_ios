//
//  AppViewController.m
//  QQA
//
//  Created by wang huiming on 2017/10/31.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppViewController.h"


# define iphoneWidth    [[UIScreen mainScreen] bounds].size.width
# define iphoneHeight    [[UIScreen mainScreen] bounds].size.height

@interface AppViewController ()

@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView  * appView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    appView.backgroundColor = [UIColor colorWithRed:.9 green:.7 blue:.7 alpha:.8];
    [self.view addSubview:appView];
    
    
    
    
    
    
    
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
