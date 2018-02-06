//
//  CompanyViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyViewController.h"
#import "LanchViewController.h"
#import "CompanyNoticeViewController.h"
#import "CompanyinformationAndBylawsViewController.h"
#import "CompanyOrganizationalStructureViewController.h"
#import "RulesDetailViewController.h"
#import "CompanyBylawsViewController.h"

@interface CompanyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;

@end

@implementation CompanyViewController

static NSString *identifier = @"CELL";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return  _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"青青";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:241  / 255.0 green:142  / 255.0 blue:91 / 255.0 alpha:1];
    [self.datasource addObject:@"公司通知"];
    [self.datasource addObject:@"规章制度"];
    [self.datasource addObject:@"公司信息"];
    [self.datasource addObject:@"组织架构与通讯录"];
    [self.datasource addObject:@"公司云盘"];
    UITableView * examinationAndApprovel = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    examinationAndApprovel.dataSource = self;
    examinationAndApprovel.delegate = self;
    examinationAndApprovel.rowHeight = 60;
    examinationAndApprovel.scrollEnabled = NO;
    //03设置分割线
    //    examinationAndApprovel.separatorColor = [UIColor orangeColor];
    examinationAndApprovel.sectionHeaderHeight =  [UIScreen mainScreen].bounds.size.width * 2 /3;
    [examinationAndApprovel registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:examinationAndApprovel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //if语句中可以为单元格中一些通用的属性赋值，例如可以在其辅助视图类型赋值,标示所有单元格都一直
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc ] init];
//    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"everyday_1"] forState:UIControlStateNormal];
    [view addSubview:punchCLockImageTileButton];
    return  view ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
          CompanyNoticeViewController * companyNoticeVC = [CompanyNoticeViewController new];
          [self.navigationController pushViewController:companyNoticeVC animated:YES];
        } else if (indexPath.row == 1) {
            CompanyBylawsViewController * companyBylawsVC = [CompanyBylawsViewController new];
            companyBylawsVC.transmitTitleLabel = @"规章制度";
            [self.navigationController pushViewController:companyBylawsVC animated:YES];
        } else if (indexPath.row == 2) {
//            CompanyinformationAndBylawsViewController * companyBylawsVC = [CompanyinformationAndBylawsViewController new];
//            companyBylawsVC.transmitTitleLabel = @"公司信息";
//            [self.navigationController pushViewController:companyBylawsVC animated:YES];
            RulesDetailViewController * detailVC = [[RulesDetailViewController alloc] init];
            detailVC.urlStr = [NSString stringWithFormat:@"http://qqoatest.youth.cn/v1/api/company/index"];
            if (detailVC.urlStr.length >0 ) {
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        } else if (indexPath.row == 3) {
            CompanyOrganizationalStructureViewController * organizationalStructurehVC = [CompanyOrganizationalStructureViewController new];
            [self.navigationController pushViewController:organizationalStructurehVC animated:YES];
        } else if (indexPath.row == 4) {
//            LanchViewController * lanchVC = [LanchViewController new];
//            [self.navigationController pushViewController:lanchVC animated:YES];
            [self alert:@"开发中、、、"];
        } else{
            LanchViewController * lanchVC = [LanchViewController new];
            [self.navigationController pushViewController:lanchVC animated:YES];
        }
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"请注意!";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
