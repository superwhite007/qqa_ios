//
//  ACPApproval.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApproval.h"

@implementation ACPApproval

-(instancetype)initWithusername:(NSString *)username department:(NSString *)department created_at:(NSString *)created_at type:(NSString *)type status:(NSString *)status leave_id:(NSString *)leave_id{
    self = [super init];
    if (self) {
        self.username = username;
        self.department = department;
        self.created_at = created_at;
        self.type = type;
        self.status = status;
        self.leave_id = leave_id;
    }
    return self;
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"获取的部分字段无意义");
    
}

@end
