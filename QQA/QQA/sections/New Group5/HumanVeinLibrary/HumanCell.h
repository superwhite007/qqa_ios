//
//  HumanCell.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Human;

@interface HumanCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameFamilyLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIImageView * isShowImageView;
@property (nonatomic, strong) UILabel * connectionId;

@property (nonatomic, strong) Human * human;


@end
