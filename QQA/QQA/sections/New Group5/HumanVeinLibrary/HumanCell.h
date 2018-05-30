//
//  HumanCell.h
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Human;

@interface HumanCell : UITableViewCell

/*
 connectionId = 1;
 content = "\U7531\U674e\U9e4f2018\U5e7405\U670829\U65e5\U521b\U5efa";
 isShow = 1;
 name = "\U5f20\U98de";
 */
@property (nonatomic, strong) UILabel * nameFamilyLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIImageView * isShowImageView;
@property (nonatomic, strong) UILabel * connectionId;

@property (nonatomic, strong) Human * human;


@end
