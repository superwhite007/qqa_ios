//
//  WorkOrderTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/7.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderTVCell.h"

@implementation WorkOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}
-(void)addAllViews{
    _workNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, iphoneWidth - 100, 25)];
    _workNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_workNameLabel];
    
    _workContentLabel = [[UILabel alloc] init];
    _workContentLabel.frame = CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, 40);
    [self.contentView addSubview:_workContentLabel];
    
    _workCreatedByPeopleANDTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_workContentLabel.frame) + 5, iphoneWidth - 20, 15)];
    _workCreatedByPeopleANDTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_workCreatedByPeopleANDTimeLabel];
    
    _workRedpointNnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 80, 40, 20 , 20)];
    _workRedpointNnumberLabel.layer.cornerRadius = _workRedpointNnumberLabel.frame.size.width / 2;
    _workRedpointNnumberLabel.layer.masksToBounds = YES;
    _workRedpointNnumberLabel.text = @"99";
    _workRedpointNnumberLabel.font = [UIFont systemFontOfSize:12];
    _workRedpointNnumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_workRedpointNnumberLabel];
    
    _workCompleteANDUnfinishedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 55, 40, 20 , 20)];
    [self.contentView addSubview:_workCompleteANDUnfinishedImageView];
    
    _nextForwardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 30, 40, 20 , 20)];
    [self.contentView addSubview:_nextForwardImageView];
    
    
    _workNameLabel.backgroundColor = [UIColor redColor];
    _workContentLabel.backgroundColor = [UIColor greenColor];
    _workCreatedByPeopleANDTimeLabel.backgroundColor = [UIColor blueColor];
    
    _workRedpointNnumberLabel.backgroundColor = [UIColor redColor];
    _workCompleteANDUnfinishedImageView.backgroundColor = [UIColor redColor];
    _nextForwardImageView.backgroundColor = [UIColor redColor];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end