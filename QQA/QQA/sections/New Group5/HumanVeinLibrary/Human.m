//
//  Human.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "Human.h"

@implementation Human

-(instancetype)initWithHumanName:(NSString *)humanName somePeopleCreateTime:(NSString *)somePeopleCreateTime jurisdiction:(NSString *)jurisdiction{
    self = [super init];
    if (self) {
        self.humanName = humanName;
        self.somePeopleCreateTime = somePeopleCreateTime;
        self.jurisdiction = jurisdiction;
    }
    return  self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"human：部分字段无意义");
}

@end
