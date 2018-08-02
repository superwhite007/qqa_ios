//
//  WorkOrderNameListVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderNameListVC.h"
#import "OneOrderVC.h"

@interface WorkOrderNameListVC ()

@end
@implementation WorkOrderNameListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"工单列表"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(gotoOneOrderVC)];
}

-(void)gotoOneOrderVC{
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
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
