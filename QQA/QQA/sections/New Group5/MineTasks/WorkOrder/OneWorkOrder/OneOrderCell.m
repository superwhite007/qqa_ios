//
//  OneOrderCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCell.h"
#import "OneOrder.h"
@implementation OneOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllControls];
    }
    return self;
}
-(void)addAllControls{
    
    _selectPeopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_selectPeopleButton];
    
    _peopleNameLabel = [UILabel new];
    [self.contentView addSubview:_peopleNameLabel];
    
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    
    _workRedpointNnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 80, 40, 20 , 20)];
    _workRedpointNnumberLabel.layer.cornerRadius = _workRedpointNnumberLabel.frame.size.width / 2;
    _workRedpointNnumberLabel.layer.masksToBounds = YES;
    _workRedpointNnumberLabel.text = @"99";
    _workRedpointNnumberLabel.font = [UIFont systemFontOfSize:12];
    _workRedpointNnumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_workRedpointNnumberLabel];
    
    _workCompleteANDUnfinishedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 55, 40, 20 , 20)];
    _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"checkmark"];
    [self.contentView addSubview:_workCompleteANDUnfinishedImageView];
    
    _nextForwardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 30, 40, 20 , 20)];
    _nextForwardImageView.image = [UIImage imageNamed:@"forward"];
    [self.contentView addSubview:_nextForwardImageView];
    
    _workCreatedByPeopleANDTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_contentLabel.frame) + 5, iphoneWidth - 20, 15)];
    _workCreatedByPeopleANDTimeLabel.textAlignment = NSTextAlignmentLeft;
    _workCreatedByPeopleANDTimeLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_workCreatedByPeopleANDTimeLabel];
    
    _selectPeopleButton.backgroundColor = [UIColor redColor];
    _peopleNameLabel.backgroundColor = [UIColor redColor];
    _contentLabel.backgroundColor = [UIColor redColor];
    _workCreatedByPeopleANDTimeLabel.backgroundColor = [UIColor redColor];
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
