//
//  ACPApprovalTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApprovalTableViewCell.h"

@implementation ACPApprovalTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addAllViews];
        
    }
    
    return self;
}


-(void)addAllViews{
    
    //heigh = 1000
    
    self.peopleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    [self.contentView addSubview:self.peopleImageView];
    
    
    self.peopleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame) + 10, 2 , 100, 15)];
    [self.contentView addSubview:_peopleNameLabel];
    
    self.byTheTimeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleNameLabel.frame) + 10, 2 , 100, 15)];
    [self.contentView addSubview:_byTheTimeLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame) + 10, 2 + 17 , 100, 15)];
    [self.contentView addSubview:_typeLabel];
    
    self.startTImeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame) + 10, 2 + 17 * 2 , 300, 10)];
    [self.contentView addSubview:_startTImeLabel];
    
    self.endTimeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame) + 10, 2 + 17 * 3 , 300, 10)];
    [self.contentView addSubview:_endTimeLabel];
    
    self.statusLabel =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_peopleImageView.frame) + 10 + 305, 2 + 17 * 3 , 100, 10)];
    [self.contentView addSubview:_statusLabel];
    
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
