//
//  WorkOrder.h
//  QQA
//
//  Created by wang huiming on 2018/8/7.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkOrder : NSObject
/*
 content = "\U5de5\U5355\U5185\U5bb91";
 describe = "\U6280\U672f\U5f00\U53d1\U4e2d\U5fc3 \U9b4f\U658c\U521b\U5efa\U4e8e20180808";
 isEdit = 1;
 isFinished = 0;
 title = "\U65b0\U5efa\U5de5\U53551";
 unreadCommentNum = 0;
 workListId = 2;
*/
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * describe;
@property (nonatomic, strong) NSString * unreadCommentNum;
@property (nonatomic, strong) NSString * isFinished;

@property (nonatomic, strong) NSString * workListId;
@property (nonatomic, strong) NSString * isEdit;

-(instancetype)initWithTitle:(NSString *)title
                     content:(NSString *)content
                    describe:(NSString *)describe
            unreadCommentNum:(NSString *)unreadCommentNum
                  isFinished:(NSString *)isFinished
                  workListId:(NSString *)workListId
                      isEdit:(NSString *)isEdit;

@end
