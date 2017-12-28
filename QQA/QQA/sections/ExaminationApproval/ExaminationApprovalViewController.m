//
//  ExaminationApprovalViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ExaminationApprovalViewController.h"
#import "LanchViewController.h"
#import "IInitiatedtheExaminationTableViewController.h"
#import "ACPApprovelViewController.h"
#import "RequestAndLeaveDetailsViewController.h"

@interface ExaminationApprovalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;

@end

@implementation ExaminationApprovalViewController

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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:241  / 255.0 green:142  / 255.0 blue:91 / 255.0 alpha:1];
    [self.datasource addObject:@"发起审批"];
    [self.datasource addObject:@"待审批的"];
    [self.datasource addObject:@"已通过的"];
    [self.datasource addObject:@"未通过的"];
    [self.datasource addObject:@"抄送我的"];
    UITableView * examinationAndApprovel = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    examinationAndApprovel.dataSource = self;
    examinationAndApprovel.delegate = self;
    examinationAndApprovel.rowHeight = 60;
    examinationAndApprovel.scrollEnabled = NO;
    examinationAndApprovel.sectionHeaderHeight =  [UIScreen mainScreen].bounds.size.width * 2 /3;
    [examinationAndApprovel registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:examinationAndApprovel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc ] init];
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"everyday_1"] forState:UIControlStateNormal];
    [view addSubview:punchCLockImageTileButton];
    return  view ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IInitiatedtheExaminationTableViewController * examinationVC = [[IInitiatedtheExaminationTableViewController alloc] initWithStyle:(UITableViewStylePlain)];
    if (indexPath.row == 0) {
        examinationVC.titleIdentifier = @"发起审批";
    } else if (indexPath.row == 1) {
        examinationVC.titleIdentifier = @"待审批的";
    } else if (indexPath.row == 2) {
        examinationVC.titleIdentifier = @"已通过的";
    } else if (indexPath.row == 3) {
        examinationVC.titleIdentifier = @"未通过的";
    } else if (indexPath.row == 4) {
        examinationVC.titleIdentifier = @"抄送我的";
    }
    [self.navigationController pushViewController:examinationVC animated:YES];
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
