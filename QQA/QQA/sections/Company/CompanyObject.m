//
//  CompanyObject.m
//  QQA
//
//  Created by wang huiming on 2017/11/8.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyObject.h"

@implementation CompanyObject

-(instancetype)initWithImg:(NSString *)img title:(NSString *)title{
    
    self = [super init];
    if (self) {
        self.img = img;
        self.title = title;
    }
    return self;
    
}

-(void)setValue:(id)value forKey:(NSString *)key{
    //当key值不存在的时候走
    
}


@end
