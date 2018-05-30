//
//  HumanCell.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanCell.h"
#import "Human.h"

@implementation HumanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}
-(void)addAllViews{
    self.nameFamilyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.nameFamilyLabel.layer.cornerRadius = self.nameFamilyLabel.frame.size.width / 2;
    self.nameFamilyLabel.layer.masksToBounds = YES;
    self.nameFamilyLabel.textAlignment = NSTextAlignmentCenter;
    _nameFamilyLabel.backgroundColor = [UIColor blueColor];
    _nameFamilyLabel.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:_nameFamilyLabel];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, iphoneWidth / 3, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:20];
    _nameLabel.backgroundColor = [UIColor blueColor];
    
    _nameLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_nameLabel];
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, iphoneWidth - 120, 10)];
    _contentLabel.font = [UIFont systemFontOfSize:10];
    _contentLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_contentLabel];
    self.isShowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 40, 15, 30, 30)];
    self.isShowImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.isShowImageView];
}

-(void)setHuman:(Human *)human{
    self.nameFamilyLabel.text = [human.name substringToIndex:1];
    self.nameLabel.text = human.name;
    self.contentLabel.text = human.content;
    NSLog(@"CELL:%@",human.isShow);
    if ([human.isShow intValue] == 1) {
        _isShowImageView.image = [UIImage imageNamed:@"lock"];
    }else if ([human.isShow intValue] == 0){
        _isShowImageView.image = [UIImage imageNamed:@"forward"];
    }
    self.connectionId.text = human.connectionId;
    
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
