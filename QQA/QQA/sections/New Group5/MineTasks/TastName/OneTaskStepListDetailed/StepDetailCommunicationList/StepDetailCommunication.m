//
//  StepDetailCommunication.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "StepDetailCommunication.h"

@implementation StepDetailCommunication

-(instancetype)initWithImgUrl:(NSString *)imgUrl content:(NSString *)content describe:(NSString *)describe{
    self = [super init];
    if (self) {
        self.imgUrl = imgUrl;
        self.content = content;
        self.describe = describe;
    }
    return  self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
