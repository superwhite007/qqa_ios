//
//  IInitiatedtheExaminationTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  IInitiated;


@interface IInitiatedtheExaminationTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * reasonTitleLabel;
@property (nonatomic, strong) UILabel * reasonLabel;
@property (nonatomic, strong) UILabel * promptLabel;


@property (nonatomic, strong) IInitiated * iInitiated;


@end