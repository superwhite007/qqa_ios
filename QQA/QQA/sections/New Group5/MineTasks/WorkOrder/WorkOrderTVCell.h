//
//  WorkOrderTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/8/7.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkOrder;
@interface WorkOrderTVCell : UITableViewCell

@property (nonatomic, strong) UILabel * workNameLabel;
@property (nonatomic, strong) UILabel * workContentLabel;
@property (nonatomic, strong) UILabel * workCreatedByPeopleANDTimeLabel;

@property (nonatomic, strong) UILabel * workRedpointNnumberLabel;
@property (nonatomic, strong) UIImageView * workCompleteANDUnfinishedImageView;
@property (nonatomic, strong) UIImageView * nextForwardImageView;

@property (nonatomic, strong) WorkOrder * workOrder;

@end
