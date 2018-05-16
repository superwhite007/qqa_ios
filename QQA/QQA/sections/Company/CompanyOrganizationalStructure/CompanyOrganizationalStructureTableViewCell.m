//
//  CompanyOrganizationalStructureTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyOrganizationalStructureTableViewCell.h"
#import "CompanyOrganizationalStructure.h"

@implementation CompanyOrganizationalStructureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    
    //60
    _nameShorthandLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _nameShorthandLabel.backgroundColor = [UIColor colorWithRed:arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256 / 255.0 alpha:0.8];
    _nameShorthandLabel.layer.cornerRadius = 20;
//    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    _nameShorthandLabel.layer.borderWidth = 1;
    _nameShorthandLabel.layer.masksToBounds = YES;
    _nameShorthandLabel.textAlignment = NSTextAlignmentCenter;
    _nameShorthandLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_nameShorthandLabel];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, iphoneWidth - 110, 30)];
    [self.contentView addSubview:_nameLabel];
    UIImageView *imgViewFor = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 50, 17.5, 25, 25)];
    imgViewFor.layer.cornerRadius = 15;
    imgViewFor.alpha = .6;
    //    self.imgViewFor.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.imgViewFor.layer.borderWidth = 0.5;
    imgViewFor.layer.masksToBounds = YES;
    imgViewFor.image = [UIImage imageNamed:[NSString stringWithFormat:@"forward"]];
    [self.contentView addSubview:imgViewFor];
}


-(void)setCompanyOrganizationalStructure:(CompanyOrganizationalStructure *)companyOrganizationalStructure{
    if (_companyOrganizationalStructure != companyOrganizationalStructure) {
        _companyOrganizationalStructure = companyOrganizationalStructure;
    }
    self.nameShorthandLabel.text = [companyOrganizationalStructure.name substringToIndex:1];
    self.nameLabel.text = companyOrganizationalStructure.name;
    self.departmentId = companyOrganizationalStructure.departmentId;
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
