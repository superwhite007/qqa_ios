//
//  LeaveForExaminationAndApprovalViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/20.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "LeaveForExaminationAndApprovalViewController.h"

@interface LeaveForExaminationAndApprovalViewController ()

@end

@implementation LeaveForExaminationAndApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * introducePersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 60)];
    introducePersonLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:introducePersonLabel];
    
    for (int i = 0; i < 3 ; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 144 + i * 55, iphoneWidth - 40, 50)];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
    }
    
    UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 314, 100, 50)];
    reasonTitleLabel.text = @"reason";
    reasonTitleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:reasonTitleLabel];
    
    
    
    
    
    
    
    
    
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
