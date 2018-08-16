//
//  StepDetailCommunicationListVC.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepDetailCommunicationListVC : UIViewController<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextView * messageTextView;
@property (nonatomic, strong) NSString * subtaskIdStr;

@end
