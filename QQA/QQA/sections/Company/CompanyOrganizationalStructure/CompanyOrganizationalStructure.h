//
//  CompanyOrganizationalStructure.h
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyOrganizationalStructure : NSObject

@property (nonatomic, strong) NSString * departmentId;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDepartmentId:(NSString *)departmentId
                               name:(NSString *)name;


@end
