//
//  ACPApprovalTableViewCell.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApprovalTableViewCell.h"
#import "ACPApproval.h"

@implementation ACPApprovalTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self addAllViews];
        
    }
    
    return self;
}


/*
@property (nonatomic, strong) UILabel * userFamily;
@property (nonatomic, strong) UILabel * username;
@property (nonatomic, strong) UILabel * department;
@property (nonatomic, strong) UILabel * created_at;
@property (nonatomic, strong) UILabel * type;
@property (nonatomic, strong) UILabel * status;
@property (nonatomic, strong) UILabel * leave_id;
*/

-(void)addAllViews{
    
    //heigh = 1000
    
    self.userFamily = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    [self.contentView addSubview:self.userFamily];
    
    self.username = [[UILabel alloc] initWithFrame:CGRectMake( 10, 2 , 100, 15)];
    [self.contentView addSubview:_username];
    
    self.department =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_username.frame) + 10, 2 , 100, 15)];
    [self.contentView addSubview:_department];

//    self.created_at = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 2 + 17 , 100, 15)];
//    [self.contentView addSubview:_created_at];

    self.type =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 2 + 17 * 2 , 300, 10)];
    [self.contentView addSubview:_type];

    self.status =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 2 + 17 * 3 , 300, 10)];
    [self.contentView addSubview:_status];
    
//    self.leave_id =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userFamily.frame) + 10 + 305, 2 + 17 * 3 , 100, 10)];
//    [self.contentView addSubview:leave_id];
    
}

-(void)setACPApproval:(ACPApproval *)aCPApproval{
    if (_aCPApproval != aCPApproval) {
        _aCPApproval = aCPApproval ;
    }
    self.username.text = aCPApproval.username;
//    self.userFamily.text = aCPApproval.username;
    self.department.text = aCPApproval.department;
//    self.created_at.text = aCPApproval.created_at;
    self.type.text = aCPApproval.type;
    self.status.text = aCPApproval.status;
//    self.leave_id.text = aCPApproval.leave_id;
    
    
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
