//
//  CompanyObject.h
//  QQA
//
//  Created by wang huiming on 2017/11/8.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyObject : NSObject

@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithImg:(NSString *)img title:(NSString *)title;







@end
