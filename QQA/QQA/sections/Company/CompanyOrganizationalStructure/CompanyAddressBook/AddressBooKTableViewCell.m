//
//  AddressBooKTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AddressBooKTableViewCell.h"
#import "AddressBook.h"

@implementation AddressBooKTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCellView];
    }
    return self;
}

-(void)addCellView{
    //60
    self.shortName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.shortName.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.shortName];
    _peopleName = [[UILabel alloc] initWithFrame:CGRectMake(60 , 10, iphoneWidth - 120 , 40)];
    _peopleName.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_peopleName];
}

-(void)setAddressBook:(AddressBook *)addressBook{
    if (_addressBook != addressBook ) {
        _addressBook = addressBook;
    }
    self.peopleName.text = addressBook.username;
    self.shortName.text = [addressBook.username substringToIndex:1];
    
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
