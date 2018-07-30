//
//  IInitiatedtheExaminationTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiatedtheExaminationTableViewCell.h"

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
    
    
    //60
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 60, 60)];
    self.imgView.backgroundColor = [UIColor redColor];
    self.imgView.layer.cornerRadius = 30;
    self.imgView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imgView.layer.borderWidth = 0.5;
    self.imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imgView];
    
    
    
    self.reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + 5, 25, 250, 50)] ;
    _reasonTitleLabel.font = [UIFont systemFontOfSize:22];
//    _reasonTitleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_reasonTitleLabel];
    
    self.imgViewFor = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 50, 38, 25, 25)];
//    self.imgViewFor.backgroundColor = [UIColor redColor];
    self.imgViewFor.layer.cornerRadius = 15;
    self.imgViewFor.alpha = .6;
//    self.imgViewFor.layer.borderColor = [UIColor blackColor].CGColor;
//    self.imgViewFor.layer.borderWidth = 0.5;
    self.imgViewFor.layer.masksToBounds = YES;
    [self.contentView addSubview:_imgViewFor];
    
   
    
    
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
