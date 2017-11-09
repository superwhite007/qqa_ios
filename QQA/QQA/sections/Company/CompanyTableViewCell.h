//
//  CompanyTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/11/8.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyObject;

@interface CompanyTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * titleLable;

@property (nonatomic, strong) CompanyObject * companyObject;

@end
