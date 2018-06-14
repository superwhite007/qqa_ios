//
//  NewTask.h
//  QQA
//
//  Created by wang huiming on 2018/6/14.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTask : NSObject

/* "pattern":"1", //2
 "type":"1", //2
 "departmentId":"1",
 "title":"任务名称"
 */
@property (nonatomic, strong) NSString * patternStr;
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) NSString * departmentIdStr;
@property (nonatomic, strong) NSString * titleStr;

-(instancetype)initNewTaskSendToServerWithpatternStr:(NSString *)patternStr typeStr:(NSString *)typeStr departmentIdStr:(NSString *)departmentIdStr titleStr:(NSString *)titleStr;

-(void)SendNewTaskToServerWithpatternStr:(NSString *)patternStr typeStr:(NSString *)typeStr departmentIdStr:(NSString *)departmentIdStr titleStr:(NSString *)titleStr;

@end
