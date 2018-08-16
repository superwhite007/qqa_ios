//
//  OneOrderCommunicationTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/16.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCommunicationTVCell.h"
#import "OneOrderCommunication.h"
@implementation OneOrderCommunicationTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    _peopleImageView = [UIImageView new];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, iphoneWidth - 100, 60)];
    [self.contentView addSubview:self.contentLabel];
    _describeLabel = [UILabel new];
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_describeLabel];
}

-(void)setOneOrderCommunication:(OneOrderCommunication *)oneOrderCommunication{
    _peopleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: oneOrderCommunication.img]]];
    
    self.contentLabel.text = oneOrderCommunication.content;
    self.contentLabel.font = [UIFont systemFontOfSize:18];
    self.contentLabel.numberOfLines = 0;//表示label可以多行显示
    self.contentLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 200, 2000);
    CGRect targetRect = [self.contentLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil];
    self.contentLabel.frame = CGRectMake(100, 5, iphoneWidth - 110, CGRectGetHeight(targetRect));
    //    [self.contentView addSubview:self.contentLabel];
    self.describeLabel.text = oneOrderCommunication.describe;
    if (CGRectGetHeight(targetRect) < 60) {
        _peopleImageView.frame = CGRectMake(12.5, 12.5, 75, 75);
        _describeLabel.frame = CGRectMake(100, 70, iphoneWidth - 100, 25);
    }else{
        _peopleImageView.frame = CGRectMake(12.5, (CGRectGetHeight(targetRect) - 40 ) / 2, 75, 75);
        _describeLabel.frame = CGRectMake(100, CGRectGetHeight(targetRect) + 10, iphoneWidth - 100, 25);
    }
    _peopleImageView.layer.cornerRadius = _peopleImageView.frame.size.width / 2;
    _peopleImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_peopleImageView];
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
