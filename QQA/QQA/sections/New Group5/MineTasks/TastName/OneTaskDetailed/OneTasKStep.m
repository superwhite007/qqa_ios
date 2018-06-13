//
//  OneTasKStep.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneTasKStep.h"

@implementation OneTasKStep

-(instancetype)initWithIsRead:(NSString *)isRead title:(NSString *)title describe:(NSString *)describe commentNumber:(NSString *)commentNumber taskId:(NSString *)taskId isRename:(BOOL)isRename{
    self = [super init];
    if (self) {
        self.isRead = isRead;
        self.title = title;
        self.describe = describe;
        self.commentNumber = commentNumber;
        self.taskId = taskId;
        self.isRename = isRename;
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //    NSLog(@"Some key is not existence");
}

@end
