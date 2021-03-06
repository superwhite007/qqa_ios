//
//  WorkOrderTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/7.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderTVCell.h"
#import "WorkOrder.h"

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
    _workNameLabel.textAlignment = NSTextAlignmentCenter;
    _workNameLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_workNameLabel];
    
    _workContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, 40)];
    _workContentLabel.frame = CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, 40);
    [self.contentView addSubview:_workContentLabel];
    
    _workCreatedByPeopleANDTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_workContentLabel.frame) + 5, iphoneWidth - 20, 15)];
    _workCreatedByPeopleANDTimeLabel.textAlignment = NSTextAlignmentLeft;
    _workCreatedByPeopleANDTimeLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_workCreatedByPeopleANDTimeLabel];
    
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
}

-(void)setWorkOrder:(WorkOrder *)workOrder{
    _workNameLabel.text = workOrder.title;
    _workContentLabel.text = workOrder.content;
    _workCreatedByPeopleANDTimeLabel.text = workOrder.describe;
    NSString * str = [NSString stringWithFormat:@"%@", workOrder.unreadCommentNum];
    if ([str intValue] > 0 ) {
        _workRedpointNnumberLabel.text = str;
        _workRedpointNnumberLabel.backgroundColor = [UIColor redColor];
        _workRedpointNnumberLabel.layer.borderColor = [UIColor redColor].CGColor;
    } else if ([str intValue] == 0 ) {
        _workRedpointNnumberLabel.text = [NSString stringWithFormat:@" "];
        _workRedpointNnumberLabel.backgroundColor = [UIColor whiteColor];
        _workRedpointNnumberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    if ([workOrder.isFinished intValue] == 0 ) {
        _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"unfinish_icon"];
    }else if ([workOrder.isFinished intValue] == 1 ){
        _workCompleteANDUnfinishedImageView.image = [UIImage imageNamed:@"checkmark_green"];
    }
    
    _workContentLabel.text = workOrder.content;
    _workContentLabel.font = [UIFont systemFontOfSize:18];
    _workContentLabel.numberOfLines = 0;//表示label可以多行显示
    _workContentLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake((iphoneWidth - 20) * 3 / 4, 2000);
    CGRect targetRect = [_workContentLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : _workContentLabel.font} context:nil];
    _workContentLabel.frame = CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, CGRectGetHeight(targetRect));
    if (CGRectGetHeight(targetRect) < 40) {
        _workContentLabel.frame = CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, 40);
        _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(10, CGRectGetMaxY(_workContentLabel.frame) + 5, iphoneWidth - 20, 15);
        _workRedpointNnumberLabel.frame = CGRectMake(iphoneWidth - 80, 40, 20 , 20);
        _workCompleteANDUnfinishedImageView.frame = CGRectMake(iphoneWidth - 55, 40, 20 , 20);
        _nextForwardImageView.frame = CGRectMake(iphoneWidth - 30, 40, 20 , 20);
    }else{
        _workContentLabel.frame = CGRectMake(10, 35, (iphoneWidth - 20) * 3 / 4, CGRectGetHeight(targetRect) );
        _workCreatedByPeopleANDTimeLabel.frame = CGRectMake(10, CGRectGetMaxY(_workContentLabel.frame) + 5, iphoneWidth - 20, 15);
        _workRedpointNnumberLabel.frame = CGRectMake(iphoneWidth - 80, (40 + CGRectGetMaxY(_workContentLabel.frame)) / 2 , 20 , 20);
        _workCompleteANDUnfinishedImageView.frame = CGRectMake(iphoneWidth - 55, (40 + CGRectGetMaxY(_workContentLabel.frame)) / 2, 20 , 20);
        _nextForwardImageView.frame = CGRectMake(iphoneWidth - 30,  (40 + CGRectGetMaxY(_workContentLabel.frame)) / 2, 20 , 20);
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
