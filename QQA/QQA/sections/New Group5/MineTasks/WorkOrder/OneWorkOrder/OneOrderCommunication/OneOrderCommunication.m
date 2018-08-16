//
//  OneOrderCommunication.m
//  QQA
//
//  Created by wang huiming on 2018/8/16.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCommunication.h"

@implementation OneOrderCommunication
-(instancetype)initWithimg:(NSString *)img content:(NSString *)content describe:(NSString *)describe{
    self = [super init];
    if (self) {
        self.img = img;
        self.content = content;
        self.describe = describe;
    }
    return  self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
