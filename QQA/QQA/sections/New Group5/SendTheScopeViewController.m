//
//  SendTheScopeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/21.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "SendTheScopeViewController.h"

@interface SendTheScopeViewController ()

@end

@implementation SendTheScopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"发送范围"];
    
    NSLog(@"_sendMessag_sendMessag:%@", _sendMessage);
    
    
}

-(void)gitMessageAboutGiveNotices{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/message/scope"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    
    NSLog(@"resultDic, resultDicAccess:%@, %@", resultDic, resultDicAccess);
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            //                                            NSLog(@"response, error :%@, %@", response, error);
                                            //                                            NSLog(@"data:%@", data);
                                            
                                            if (data != nil) {
                                                
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"MessageViewControllerdict: %@", dict);
                                                NSMutableArray * array = dict[@"departments"];
                                                
                                                
                                                
                                                
                                                //                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                ////                                                    [self  gitSomeThingsdictionary:dict];
                                                //
                                                //                                                });
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
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
