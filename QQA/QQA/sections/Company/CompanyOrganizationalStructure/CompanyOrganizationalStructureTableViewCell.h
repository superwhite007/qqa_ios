//
//  CompanyOrganizationalStructureTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompanyOrganizationalStructure;

@interface CompanyOrganizationalStructureTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameShorthandLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) NSString * departmentId;

@property (nonatomic, strong) CompanyOrganizationalStructure * companyOrganizationalStructure;


@end
