//
//  OneOrder.h
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneOrder : NSObject

/*
 content = "\U5de5\U5355\U5177\U4f53\U4efb\U52a11";
 describe = "\U9b4f\U658c\U521b\U5efa\U4e8e20180808";
 executorImg = "\U6682\U65e0";
 executorName = "\U6682\U65e0";
 isAddExecutor = 0;
 isFinished = 0;
 unreadCommentNum = 0;
 

 content = Test33;
 describe = "\U9b4f\U658c\U521b\U5efa\U4e8e20180809";
 executorImg = "\U6682\U65e0";
 executorName = "\U6682\U65e0";
 isAddExecutor = 1;
 isFinished = 0;
 isUpdateStatus = 1;
 unreadCommentNum = 0;
 workListDetailId = 15;
 }

*/

@property (nonnull, strong) NSString * executorImg;
@property (nonnull, strong) NSString * executorName;
@property (nonnull, strong) NSString * content;
@property (nonnull, strong) NSString * describe;
@property (nonnull, strong) NSString * unreadCommentNum;
@property (nonnull, strong) NSString * isFinished;
@property (nonnull, strong) NSString * isAddExecutor;
@property (nonnull, strong) NSString * isUpdateStatus;
@property (nonnull, strong) NSString * workListDetailId;
@property (nonnull, strong) NSString * isCreateComment;


-(instancetype)initWithExecutorImg:(NSString *)executorImg
                      executorName:(NSString *)executorName
                           content:(NSString *)content
                          describe:(NSString *)describe
                  unreadCommentNum:(NSString *)unreadCommentNum
                        isFinished:(NSString *)isFinished
                     isAddExecutor:(NSString *)isAddExecutor
                    isUpdateStatus:(NSString *)isUpdateStatus
                  workListDetailId:(NSString *)workListDetailId
                   isCreateComment:(NSString *)isCreateComment;


@end
