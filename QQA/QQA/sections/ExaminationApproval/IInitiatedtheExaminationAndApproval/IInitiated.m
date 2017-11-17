//
//  IInitiated.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiated.h"

@implementation IInitiated

-(instancetype)initWithimageStr:(NSString *)imagestr reasonTitleStr:(NSString *)reasonTitleStr reasonStr:(NSString *)reasonStr promptStr:(NSString *)promptStr forwardImageStr:(NSString *)forwardImageStr{
    self = [super init];
    if (self) {
        self.imageStr = imagestr;
        self.reasonTitleStr = reasonTitleStr;
        self.reasonStr = reasonStr;
        self.promptStr = promptStr;
        self.forwardImageStr = forwardImageStr;
    }
    return  self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"key is NULL :%@", key);
}

@end
