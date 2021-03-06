//
//  OneOrderCommunicationVController.h
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneOrderCommunicationVController : UIViewController<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextView * oneOrderCommunicationMessageTextView;
@property (nonatomic, strong) NSString * workListIdSTR;
@property (nonatomic, strong) NSString * workListDetailIdSTR;

@end
