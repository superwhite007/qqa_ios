//
//  ACPApproval.h
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPApproval : NSObject

@property (nonatomic, strong) NSString * peopleImgStr;
@property (nonatomic, strong) NSString * peopleNameStr;
@property (nonatomic, strong) NSString * byTheTimeStr;
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) NSString * startTimeStr;
@property (nonatomic, strong) NSString * endTimeStr;
@property (nonatomic, strong) NSString * statusEexaminationAndApprovalStr;

-(instancetype)initWithPeopeleImgStr:(NSString *)peopleImgStr
                       peopleNameStr:(NSString *)peopleNameStr
                        byTheTimeStr:(NSString *)byTheTimeStr
                             typeStr:(NSString *)typeStr
                        startTimeStr:(NSString *)startTimeStr
                          endTimeStr:(NSString *)endTimeStr
    statusEexaminationAndApprovalStr:(NSString *)statusEexaminationAndApprovalStr;






@end
