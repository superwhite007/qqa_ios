//
//  NewContactViewController.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) UITextView * nameTextView;
@property (nonatomic, strong) UITextView * describeTextView;
@property (nonatomic, strong) UITextView * telephoneTextView;
@property (nonatomic, strong) UITextView * mailTextView;
@property (nonatomic, strong) UITextView * QQTextView;
@property (nonatomic, strong) UITextView * weixinTextView;

@end
