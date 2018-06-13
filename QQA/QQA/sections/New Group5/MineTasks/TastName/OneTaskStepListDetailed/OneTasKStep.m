//
//  OneTasKStep.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneTasKStep.h"

@implementation OneTasKStep

-(instancetype)initWithtitle:(NSString *)title describe:(NSString *)describe commentNumber:(NSString *)commentNumber subtaskId:(NSString *)subtaskId isRename:(BOOL)isRename isCompleted:(BOOL)isCompleted isDeleted:(BOOL)isDeleted isUpdated:(BOOL)isUpdated{
    self = [super init];
    if (self) {
        self.title = title;
        self.describe = describe;
        self.commentNumber = commentNumber;
        self.subtaskId = subtaskId;
        self.isRename = isRename;
        self.isCompleted = isCompleted;
        self.isDeleted = isDeleted;
        self.isUpdated = isUpdated;
    }
    return self;
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //    NSLog(@"Some key is not existence");
}

@end
