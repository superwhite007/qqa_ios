//
//  ACPApproval.h
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPApproval : NSObject

@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * department;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * leave_id;

-(instancetype)initWithusername:(NSString *)username
                       department:(NSString *)department
                        created_at:(NSString *)created_at
                             type:(NSString *)type
                                status:(NSString *)status
                          leave_id:(NSString *)leave_id;


/*"created_at" = "2017-11-27 18:44:43";
department = "\U6280\U672f\U5f00\U53d1\U4e2d\U5fc3 ";
id = 24;
status = G;
type = 105;
username = "\U66f9\U4f1f\U6770";
*/


@end
