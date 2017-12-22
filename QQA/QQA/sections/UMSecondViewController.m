//
//  UMSecondViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/22.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "UMSecondViewController.h"

@interface UMSecondViewController ()

@property (nonatomic,strong)  UIWebView *webview;

@end

@implementation UMSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.webview setScalesPageToFit:YES];
    [self.view addSubview:self.webview];
    NSURL *url = [NSURL URLWithString:self.url];
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];

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
