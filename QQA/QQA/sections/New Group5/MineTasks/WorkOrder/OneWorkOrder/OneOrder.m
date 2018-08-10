//
//  OneOrder.m
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrder.h"

@implementation OneOrder
-(instancetype)initWithExecutorImg:(NSString *)executorImg executorName:(NSString *)executorName content:(NSString *)content describe:(NSString *)describe unreadCommentNum:(NSString *)unreadCommentNum isFinished:(NSString *)isFinished isAddExecutor:(NSString *)isAddExecutor{
    self = [super init];
    if (self) {
        self.executorImg = executorImg;
        self.executorName = executorName;
        self.content = content;
        self.describe = describe;
        self.unreadCommentNum = unreadCommentNum;
        self.isFinished = isFinished;
        self.isAddExecutor = isAddExecutor;
        
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
