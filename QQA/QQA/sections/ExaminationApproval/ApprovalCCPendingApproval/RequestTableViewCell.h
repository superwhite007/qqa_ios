//
//  RequestTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/11/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Request;

@interface RequestTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * userFamily;
@property (nonatomic, strong) UILabel * username;
@property (nonatomic, strong) UILabel * department;
@property (nonatomic, strong) UILabel * created_at;
@property (nonatomic, strong) UILabel * status;
@property (nonatomic, strong) UILabel * askId;

@property (nonatomic, strong) Request * request;

@end
