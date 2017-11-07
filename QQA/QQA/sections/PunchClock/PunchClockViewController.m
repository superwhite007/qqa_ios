//
//  PunchClockViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "PunchClockViewController.h"
#import "PunchRecordViewController.h"

@interface PunchClockViewController ()

@end

@implementation PunchClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"app_face_logo"] forState:UIControlStateNormal];
    [self.view addSubview:punchCLockImageTileButton];
    
    
    UIButton * punchRecordButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    punchRecordButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 20, 100, 30);
    [punchRecordButtom setTitle:@"打卡记录" forState:UIControlStateNormal];
//    [punchRecordButtom setBackgroundImage:[UIImage imageNamed:@"red_button"] forState:UIControlStateNormal];
    [punchRecordButtom setTintColor:[UIColor blackColor]];
    punchRecordButtom.backgroundColor = [UIColor greenColor];
    [punchRecordButtom addTarget:self action:@selector(puchtoPunchRecordcontroller) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:punchRecordButtom];
    
    UIButton * scanButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    scanButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75, 100, 100);
//    [scanButtom setTitle:@"打卡记录" forState:UIControlStateNormal];
    [scanButtom setBackgroundImage:[UIImage imageNamed:@"scan_qrcode"] forState:UIControlStateNormal];
    [scanButtom setTintColor:[UIColor blackColor]];
    //    punchRecordButtom.backgroundColor = [UIColor blueColor]; scan_qrcode
    [self.view addSubview:scanButtom];
    
   
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125, 100, 30)];
    timeLable.backgroundColor = [UIColor greenColor];
    timeLable.text = @"00:00:01";
    timeLable.font = [UIFont fontWithName:@"Arial" size:18];
    timeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:timeLable];
    
    UILabel * workingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10, 200, 30)];
    workingTimeLable.backgroundColor = [UIColor greenColor];
    workingTimeLable.text = @"上班时间：08:30--17:30";
    workingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    workingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:workingTimeLable];
    
    
    UILabel * explainWorkingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10 + 40 , 300, 30)];
    explainWorkingTimeLable.backgroundColor = [UIColor greenColor];
    explainWorkingTimeLable.text = @"扫描公司打卡机上的二维码完成打卡";
    explainWorkingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    explainWorkingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:explainWorkingTimeLable];
    
    
    
    
}

-(void)puchtoPunchRecordcontroller{
    
    PunchRecordViewController * prVC = [[PunchRecordViewController alloc] init];

    [self.navigationController pushViewController:prVC animated:YES];
//    [self presentViewController:prVC animated:YES completion:nil];

    
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
