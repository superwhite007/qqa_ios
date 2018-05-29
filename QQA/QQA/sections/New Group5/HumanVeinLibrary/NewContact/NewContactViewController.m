//
//  NewContactViewController.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "NewContactViewController.h"

@interface NewContactViewController ()

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"新建联系人"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(ensure)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((iphoneWidth - 100)/2, 10, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"new_contact"]];
    [self.view addSubview:imageView];
    
    // Do any additional setup after loading the view.
}
-(void)ensure{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
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
