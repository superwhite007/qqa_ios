//
//  CompanyinformationAndBylawsViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyinformationAndBylawsViewController.h"
#import "RulesDetailViewController.h"

@interface CompanyinformationAndBylawsViewController ()

@end

@implementation CompanyinformationAndBylawsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    RulesDetailViewController * detailVC = [[RulesDetailViewController alloc] init];
    detailVC.urlStr = [NSString stringWithFormat:@"%@/v1/api/company/index", CONST_SERVER_ADDRESS];
    if (detailVC.urlStr.length >0 ) {
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
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
