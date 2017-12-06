//
//  CompanyAddressBookViewController.h
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyAddressBookViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString * departmentName;
@property (nonatomic, strong) NSString * departmentId;

@end
