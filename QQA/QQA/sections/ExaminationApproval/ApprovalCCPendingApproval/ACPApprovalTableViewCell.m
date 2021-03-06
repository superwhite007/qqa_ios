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

-(void)addAllViews{
    //heigh = 1000
    self.userFamily = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    self.userFamily.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    self.userFamily.layer.cornerRadius = 30;
    self.userFamily.layer.masksToBounds = YES;
    self.userFamily.textAlignment = NSTextAlignmentCenter;
    self.userFamily.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:self.userFamily];
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userFamily.frame) + 10, 10 , 100, 20)];
    [self.contentView addSubview:_username];
    self.department =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_username.frame) + 10, 10 , iphoneWidth -  CGRectGetMaxX(_username.frame) - 10, 20)];
    self.department.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_department];
    self.created_at = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 120, 40 , 200, 20)];
    [self.contentView addSubview:_created_at];
    self.type =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 40 , 100, 20)];
    [self.contentView addSubview:_type];
    self.status =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 70 , 300, 20)];
    [self.contentView addSubview:_status];
}

-(void)setACPApproval:(ACPApproval *)aCPApproval{
    if (_aCPApproval != aCPApproval) {
        _aCPApproval = aCPApproval ;
    }
    self.username.text = aCPApproval.username;
    self.userFamily.text = [aCPApproval.username substringToIndex:1];
    self.department.text = aCPApproval.department;
    self.created_at.text = aCPApproval.createdAt;
//    self.type.text = aCPApproval.type;////////
    self.status.text = aCPApproval.status;
    self.leave_id.text = aCPApproval.leaveId;
    //@"调休", @"年假", @"婚假", @"产假", @"病假", @"事假", @"丧假", @"工伤假", @"其他", nil];
    if ([aCPApproval.status isEqualToString:@"Unapproved"]) {
        self.status.text = [NSString stringWithFormat:@"审批中"];
    } else  if ([aCPApproval.status isEqualToString:@"Agreed"]) {
        self.status.text = [NSString stringWithFormat:@"已同意"];
    }else  if ([aCPApproval.status isEqualToString:@"Denyed"]) {
        self.status.text = [NSString stringWithFormat:@"已拒绝"];
    }
    if ([aCPApproval.type isEqualToString:@"100"]) {
        self.type.text =  @"调休";
    } else if ([aCPApproval.type isEqualToString:@"101"]){
        self.type.text =  @"年假";
    } else if ([aCPApproval.type isEqualToString:@"102"]){
        self.type.text = @"婚假";
    } else if ([aCPApproval.type isEqualToString:@"103"]){
        self.type.text =  @"产假";
    } else if ([aCPApproval.type isEqualToString:@"104"]){
        self.type.text =  @"病假";
    } else if ([aCPApproval.type isEqualToString:@"105"]){
        self.type.text = @"事假";
    } else if ([aCPApproval.type isEqualToString:@"106"]){
        self.type.text = @"丧假";
    } else if ([aCPApproval.type isEqualToString:@"107"]){
        self.type.text =  @"工伤假";
    } else if ([aCPApproval.type isEqualToString:@"108"]){
        self.type.text = @"外出";
    } else if ([aCPApproval.type isEqualToString:@"109"]){
        self.type.text = @"其他";
    }
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
