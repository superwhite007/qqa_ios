//
//  OneOrderCell.h
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OneOrder;
@interface OneOrderCell : UITableViewCell

@property (nonatomic, strong) UIButton * selectPeopleButton;
@property (nonatomic, strong) UILabel * peopleNameLabel;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UILabel * workRedpointNnumberLabel;
@property (nonatomic, strong) UIImageView * workCompleteANDUnfinishedImageView;
@property (nonatomic, strong) UIImageView * nextForwardImageView;

@property (nonatomic, strong) UILabel * workCreatedByPeopleANDTimeLabel;

@property (nonatomic, strong) OneOrder * oneOrder;


@end
