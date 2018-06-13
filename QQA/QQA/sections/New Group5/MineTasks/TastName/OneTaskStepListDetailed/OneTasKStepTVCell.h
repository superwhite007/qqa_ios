//
//  OneTasKStepTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OneTasKStep;
@interface OneTasKStepTVCell : UITableViewCell

@property (nonatomic, strong) UILabel * orderCircleLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * describeLabel;
@property (nonatomic, strong) UILabel * commentNumberRedpointCircleLabel;
@property (nonatomic, strong) UIImageView * complatedImageView;
@property (nonatomic, strong) UIImageView * forwardImageView;

@property (nonatomic, strong) OneTasKStep * oneTasKStep;
@end
