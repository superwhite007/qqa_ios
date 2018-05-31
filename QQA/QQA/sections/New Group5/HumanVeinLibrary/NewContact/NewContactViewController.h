//
//  NewContactViewController.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * describeTextField;
@property (nonatomic, strong) UITextField * telephoneTextField;
@property (nonatomic, strong) UITextField * mailTextField;
@property (nonatomic, strong) UITextField * QQTextField;
@property (nonatomic, strong) UITextField * weixinTextField;

@property (nonatomic, strong) NSDictionary * reviceDic;

@end
