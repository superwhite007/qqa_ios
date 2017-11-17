//
//  IInitiatedtheExaminationTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiatedtheExaminationTableViewCell.h"

#import "IInitiated.h"
#define kIInintedSPACE 5

@implementation IInitiatedtheExaminationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return  self;
}

-(void)addAllViews{
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    [self.contentView addSubview:_imgView];
    
    
    
    self.reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + kIInintedSPACE, 5, 100, 30)] ;
    _reasonTitleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_reasonTitleLabel];
    
    self.reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + kIInintedSPACE, 35, 100, 30)] ;
    _reasonLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_reasonLabel];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 100 * 2 / 3 , iphoneWidth, .5)];
    view.alpha = .4;
    view.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:view];
    
    self.promptLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 100 * 2 / 3 + 1, 100, 30)];
    _promptLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:self.promptLabel];
    
    UIImageView  * forwardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 35, 70, 25, 25)];
    UIImage *image = [UIImage imageNamed:@"forward"];
    [forwardImageView setImage:image];
    forwardImageView.alpha = 0.6;
    [self.contentView addSubview:forwardImageView];
    
    
}

-(void)setIInitiatedTableViewCell:(IInitiated *)iInitiated{
    if (_iInitiated != iInitiated) {
        _iInitiated = iInitiated;
    }
    [self.imgView setImage:[UIImage imageNamed:iInitiated.imageStr]];
    self.reasonTitleLabel.text = iInitiated.reasonTitleStr;
    self.reasonLabel.text = iInitiated.reasonStr;
    self.promptLabel.text = iInitiated.promptStr;
    
    
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
