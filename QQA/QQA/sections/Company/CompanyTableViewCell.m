//
//  CompanyTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/8.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyTableViewCell.h"
#import "CompanyObject.h"

@implementation CompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return  self;
}

-(void)addAllViews{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 135, 90)] ;
    [self.contentView addSubview:_imgView];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + kSPACE, 10, [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(_imgView.frame) - 25, 30)] ;
    _titleLable.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_titleLable];
    
}

-(void)setCompanyObject:(CompanyObject *)companyObject{
    
    if (_companyObject != companyObject) {
        
        _companyObject = companyObject;
    }
    
    [self.imgView  setImage:[UIImage imageNamed:companyObject.img]];
    self.titleLable.text = companyObject.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
