//
//  StepDetailCommunicationTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "StepDetailCommunicationTVCell.h"
#import "StepDetailCommunication.h"

@implementation StepDetailCommunicationTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}
-(void)addAllViews{
    
//    _peopleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 12.5, 75, 75)];
//    _peopleImageView.layer.cornerRadius = _peopleImageView.frame.size.width / 2;
//    _peopleImageView.layer.masksToBounds = YES;
//    [self.contentView addSubview:_peopleImageView];
    
    _peopleImageView = [UIImageView new];
//    [self.contentView addSubview:_peopleImageView];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, iphoneWidth - 100, 60)];
    [self.contentView addSubview:self.contentLabel];
    _describeLabel = [UILabel new];
    [self.contentView addSubview:_describeLabel];
    
}

-(void)setStepDetailCommunication:(StepDetailCommunication *)stepDetailCommunication{
    
    _peopleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: stepDetailCommunication.imgUrl]]];
    self.contentLabel.text = stepDetailCommunication.content;
    self.contentLabel.font = [UIFont systemFontOfSize:18];
    self.contentLabel.numberOfLines = 0;//表示label可以多行显示
    self.contentLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 200, 2000);
    CGRect targetRect = [self.contentLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil];
    self.contentLabel.frame = CGRectMake(100, 5, iphoneWidth - 110, CGRectGetHeight(targetRect));
//    [self.contentView addSubview:self.contentLabel];
    self.describeLabel.text = stepDetailCommunication.describe;
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
