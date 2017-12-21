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

@property (nonatomic, strong) UILabel * timeLable;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation PunchClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:241  / 255.0 green:142  / 255.0 blue:91 / 255.0 alpha:1];
    
    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
    punchCLockImageTileButton.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"app_face_logo"] forState:UIControlStateNormal];
    [self.view addSubview:punchCLockImageTileButton];
    
    UIButton * punchRecordButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    punchRecordButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 64 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 20, 100, 30);
    [punchRecordButtom setTitle:@"打卡记录" forState:UIControlStateNormal];
    [punchRecordButtom setTintColor:[UIColor whiteColor]];
    punchRecordButtom.backgroundColor = [UIColor blackColor];
    [punchRecordButtom addTarget:self action:@selector(puchtoPunchRecordcontroller) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:punchRecordButtom];
    
    UIButton * scanButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    scanButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75, 100, 100);
    [scanButtom setBackgroundImage:[UIImage imageNamed:@"scan_qrcode"] forState:UIControlStateNormal];
    [scanButtom setTintColor:[UIColor blackColor]];
    [scanButtom addTarget:self action:@selector(startScanssss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButtom];

    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125, 200, 30)];
    _timeLable.font = [UIFont fontWithName:@"Arial" size:18];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:_timeLable];
    
    UILabel * workingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10, 200, 30)];
    workingTimeLable.text = @"上班时间：08:30--17:30";
    workingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    workingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:workingTimeLable];
    UILabel * explainWorkingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300 ) / 2 , 44 + [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10 + 40 , 300, 30)];
    explainWorkingTimeLable.text = @"扫描公司打卡机上的二维码完成打卡";
    explainWorkingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    explainWorkingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:explainWorkingTimeLable];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [_timer invalidate];
    _timer = nil;
    
}

-(void)ssssssss{
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getNowTime) userInfo:nil repeats:YES];
    //每1秒运行一次function方法。
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
}


- (void)getNowTime {
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    _timeLable.text = [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:senddate]];
}


-(void)startScanssss{
    
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
    [self.navigationController  presentViewController:scanImage animated:YES completion:nil];
    
}

- (void)reportScanResult:(NSString *)result{
    
    [self scanResultPunchClock];
    NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
    [self punchRecore:dict];
    
}

-(void)punchRecore:(NSDictionary *)dict{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/attendance", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"TimeMachineFeatureCode"] ] forKey:@"timecardMachineFeatureCode"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
//    NSLog(@"resultDicresultmdict:%@ \n", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"%@", dict);
                                                NSString * str = [NSString stringWithFormat:@"%@", [dict objectForKey:@"message"]];
                                                if ([str isEqualToString:@"3003"]) {
                                                    [self alert:@"打卡成功!"];
                                                } else{
                                                    [self alert:@"打卡失败!"];
                                                }
                                            } else{
                                                [self alert:@"打卡失败!"];
                                            }
                                            
                                        }];
    [task resume];

}

-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"请注意";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
}

-(void)scanResultPunchClock{
    //NSLog(@"打卡成功");
}


-(void)puchtoPunchRecordcontroller{
    
    PunchRecordViewController * prVC = [[PunchRecordViewController alloc] init];
    [self.navigationController pushViewController:prVC animated:YES];
    
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
