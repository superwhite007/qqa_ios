//
//  HumanDetailVC.m
//  QQA
//
//  Created by wang huiming on 2018/5/31.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanDetailVC.h"

@interface HumanDetailVC ()

@property(nonatomic, strong) UIView * headerView;

@end

@implementation HumanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"人脉库"];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, 170)];
    _headerView.backgroundColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    [self.view addSubview:_headerView];
    
}
-(void)addHeaderView{
   
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
