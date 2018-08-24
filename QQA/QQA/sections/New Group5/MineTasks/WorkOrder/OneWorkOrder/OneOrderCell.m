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
    _workCreatedByPeopleANDTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_workCreatedByPeopleANDTimeLabel];
    _contentLabel.frame = CGRectMake(75, 5, iphoneWidth - 175, 60);
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _selectPeopleButton.frame = CGRectMake(10, 5, 60, 60);
    _peopleNameLabel.frame = CGRectMake(5, 70, 70, 25);
    _peopleNameLabel.text = @"青青";
    _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(85, 70, iphoneWidth - 100, 25);
    _workCreatedByPeopleANDTimeLabel.textAlignment = NSTextAlignmentRight;
    
}
-(void)setOneOrder:(OneOrder *)oneOrder{
    if (![oneOrder.executorImg isEqualToString:@"暂无"]) {
        [_selectPeopleButton xr_setButtonImageWithUrl:oneOrder.executorImg];
    }else{
        [_selectPeopleButton setBackgroundImage:[UIImage imageNamed:@"addLeaderOrExecutor"] forState:UIControlStateNormal];
    }
    _peopleNameLabel.text = oneOrder.executorName;
    _contentLabel.text = oneOrder.content;
    _contentLabel.font = [UIFont systemFontOfSize:18];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 175, 2000);
    CGRect targetRect = [_contentLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : _contentLabel.font} context:nil];
    if (CGRectGetHeight(targetRect) < 40) {
        _contentLabel.frame = CGRectMake(75, 10, iphoneWidth - 175, 60);
        _selectPeopleButton.frame = CGRectMake(10, 5, 60, 60);
        _selectPeopleButton.layer.cornerRadius = CGRectGetWidth(_selectPeopleButton.frame) / 2;
        _selectPeopleButton.layer.masksToBounds = YES;
        _peopleNameLabel.frame = CGRectMake(5, 70, 70, 25);
        _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(85, 70, iphoneWidth - 100, 25);
        _workRedpointNnumberLabel.frame = CGRectMake(iphoneWidth - 80, 40, 20 , 20);
        _workCompleteANDUnfinishedImageView.frame = CGRectMake(iphoneWidth - 55, 40, 20 , 20);
        _nextForwardImageView.frame = CGRectMake(iphoneWidth - 30, 40, 20 , 20);
    }else{
        _contentLabel.frame = CGRectMake(75, 10, iphoneWidth - 175, CGRectGetHeight(targetRect));
        _selectPeopleButton.frame = CGRectMake(10, 5 + (CGRectGetHeight(targetRect) - 60) / 2 , 60, 60);
        _selectPeopleButton.layer.cornerRadius = CGRectGetWidth(_selectPeopleButton.frame) / 2;
        _selectPeopleButton.layer.masksToBounds = YES;
        _peopleNameLabel.frame = CGRectMake(5, CGRectGetMaxY(_selectPeopleButton.frame)+5, 70, 25);
        _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(85, CGRectGetMaxY(_contentLabel.frame)+5, iphoneWidth - 100, 25);
        _workRedpointNnumberLabel.frame = CGRectMake(iphoneWidth - 80, 40 + (CGRectGetHeight(targetRect) - 40) / 2, 20 , 20);
        _workCompleteANDUnfinishedImageView.frame = CGRectMake(iphoneWidth - 55, 40 + (CGRectGetHeight(targetRect) - 40) / 2, 20 , 20);
        _nextForwardImageView.frame = CGRectMake(iphoneWidth - 30, 40 + (CGRectGetHeight(targetRect) - 40) / 2, 20 , 20);
    }
    _workCreatedByPeopleANDTimeLabel.text = oneOrder.describe;
    NSString * str = [NSString stringWithFormat:@"%@", oneOrder.unreadCommentNum];
    if ([str intValue] > 0 ) {
        _workRedpointNnumberLabel.text = str;
        _workRedpointNnumberLabel.backgroundColor = [UIColor redColor];
        _workRedpointNnumberLabel.layer.borderColor = [UIColor redColor].CGColor;
    } else if ([str intValue] == 0 ) {
        _workRedpointNnumberLabel.text = [NSString stringWithFormat:@" "];
        _workRedpointNnumberLabel.backgroundColor = [UIColor whiteColor];
        _workRedpointNnumberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    if ([oneOrder.isFinished intValue] == 0 ) {
        _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"unfinish_icon"];
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
