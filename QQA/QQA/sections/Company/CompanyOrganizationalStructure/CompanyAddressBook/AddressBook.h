//
//  AddressBook.h
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBook : NSObject

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * username;


-(instancetype)initWithUserrId:(NSString *)userId
                      username:(NSString *)username;


@end
