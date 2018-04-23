//
//  CompanyTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2018/4/12.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "CompanyTableViewCell.h"

@implementation CompanyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    
    //60
    _nameShorthandLabel = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 100, 15, 20, 20)];
//    _nameShorthandLabel.backgroundColor = [UIColor redColor];
    _nameShorthandLabel.layer.cornerRadius = 10;
//    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    _nameShorthandLabel.layer.borderWidth = 1;
    _nameShorthandLabel.layer.masksToBounds = YES;
    _nameShorthandLabel.textColor = [UIColor whiteColor];
    _nameShorthandLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameShorthandLabel];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, iphoneWidth - 110, 30)];
    [self.contentView addSubview:_nameLabel];
    UIImageView *imgViewFor = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 50, 17.5, 20, 20)];
    imgViewFor.layer.cornerRadius = 15;
    imgViewFor.alpha = .6;
    //    self.imgViewFor.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.imgViewFor.layer.borderWidth = 0.5;
    imgViewFor.layer.masksToBounds = YES;
    imgViewFor.image = [UIImage imageNamed:[NSString stringWithFormat:@"forward"]];
    [self.contentView addSubview:imgViewFor];
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
