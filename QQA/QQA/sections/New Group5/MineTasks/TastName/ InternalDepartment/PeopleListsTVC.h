//
//  PeopleListsTVC.h
//  QQA
//
//  Created by wang huiming on 2018/6/14.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleListsTVC : UITableViewController<UITextViewDelegate>

@property (nonatomic, strong) UITextView * messageTextView;

@property (nonatomic, strong) NSString * patternStr;
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) NSString * departmentName;
@property (nonatomic, strong) NSString * departmentId;

@end
