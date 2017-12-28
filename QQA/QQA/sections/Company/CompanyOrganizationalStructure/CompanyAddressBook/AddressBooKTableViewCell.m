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
    _shortName.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    _shortName.layer.cornerRadius = 20;
    _shortName.layer.borderColor = [UIColor blackColor].CGColor;
    _shortName.layer.borderWidth = 1;
    _shortName.layer.masksToBounds = YES;
    _shortName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shortName];
    _peopleName = [[UILabel alloc] initWithFrame:CGRectMake(60 , 10, iphoneWidth - 120 , 40)];
    [self.contentView addSubview:_peopleName];
    UIImageView *imgViewFor = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 50, 17.5, 25, 25)];
    imgViewFor.layer.cornerRadius = 15;
    imgViewFor.alpha = .5;
    imgViewFor.layer.masksToBounds = YES;
    imgViewFor.image = [UIImage imageNamed:[NSString stringWithFormat:@"forward"]];
    [self.contentView addSubview:imgViewFor];
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
