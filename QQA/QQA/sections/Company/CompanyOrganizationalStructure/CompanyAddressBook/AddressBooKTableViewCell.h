//
//  AddressBooKTableViewCell.h
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressBook;

@interface AddressBooKTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * peopleName;

@property (nonatomic, strong) AddressBook * addressBook;
@property (nonatomic, strong) UILabel * shortName;



@end
