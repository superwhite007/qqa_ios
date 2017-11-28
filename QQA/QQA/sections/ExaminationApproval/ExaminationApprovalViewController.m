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

#import "IInitiatedtheExaminationViewController.h"

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
    
//    UILabel *aLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
//    aLable.text = @"青春";
//    aLable.textColor = [UIColor yellowColor];
//    aLable.textAlignment = NSTextAlignmentCenter;
//    aLable.font = [UIFont italicSystemFontOfSize:17];
//    aLable.backgroundColor = [UIColor redColor];
//    //允许我们自定义当前视图控制器的标题视图，可以是任意UIView子类创建的视图
//    self.navigationItem.titleView = aLable;
    
    [self.navigationItem setTitle:@"青春"];
    
    
    
    
    [self.datasource addObject:@"发起审批"];
    [self.datasource addObject:@"待审批的"];
    [self.datasource addObject:@"已审批的"];
    [self.datasource addObject:@"未审批的"];
    [self.datasource addObject:@"抄送我的"];
    
    
    UITableView * examinationAndApprovel = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    examinationAndApprovel.dataSource = self;
    examinationAndApprovel.delegate = self;
    examinationAndApprovel.rowHeight = 60;
    //03设置分割线
//    examinationAndApprovel.separatorColor = [UIColor orangeColor];
    examinationAndApprovel.sectionHeaderHeight =  [UIScreen mainScreen].bounds.size.width * 2 /3;
    
    [examinationAndApprovel registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    
    [self.view addSubview:examinationAndApprovel];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
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
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"app_face_logo"] forState:UIControlStateNormal];
    [view addSubview:punchCLockImageTileButton];
    
    
    return  view ;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 300;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        IInitiatedtheExaminationViewController * examinationVC = [[IInitiatedtheExaminationViewController alloc] init];
        [self.navigationController pushViewController:examinationVC animated:YES];

    } else if (indexPath.row == 1) {
        RequestAndLeaveDetailsViewController * examinationVC = [[RequestAndLeaveDetailsViewController alloc] init];
        [self.navigationController pushViewController:examinationVC animated:YES];
        
    } else if (indexPath.row == 3) {
        ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
        [self.navigationController pushViewController:examinationVC animated:YES];
        
    } else {
        LanchViewController * lanchVC = [LanchViewController new];
        [self.navigationController pushViewController:lanchVC animated:YES];
    }

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
