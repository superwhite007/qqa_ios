//
//  AFAppDotNetAPIClient.h
//  ITInformation2514
//
//  Created by laouhn on 15/7/20.
//  Copyright (c) 2015年 whm. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
