//
//  ACPApproval.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApproval.h"

@implementation ACPApproval

-(instancetype)initWithusername:(NSString *)username department:(NSString *)department type:(NSString *)type createdAt:(NSString *)createdAt leaveId:(NSString *)leaveId status:(NSString *)status{
    self = [super init];
    if (self) {
        self.username = username;
        self.department = department;
        self.createdAt = createdAt;
        self.type = type;
        self.status = status;
        self.leaveId = leaveId;
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    NSLog(@"获取的部分字段无意义");
    
}

@end
