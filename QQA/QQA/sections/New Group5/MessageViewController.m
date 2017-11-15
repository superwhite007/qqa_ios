//
//  MessageViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/15.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UILabel *aLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
//    aLable.text = @"发送通知";
////    aLable.textColor = [UIColor blueColor];
//    aLable.textAlignment = NSTextAlignmentCenter;
//    aLable.font = [UIFont italicSystemFontOfSize:17];
//
//    self.navigationItem.titleView = aLable;
    [self.navigationItem setTitle:@"发送通知"];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送范围" style:(UIBarButtonItemStyleDone) target:self action:@selector(changcolor)];
    
    UITextField * reasonTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, iphoneWidth - 20, iphoneWidth * 2 / 3)];
    reasonTextField.backgroundColor = [UIColor redColor];
//    reasonTextField
    [self.view addSubview:reasonTextField];
    
    UIButton  * sendButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [sendButton setFrame:CGRectMake( 30 + (iphoneWidth - 40) * 5 / 6,  reasonTextField.frame.size.height + 84, (iphoneWidth - 40) / 6, 30)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    sendButton.titleLabel.font = [UIFont systemFontOfSize:24];
    sendButton.backgroundColor = [UIColor blueColor];
    
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [welcomeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sendButton];
    
    
    
    
    
}

-(void)changcolor{
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
