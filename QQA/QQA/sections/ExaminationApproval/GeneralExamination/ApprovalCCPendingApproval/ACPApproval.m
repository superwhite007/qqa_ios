//
//  ACPApproval.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApproval.h"

@implementation ACPApproval

-(instancetype)initWithPeopeleImgStr:(NSString *)peopleImgStr peopleNameStr:(NSString *)peopleNameStr byTheTimeStr:(NSString *)byTheTimeStr typeStr:(NSString *)typeStr startTimeStr:(NSString *)startTimeStr endTimeStr:(NSString *)endTimeStr statusEexaminationAndApprovalStr:(NSString *)statusEexaminationAndApprovalStr{
    self = [super init];
    if (self) {
        self.peopleImgStr = peopleImgStr;
        self.peopleNameStr = peopleNameStr;
        self.byTheTimeStr = byTheTimeStr;
        self.typeStr = typeStr;
        self.startTimeStr = startTimeStr;
        self.endTimeStr = endTimeStr;
        self.statusEexaminationAndApprovalStr = statusEexaminationAndApprovalStr;
    }
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"获取的部分字段无意义");
    
}

@end
