//
//  TaskVC.h
//  QQA
//
//  Created by wang huiming on 2018/6/6.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskVC : UIViewController<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextView * messageTextView;
@property (nonatomic, strong) NSString * mineOrOthersStr;
@property (nonatomic, strong) NSString * userIdStr;

@end
