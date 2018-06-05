//
//  ReadunreadTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/6/5.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "ReadunreadTVCell.h"
#import "Readunread.h"
@implementation ReadunreadTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    //60
    _shortUsernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _shortUsernameLabel.backgroundColor = [UIColor colorWithRed:arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256 / 255.0 alpha:0.8];
    _shortUsernameLabel.layer.cornerRadius = 20;
    //    _shortUsernameLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //    _shortUsernameLabel.layer.borderWidth = 1;
    _shortUsernameLabel.layer.masksToBounds = YES;
    _shortUsernameLabel.textAlignment = NSTextAlignmentCenter;
    _shortUsernameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_shortUsernameLabel];
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, iphoneWidth - 110, 30)];
    [self.contentView addSubview:_usernameLabel];
    _isReadLabel  = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 60, 15, 60, 30)];
    [self.contentView addSubview:_isReadLabel];
}

-(void)setReadUnread:(Readunread *)readUnread{
    if (_readUnread != readUnread) {
        _readUnread = readUnread;
    }
    self.shortUsernameLabel.text = [readUnread.username  substringToIndex:1] ;
    self.usernameLabel.text = readUnread.username;
    if ([readUnread.isRead intValue] == 0) {
        self.isReadLabel.text =  @"未读";
        self.isReadLabel.textColor = [UIColor redColor];
    } else if ([readUnread.isRead intValue] == 1) {
        self.isReadLabel.text =  @"已读";
        self.isReadLabel.textColor = [UIColor greenColor];
    }
//    self.isReadLabel.text = readUnread.isRead;
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
