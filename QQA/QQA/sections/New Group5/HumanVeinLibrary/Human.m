//
//  Human.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "Human.h"

@implementation Human

-(instancetype)initWithHumanName:(NSString *)name content:(NSString *)content isShow:(NSString *)isShow connectionId:(NSString *)connectionId{
    self = [super init];
    if (self) {
        self.name = name;
        self.content = content;
        self.isShow = isShow;
        self.connectionId = connectionId;
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"human：部分字段无意义");
}

@end
