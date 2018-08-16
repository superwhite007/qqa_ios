//
//  OneOrderCommunicationTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/8/16.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OneOrderCommunication;
@interface OneOrderCommunicationTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView * peopleImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * describeLabel;

@property (nonatomic, strong) OneOrderCommunication * oneOrderCommunication;

@end
