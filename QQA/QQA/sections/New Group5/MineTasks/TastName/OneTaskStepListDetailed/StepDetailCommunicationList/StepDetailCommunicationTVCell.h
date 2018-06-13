//
//  StepDetailCommunicationTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StepDetailCommunication;
@interface StepDetailCommunicationTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView * peopleImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * describeLabel;

@property (nonatomic, strong) StepDetailCommunication * stepDetailCommunication;

@end
