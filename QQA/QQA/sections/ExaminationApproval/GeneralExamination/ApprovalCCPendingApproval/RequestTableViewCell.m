//
//  RequestTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RequestTableViewCell.h"
#import "Request.h"

@implementation RequestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}


-(void)addAllViews{
    
    //heigh = 100
    
    self.userFamily = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    self.userFamily.backgroundColor = [UIColor blueColor];
    self.userFamily.layer.cornerRadius = 30;
    self.userFamily.layer.masksToBounds = YES;
    self.userFamily.textAlignment = NSTextAlignmentCenter;
    self.userFamily.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:self.userFamily];
    
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userFamily.frame) + 10, 10 , 100, 20)];
    [self.contentView addSubview:_username];
    
    self.department =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_username.frame) + 10, 10 , iphoneWidth -  CGRectGetMaxX(_username.frame) - 20, 20)];
    [self.contentView addSubview:_department];
    
    self.created_at = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 40 , 200, 20)];
    [self.contentView addSubview:_created_at];
    
    self.status =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 70 , 300, 20)];
    [self.contentView addSubview:_status];
    
    //    self.leave_id =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userFamily.frame) + 10 + 305, 2 + 17 * 3 , 100, 10)];
    //    [self.contentView addSubview:leave_id];
    
}

-(void)setRequest:(Request *)request{
    
    if (_request != request) {
        _request = request;
    }
    self.username.text = request.username;
    self.userFamily.text = [request.username substringToIndex:1];
    self.department.text = request.department;
    self.created_at.text = request.createdAt;
    self.status.text = request.status;
    self.askId.text = request.askId;
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
