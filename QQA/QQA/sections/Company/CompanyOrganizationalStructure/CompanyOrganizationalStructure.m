//
//  CompanyOrganizationalStructure.m
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyOrganizationalStructure.h"

@implementation CompanyOrganizationalStructure

-(instancetype)initWithDepartmentId:(NSString *)departmentId name:(NSString *)name{
    self = [super init];
    if (self) {
        self.departmentId = departmentId;
        self.name = name;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
//    NSLog(@"");
    
}

@end
