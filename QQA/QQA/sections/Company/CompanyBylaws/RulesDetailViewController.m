//
//  RulesDetailViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/16.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RulesDetailViewController.h"

@interface RulesDetailViewController ()

@end

@implementation RulesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    CGRect bouds = [[UIScreen mainScreen] bounds];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:bouds];
    [self.view addSubview:webView];
    NSURL * url = [NSURL URLWithString:_urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

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
