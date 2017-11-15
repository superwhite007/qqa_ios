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
    
    [self.navigationItem setTitle:@"发送消息"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送范围" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    
    UITextView * messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, iphoneWidth - 20, iphoneWidth * 2 / 3)];
    messageTextView.backgroundColor = [UIColor blueColor];
    messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:messageTextView];
    
    
    
    UIButton  * sendButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [sendButton setFrame:CGRectMake(  iphoneWidth - 110,  messageTextView.frame.size.height + 84, 100, 30)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    sendButton.titleLabel.font = [UIFont systemFontOfSize:24];
    sendButton.backgroundColor = [UIColor blueColor];
    
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [welcomeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sendButton];
    
    
    
    
    
}


-(void)chageColor{
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
