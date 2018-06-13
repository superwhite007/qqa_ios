//
//  StepDetailCommunicationListVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "StepDetailCommunicationListVC.h"

@interface StepDetailCommunicationListVC ()

@end

@implementation StepDetailCommunicationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self.navigationItem setTitle:@"任务交流"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addTaskCommunication)];
    
}

-(void)addTaskCommunication{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
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
