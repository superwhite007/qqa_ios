//
//  StepDetailCommunication.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepDetailCommunication : NSObject

@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * describe;

-(instancetype)initWithImgUrl:(NSString *)imgUrl
                      content:(NSString *)content
                     describe:(NSString *)describe;

@end
