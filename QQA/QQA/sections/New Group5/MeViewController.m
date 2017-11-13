//
//  MeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MeViewController.h"
#import "LanchViewController.h"
#import "MeInformationViewController.h"
#import "AboutYouthViewController.h"

@interface MeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasource;


@end

@implementation MeViewController

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
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.datasource addObject:@"发起通知"];
    [self.datasource addObject:@"修改登录密码"];
    [self.datasource addObject:@"关于青春"];
  
    
    
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
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"Me"] forState:UIControlStateNormal];
//    [view addSubview:punchCLockImageTileButton];
    
    
    NSArray * labelNameArray = @[ @"imageString", @"姓名", @"名称", @"部门", @"职位", @"NO.", @"昵称", @"轻轻ID:"];
    UIImageView * imgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(20, iphoneWidth  / 9 , iphoneWidth * 4 / 9 , iphoneWidth * 4 / 9)];
    imgVIew.backgroundColor = [UIColor redColor];
    imgVIew.layer.cornerRadius = imgVIew.frame.size.width/2;
    
    imgVIew.clipsToBounds = YES;
//    UIImage *image = [UIImage imageNamed:labelNameArray[0]]; hongjinbao
    UIImage *image = [UIImage imageNamed:@"hongjinbao"];
    [imgVIew setImage:image];
    [view addSubview:imgVIew];
    
    for (int i = 1; i < 7; i++) {
        UILabel * label = [[UILabel alloc] init];
        if ( i > 0 && i < 7) {
             label.frame = CGRectMake(iphoneWidth * 5 / 9, iphoneWidth * 4 / 9  / 7 + ( iphoneWidth * 2 / 3 / 7  * (i - 1)), iphoneWidth  / 3, iphoneWidth * 4 / 9 / 7);
            
        }
        label.backgroundColor = [UIColor blueColor];
        [label setText:labelNameArray[i]];
        [view addSubview:label];
    }
    
    

    return  view ;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 300;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
    MeInformationViewController * meInformationVC = [MeInformationViewController new];
    [self.navigationController pushViewController:meInformationVC animated:YES];
        
    } else if (indexPath.row == 2){
        
        AboutYouthViewController * aboutYouthVC = [AboutYouthViewController new];
        [self.navigationController pushViewController:aboutYouthVC animated:YES];
        
    } else if (indexPath.row == 1){
        
        
    }
    
    
    
    
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
