//
//  TaskNameTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/6/12.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskName;

@interface TaskNameTVCell : UITableViewCell

@property (nonatomic, strong) UILabel * orderCircleLabel;
@property (nonatomic, strong) UILabel * redpointOfOrderCircleisReadLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * describeLabel;
@property (nonatomic, strong) UILabel * commentNumberRedpointCircleLabel;
@property (nonatomic, strong) UIImageView * forwardImageView;

@property (nonatomic, strong) TaskName * taskName;

@end
