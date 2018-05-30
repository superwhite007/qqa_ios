//
//  Human.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * isShow;
@property (nonatomic, strong) NSString * connectionId;

-(instancetype)initWithHumanName:(NSString *)name
                         content:(NSString *)content
                          isShow:(NSString *)isShow
                          connectionId:(NSString *)connectionId;

@end
