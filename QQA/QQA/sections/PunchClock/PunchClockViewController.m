//
//  PunchClockViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "PunchClockViewController.h"
#import "PunchRecordViewController.h"
#import "ScanImageViewController.h"



@interface PunchClockViewController ()<ScanImageView>

@end

@implementation PunchClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"app_face_logo"] forState:UIControlStateNormal];
    [self.view addSubview:punchCLockImageTileButton];
    
    
    UIButton * punchRecordButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    punchRecordButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 64 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 20, 100, 30);
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
    [scanButtom addTarget:self action:@selector(startScanssss) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)startScanssss{
    
    //    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
    //    [self presentViewController:scanImage animated:YES completion:nil];
    [self.navigationController  presentViewController:scanImage animated:YES completion:nil];
    
    
}




- (void)reportScanResult:(NSString *)result{
    NSLog(@"%@",result);
//    [self scanCrama:result];
//
    [self scanResultPunchClock];
    NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", dict);
    [self punchRecore:dict];
    
}

-(void)punchRecore:(NSDictionary *)dict{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/attendance"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    
    [mdict setObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TimeMachineFeatureCode"] ] forKey:@"timecardmachine_feature_code"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    
    
//    NSLog(@"resultDicresultmdict:%@ \n%@ \n %@", mdict, dict, resultDicAccess );
    
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            //                                            NSLog(@"response, error :%@, %@", response, error);
                                            //                                            NSLog(@"data:%@", data);
                                            
                                            if (data != nil) {
                                                NSLog(@"Punchsuccess");
                                                NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"%@", dict);
                                                
                                                //                                            NSMutableDictionary *ddict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                
//                                                [self gitAccess_token:dict];
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问李鹏");
                                            }
                                            
                                        }];
    [task resume];
    
    
    
}



-(void)scanResultPunchClock{
    
    
    NSLog(@"打卡成功");
    
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
