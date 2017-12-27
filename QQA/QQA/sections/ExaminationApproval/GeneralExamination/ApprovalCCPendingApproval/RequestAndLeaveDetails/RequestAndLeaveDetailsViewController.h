//
//  RequestAndLeaveDetailsViewController.h
//  QQA
//
//  Created by wang huiming on 2017/11/28.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ACPApproval.h"

@interface RequestAndLeaveDetailsViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) UITextView * messageTextView;
//@property (nonatomic, copy) ACPApproval * approval;
@property (nonatomic, strong) NSString * leaveIdStr;
@property (nonatomic, strong) NSString * titleIdentStr;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) NSString * semdUrlStr;

@end
