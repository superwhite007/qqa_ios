//
//  AddressBook.m
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AddressBook.h"

@implementation AddressBook


-(instancetype)initWithUserrId:(NSString *)userId username:(NSString *)username{
    self = [super init];
    if (self) {
        self.userId = userId;
        self.username = username;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
