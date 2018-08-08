//
//  WorkOrder.m
//  QQA
//
//  Created by wang huiming on 2018/8/7.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrder.h"

@implementation WorkOrder

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content describe:(NSString *)describe unreadCommentNum:(NSString *)unreadCommentNum isFinished:(NSString *)isFinished workListId:(NSString *)workListId isEdit:(NSString *)isEdit{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.describe = describe;
        self.unreadCommentNum = unreadCommentNum;
        self.isFinished = isFinished;
        self.workListId = workListId;
        self.isEdit = isEdit;
    }
    return  self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
