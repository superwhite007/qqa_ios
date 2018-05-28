//
//  Human.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject

@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *somePeopleCreateTime;
@property (nonatomic, strong) NSString *jurisdiction;

-(instancetype)initWithHumanName:(NSString *)humanName
            somePeopleCreateTime:(NSString *)somePeopleCreateTime
                    jurisdiction:(NSString *)jurisdiction;

@end
