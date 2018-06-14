//
//  InternalDepartmentVC.h
//  QQA
//
//  Created by wang huiming on 2018/6/14.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InternalDepartmentVC : UIViewController<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITextView * messageTextView;
@property (nonatomic, strong) NSString * taskIdStr;

@end
