//
//  CompanyBylawsViewController.h
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyBylawsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *   transmitTitleLabel;
@property (nonatomic, strong) UITableView * tableView;

@end
