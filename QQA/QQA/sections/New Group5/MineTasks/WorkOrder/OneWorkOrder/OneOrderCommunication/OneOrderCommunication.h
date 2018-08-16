//
//  OneOrderCommunication.h
//  QQA
//
//  Created by wang huiming on 2018/8/16.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneOrderCommunication : NSObject
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * describe;

-(instancetype)initWithimg:(NSString *)img
                      content:(NSString *)content
                     describe:(NSString *)describe;
@end
