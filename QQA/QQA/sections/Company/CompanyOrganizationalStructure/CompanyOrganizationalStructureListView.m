//
//  CompanyOrganizationalStructureListView.m
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyOrganizationalStructureListView.h"

@implementation CompanyOrganizationalStructureListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addOneTableView];
    }
    return self;
}


-(void)addOneTableView{
    _tableView = [UITableView new];
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
