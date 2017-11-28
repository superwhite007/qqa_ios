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

    self.created_at = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 120, 40 , 200, 20)];
    [self.contentView addSubview:_created_at];

    self.type =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 40 , 100, 20)];
    [self.contentView addSubview:_type];

    self.status =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userFamily.frame) + 10, 70 , 300, 20)];
    [self.contentView addSubview:_status];
    
//    self.leave_id =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userFamily.frame) + 10 + 305, 2 + 17 * 3 , 100, 10)];
//    [self.contentView addSubview:leave_id];
    
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
        self.type.text = @"其他";
        
    }
     
    
}



//@"调休", @"年假", @"婚假", @"产假", @"病假", @"事假", @"丧假", @"工伤假", @"其他", nil];

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
