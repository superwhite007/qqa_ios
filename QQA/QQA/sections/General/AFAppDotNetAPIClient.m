//
//  AFAppDotNetAPIClient.m
//  ITInformation2514
//
//  Created by laouhn on 15/7/20.
//  Copyright (c) 2015年 whm. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation AFAppDotNetAPIClient
+ (instancetype)sharedClient
{
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前网络情况"
                                                                    message:@"2g/3g/4g连接"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前网络情况"
                                                                    message:@"wifi连接"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络情况"
                                                                    message:@"网络连接不可用"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });
    
    return _sharedClient;

}

@end
