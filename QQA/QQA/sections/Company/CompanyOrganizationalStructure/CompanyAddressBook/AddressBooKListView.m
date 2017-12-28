//
//  AddressBooKListView.m
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AddressBooKListView.h"

@implementation AddressBooKListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCostomTableview];
    }
    return self;
}

-(void)addCostomTableview{
    self.tableView = [UITableView new];
    [self addSubview:_tableView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
