//
//  ACPApproval.h
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPApproval : NSObject

@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * department;
@property (nonatomic, copy) NSString * createdAt;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * leaveId;

-(instancetype)initWithusername:(NSString *)username
                     department:(NSString *)department
                           type:(NSString *)type
                      createdAt:(NSString *)createdAt
                        leaveId:(NSString *)leaveId
                         status:(NSString *)status;



@end
