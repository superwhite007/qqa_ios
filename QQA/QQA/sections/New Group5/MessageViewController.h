//
//  MessageViewController.h
//  QQA
//
//  Created by wang huiming on 2017/11/15.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel * placeHolderLabel;
@property(nonatomic,strong)UILabel * residuLabel;// 输入文本时剩余字数


@end
