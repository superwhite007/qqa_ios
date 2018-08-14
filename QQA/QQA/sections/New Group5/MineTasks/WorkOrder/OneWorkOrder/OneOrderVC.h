//
//  OneOrderVC.h
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneOrderVC : UIViewController<UITextViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITextView * messageOneOrederTextView;
@property (nonnull, strong) NSString * workListIdStr;
@property (nonnull, strong) NSString * isEdit;



@end
