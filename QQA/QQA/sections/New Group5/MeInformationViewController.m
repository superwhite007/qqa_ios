//
//  MeInformationViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MeInformationViewController.h"

@interface MeInformationViewController ()

@end

@implementation MeInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    [self punchRecoret];
    
}


-(void)punchRecoret{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/attendance/index"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    
    [mdict setObject:@"1" forKey:@"pageNum"];
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
                                                
                                                NSArray *array1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSMutableArray * array = [[NSMutableArray alloc] initWithArray:array1];
                                                
                                                NSDictionary * firDict = array[0];
                                                NSString * str  = [NSString stringWithFormat:@"%@", [firDict objectForKey:@"message"]];
                                                if ([str isEqualToString:@"3004" ]) {
                                                    
                                                    [array removeObjectAtIndex:0];
                                                    
                                                    //                                                    NSLog(@"PunchRecord1:%@", array);
                                                    
//                                                    self.datasource = array;
//
//                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        self.datasource = array;
//                                                        [self.aTableView reloadData];
//
//                                                    });
                                                    
                                                }
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问李鹏");
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
