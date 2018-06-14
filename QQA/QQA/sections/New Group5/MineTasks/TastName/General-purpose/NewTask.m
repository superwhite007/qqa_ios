//
//  NewTask.m
//  QQA
//
//  Created by wang huiming on 2018/6/14.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "NewTask.h"

@implementation NewTask

-(instancetype)initNewTaskSendToServerWithpatternStr:(NSString *)patternStr typeStr:(NSString *)typeStr departmentIdStr:(NSString *)departmentIdStr titleStr:(NSString *)titleStr{
    self = [super init];
    if (self) {
        self.patternStr = patternStr;
        self.typeStr = typeStr;
        self.departmentIdStr = departmentIdStr;
        self.titleStr = titleStr;
    }
    return self;
}

-(void)SendNewTaskToServerWithpatternStr:(NSString *)patternStr typeStr:(NSString *)typeStr departmentIdStr:(NSString *)departmentIdStr titleStr:(NSString *)titleStr{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/create", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    [mdict setObject:patternStr forKey:@"pattern"];
    [mdict setObject:typeStr forKey:@"type"];
    [mdict setObject:departmentIdStr forKey:@"departmentId"];
    [mdict setObject:titleStr forKey:@"title"];
    NSLog(@"4321234567%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"4321234567:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60008) {
                                                        NSLog(@"成功0987654321！");
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                NSLog(@"HUMan5获取数据失败，问gitPersonPermissions");
                                            }
                                        }];
    [task resume];
}


@end
