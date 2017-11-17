//
//  IInitiated.h
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IInitiated : NSObject

@property (nonatomic, strong) NSString * imageStr;
@property (nonatomic, strong) NSString * reasonTitleStr;
@property (nonatomic, strong) NSString * reasonStr;
@property (nonatomic, strong) NSString * promptStr;

-(instancetype)initWithimageStr:(NSString *)imagestr
                 reasonTitleStr:(NSString *)reasonTitleStr
                      reasonStr:(NSString *)reasonStr
                      promptStr:(NSString *)promptStr;



@end
