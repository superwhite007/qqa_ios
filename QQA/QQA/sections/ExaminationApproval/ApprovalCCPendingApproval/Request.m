//
//  Request.m
//  QQA
//
//  Created by wang huiming on 2017/11/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "Request.h"

@implementation Request

-(instancetype)initWithusername:(NSString *)username department:(NSString *)department  createdAt:(NSString *)createdAt askId:(NSString *)askId status:(NSString *)status{
    self = [super init];
    if (self) {
        self.username = username;
        self.department = department;
        self.createdAt = createdAt;
        self.askId = askId;
        self.status = status;
    }
    return self;
}



//-(instancetype)initWithusername:(NSString *)username{
//    self = [super init];
//    if (self) {
//        self.username = username;
//    }
//    return self;
//}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//        NSLog(@"获取的部分字段无意义");
    
}





@end
