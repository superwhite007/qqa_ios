//
//  Readunread.h
//  QQA
//
//  Created by wang huiming on 2018/6/5.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Readunread : NSObject

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * isRead;

-(instancetype)initWithUsername:(NSString *)username
                 isRead:(NSString *)isRead;

@end
