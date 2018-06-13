//
//  OneTasKStep.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneTasKStep : NSObject

@property (nonatomic, strong) NSString * isRead;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * describe;
@property (nonatomic, strong) NSString * commentNumber;
@property (nonatomic, strong) NSString * taskId;
@property (nonatomic, assign) BOOL isRename; //display a alert

-(instancetype)initWithIsRead:(NSString *)isRead
                        title:(NSString *)title
                     describe:(NSString *)describe
                commentNumber:(NSString *)commentNumber
                       taskId:(NSString *)taskId
                     isRename:(BOOL)isRename;
@end
