//
//  TaskNameTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/6/12.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "TaskNameTVCell.h"
#import "TaskName.h"

@implementation TaskNameTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}
-(void)addAllViews{
    
    self.orderCircleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5, 12.5, 75, 75)];
    self.orderCircleLabel.layer.cornerRadius = self.orderCircleLabel.frame.size.width / 2;
    self.orderCircleLabel.layer.masksToBounds = YES;
    self.orderCircleLabel.textAlignment = NSTextAlignmentCenter;
    _orderCircleLabel.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:_orderCircleLabel];
    
    _redpointOfOrderCircleisReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 20, 20)];
    self.redpointOfOrderCircleisReadLabel.layer.cornerRadius = self.redpointOfOrderCircleisReadLabel.frame.size.width / 2;
    self.redpointOfOrderCircleisReadLabel.layer.masksToBounds = YES;
    self.redpointOfOrderCircleisReadLabel.textAlignment = NSTextAlignmentCenter;
    _redpointOfOrderCircleisReadLabel.font = [UIFont systemFontOfSize:30];
    self.redpointOfOrderCircleisReadLabel.backgroundColor = [UIColor redColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, iphoneWidth - 200, 60)];//initWithFrame:CGRectZero
//    _titleLabel.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview: _titleLabel];
    
    _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, iphoneWidth - 100, 25)];
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_describeLabel];
    
    _commentNumberRedpointCircleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 70, 30, 20, 20)];
    self.commentNumberRedpointCircleLabel.layer.cornerRadius = self.commentNumberRedpointCircleLabel.frame.size.width / 2;
    self.commentNumberRedpointCircleLabel.layer.masksToBounds = YES;
    self.commentNumberRedpointCircleLabel.textAlignment = NSTextAlignmentCenter;
    
    _commentNumberRedpointCircleLabel.font = [UIFont systemFontOfSize:12];
    _commentNumberRedpointCircleLabel.textColor = [UIColor whiteColor];
//    [self.contentView addSubview:_commentNumberRedpointCircleLabel];
    
    _forwardImageView = [[UIImageView alloc] init];
    _forwardImageView.frame = CGRectMake(iphoneWidth - 40, 30, 20, 20);
    UIImage *image = [UIImage imageNamed:@"forward"];
    [_forwardImageView setImage:image];
    _forwardImageView.alpha = 0.6;
    [self.contentView addSubview:_forwardImageView];
    
}
-(void)setTaskName:(TaskName *)taskName{
    
    if ([taskName.isRead intValue] == 0){
        [self.contentView addSubview:_redpointOfOrderCircleisReadLabel];
    }
    
    self.titleLabel.text = taskName.title;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.numberOfLines = 0;//表示label可以多行显示
    self.titleLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 200, 2000);
    CGRect targetRect = [self.titleLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil];
    self.titleLabel.frame = CGRectMake(100, 5, iphoneWidth - 200, CGRectGetHeight(targetRect));
    [self.contentView addSubview:self.titleLabel];

    self.describeLabel.text = taskName.describe;
    if ([taskName.commentNumber intValue] > 0) {
        _commentNumberRedpointCircleLabel.backgroundColor = [UIColor redColor];
        _commentNumberRedpointCircleLabel.text = [NSMutableString stringWithFormat:@"%@", taskName.commentNumber];
        [self.contentView addSubview:_commentNumberRedpointCircleLabel];
    }else if ([taskName.commentNumber intValue] == 0) {
        _commentNumberRedpointCircleLabel.backgroundColor = [UIColor whiteColor];
        _commentNumberRedpointCircleLabel.text = [NSMutableString stringWithFormat:@"%@", taskName.commentNumber];
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
