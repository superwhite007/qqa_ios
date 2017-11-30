//
//  Request.h
//  QQA
//
//  Created by wang huiming on 2017/11/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (nonatomic, copy) NSString * username;
//@property (nonatomic, copy) NSString * department;
//@property (nonatomic, copy) NSString * createdAt;
//@property (nonatomic, copy) NSString * status;
//@property (nonatomic, copy) NSString * askId;

-(instancetype)initWithusername:(NSString *)username;
//                     department:(NSString *)department
//                      createdAt:(NSString *)createdAt
//                        askId:(NSString *)askId
//                         status:(NSString *)status;

@end
