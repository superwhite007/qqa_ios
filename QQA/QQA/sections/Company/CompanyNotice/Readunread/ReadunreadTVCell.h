//
//  ReadunreadTVCell.h
//  QQA
//
//  Created by wang huiming on 2018/6/5.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Readunread;
@interface ReadunreadTVCell : UITableViewCell

@property (nonatomic, strong) UILabel * shortUsernameLabel;
@property (nonatomic, strong) UILabel * usernameLabel;
@property (nonatomic, strong) UILabel * isReadLabel;

@property (nonatomic, strong) Readunread * readUnread;

@end
