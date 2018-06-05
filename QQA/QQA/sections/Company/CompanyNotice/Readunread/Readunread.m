//
//  Readunread.m
//  QQA
//
//  Created by wang huiming on 2018/6/5.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "Readunread.h"

@implementation Readunread

-(instancetype)initWithUsername:(NSString *)username isRead:(NSString *)isRead{
    self = [super init];
    if (self) {
        self.username = username;
        self.isRead = isRead;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"无值");
}
@end
