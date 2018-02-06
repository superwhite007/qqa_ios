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

@property (nonatomic, strong) UILabel * userFamily;
@property (nonatomic, strong) UILabel * username;
@property (nonatomic, strong) UILabel * department;
@property (nonatomic, strong) UILabel * created_at;
@property (nonatomic, strong) UILabel * type;
@property (nonatomic, strong) UILabel * status;
@property (nonatomic, strong) UILabel * leave_id;

@property (nonatomic, strong) ACPApproval * aCPApproval;

@end

