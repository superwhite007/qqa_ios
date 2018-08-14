//
//  OneOrderCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCell.h"
#import "OneOrder.h"
#import "UIButton+WebCache.h"
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
    _peopleNameLabel.textAlignment = NSTextAlignmentCenter;
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
    _workCreatedByPeopleANDTimeLabel.backgroundColor = [UIColor greenColor];
//    _workRedpointNnumberLabel.backgroundColor = [UIColor redColor];
//    _workCompleteANDUnfinishedImageView.backgroundColor = [UIColor redColor];
//    _nextForwardImageView.backgroundColor = [UIColor redColor];
    _contentLabel.frame = CGRectMake(75, 5, iphoneWidth - 175, 60);
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _selectPeopleButton.frame = CGRectMake(10, 5, 60, 60);
    _selectPeopleButton.layer.cornerRadius = CGRectGetWidth(_selectPeopleButton.frame) / 2;
    _selectPeopleButton.layer.masksToBounds = YES;
    _peopleNameLabel.frame = CGRectMake(5, 70, 70, 25);
    _peopleNameLabel.text = @"青青";
    _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(85, 70, iphoneWidth - 100, 25);
    _workCreatedByPeopleANDTimeLabel.textAlignment = NSTextAlignmentRight;
    
}
-(void)setOneOrder:(OneOrder *)oneOrder{
    NSLog(@"oneOrder.executorImg::%@", oneOrder.executorImg);
    if (![oneOrder.executorImg isEqualToString:@"暂无"]) {
        [_selectPeopleButton xr_setButtonImageWithUrl:oneOrder.executorImg];
    }
    _peopleNameLabel.text = oneOrder.executorName;
    _contentLabel.text = oneOrder.content;
    _workCreatedByPeopleANDTimeLabel.text = oneOrder.describe;
    _workRedpointNnumberLabel.text = [NSString stringWithFormat:@"%@", oneOrder.unreadCommentNum];
    if ([oneOrder.isFinished intValue] == 0 ) {
        _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"checkmark"];
    }else if ([oneOrder.isFinished intValue] == 1 ){
        _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"checkmark_green"];
    }
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
