//
//  ACPApprovalTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACPApproval;

@interface ACPApprovalTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * peopleImageView;
@property (nonatomic, strong) UILabel * peopleNameLabel;
@property (nonatomic, strong) UILabel * byTheTimeLabel;
@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * startTImeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * statusLabel;

@property (nonatomic, strong) ACPApproval * aCPApproval;

@end


