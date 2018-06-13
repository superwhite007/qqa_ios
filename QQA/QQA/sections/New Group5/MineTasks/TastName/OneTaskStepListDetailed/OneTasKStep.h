//
//  OneTasKStep.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneTasKStep : NSObject

/*
 
 commentNumber = "<null>";
 describe = "\U9b4f\U658c\U521b\U5efa\U4e8e2018\U5e7406\U670813\U65e5";
 isCompleted = 0;
 isDeleted = 1;
 isRename = 1;
 isUpdated = 1;
 subtaskId = 6;
 title = "\U5de6\U53f3\U91ce\U9a6c\U5206\U9b03";

*/
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * describe;
@property (nonatomic, strong) NSString * commentNumber;
@property (nonatomic, strong) NSString * subtaskId;

@property (nonatomic, assign) BOOL isRename; //display a alert
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, assign) BOOL isUpdated;

-(instancetype)initWithtitle:(NSString *)title
                     describe:(NSString *)describe
                commentNumber:(NSString *)commentNumber
                       subtaskId:(NSString *)subtaskId
                     isRename:(BOOL)isRename
                  isCompleted:(BOOL)isCompleted
                    isDeleted:(BOOL)isDeleted
                    isUpdated:(BOOL)isUpdated;
@end
