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
#import "CycleScrollView.h"
#import "SDCycleScrollView.h"

@interface PunchClockViewController ()<ScanImageView, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UILabel * timeLable;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSMutableArray * cyclePicturesDatasource;
@property (nonatomic , retain) CycleScrollView *mainScorllView;

@end

@implementation PunchClockViewController

-(NSMutableArray *)cyclePicturesDatasource{
    if (!_cyclePicturesDatasource) {
        self.cyclePicturesDatasource = [NSMutableArray array];
    }
    return _cyclePicturesDatasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCycleScrollPitures];

    // Do any additional setup after loading the view.
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;


//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:238  / 255.0 green:0  / 255.0 blue:0 / 255.0 alpha:0.5];
//    UIButton * punchCLockImageTileButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    punchCLockImageTileButton.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3);
//    punchCLockImageTileButton.backgroundColor = [UIColor redColor];
//    [punchCLockImageTileButton setBackgroundImage:[UIImage imageNamed:@"everyday_1"] forState:UIControlStateNormal];
//    [self.view addSubview:punchCLockImageTileButton];
    
    UIImageView * imageViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width * 2 / 3)];
    [imageViewHeader setImage:[UIImage imageNamed:@"everyday_1"]];
    [self.view addSubview:imageViewHeader];
    
    UIButton * punchRecordButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    punchRecordButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 150 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 20, 150, 30);
    [punchRecordButtom setTitle:@"打卡记录" forState:UIControlStateNormal];
    punchRecordButtom.layer.cornerRadius = 5;
    [punchRecordButtom setTintColor:[UIColor whiteColor]];
    punchRecordButtom.backgroundColor = [UIColor colorWithRed: 190 / 255.0 green:190 / 255.0 blue:190 / 255.0 alpha:1];
    [punchRecordButtom addTarget:self action:@selector(puchtoPunchRecordcontroller) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:punchRecordButtom];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 150 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 20, 30, 30)];
    [imageView setImage:[UIImage imageNamed:@"history"]];
    [self.view addSubview:imageView];
    
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 150 ) / 2 + 124, [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 22, 25, 26)];
    [imageView2 setImage:[UIImage imageNamed:@"forward"]];
    imageView2.alpha = 0.5;
    [self.view addSubview:imageView2];
    
    
    UIButton * scanButtom = [UIButton buttonWithType:UIButtonTypeSystem];
    scanButtom.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 85, 100, 100);
    scanButtom.backgroundColor = [UIColor colorWithRed:0 green:.99 blue:0 alpha:1];
    scanButtom.layer.cornerRadius = 5;
    [scanButtom setBackgroundImage:[UIImage imageNamed:@"scan_qrcode"] forState:UIControlStateNormal];
    scanButtom.tintColor = [UIColor redColor];
    [scanButtom setTintColor:[UIColor blackColor]];
    [scanButtom addTarget:self action:@selector(startScanssss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButtom];

    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 140, 200, 30)];
    _timeLable.font = [UIFont fontWithName:@"Arial" size:16];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:_timeLable];
    
    UILabel * workingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 200 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10, 200, 30)];
    workingTimeLable.text = @"上班时间：08:30--17:30";
    workingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    workingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:workingTimeLable];
    
    UIImageView * imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 300 ) / 2 , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10 + 28 , 25, 25)];
    [imageView3 setImage:[UIImage imageNamed:@"rules"]];
    [self.view addSubview:imageView3];
    
    UILabel * explainWorkingTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 250 ) / 2  , [[UIScreen mainScreen] bounds].size.width * 2 / 3 + 75 + 125 + 30 + 10 + 25 , 300, 30)];
    explainWorkingTimeLable.text = @"扫描公司打卡机上的二维码完成打卡";
    explainWorkingTimeLable.font = [UIFont fontWithName:@"Arial" size:18];
    explainWorkingTimeLable.textAlignment = NSTextAlignmentCenter;
    [self.view  addSubview:explainWorkingTimeLable];
    
}

-(void)addCyclePictures{
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i < 3; ++i) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"everyday_1"]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
        [viewsArray addObject:imgView];
    }
    if (_cyclePicturesDatasource.count > 0) {
        for (int i = 0; i < 3; ++i) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL * url = [NSURL URLWithString:_cyclePicturesDatasource[i]];
                NSData * data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
                    imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
                    viewsArray[i] = imgView;
                });
            });
        }
    }
    // 网络加载 --- 创建带标题的图片轮播器
    NSArray *imagesURL = _cyclePicturesDatasource;
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneWidth * 2 /3) imageURLStringsGroup:imagesURL];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.pageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView2];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}
//-(void)addCyclePictures{
//
//    NSMutableArray *viewsArray = [@[] mutableCopy];
//    if (_cyclePicturesDatasource.count > 0) {
//        for (int i = 0; i < 3; ++i) {
//            NSURL * url = [NSURL URLWithString:_cyclePicturesDatasource[i]];
//            NSData * data = [NSData dataWithContentsOfURL:url];
//            UIImage *img = [UIImage imageWithData:data];
//            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//            imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
//            [viewsArray addObject:imgView];
//        }
//    } else{
//        for (int i = 0; i < 3; ++i) {
//            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"everyday_1"]];
//            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//            imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
//            [viewsArray addObject:imgView];
//        }
//    }
//
//
//    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3 ) animationDuration:1];
//    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
//    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
//        return viewsArray[pageIndex];
//    };
//    self.mainScorllView.totalPagesCount = ^NSInteger(void){
//        return 3;
//    };
//    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
//        NSLog(@"点击了第%ld个",(long)pageIndex);
//    };
//    [self.view addSubview:self.mainScorllView];
//
//}

-(void)viewWillAppear:(BOOL)animated{
    [self ssssssss];
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
    _timeLable.text = [NSString stringWithFormat:@"当前时间：%@", [dateformatter stringFromDate:senddate]];
}


-(void)startScanssss{
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
    [self.navigationController  presentViewController:scanImage animated:YES completion:nil];
}

- (void)reportScanResult:(NSString *)result{
    [self competeScanResult:result];
}

-(void)competeScanResult:(NSString *)result{
    NSLog(@"resultresult:%@", result);
    if([result rangeOfString:@"TimeMachineFeatureCode"].location !=NSNotFound && [result rangeOfString:@"code"].location !=NSNotFound ){
        NSLog(@"yes");
        [self scanResultPunchClock];
        NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
        [self punchRecore:dict];
    }else{
        NSLog(@"no");
        [self alert:@"异常二维码"];
    }
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
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
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

-(void)getCycleScrollPitures{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/company/getImg", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (error) {
                                                NSLog(@"Noticeredpoint服务器返回错误：%@", error);
                                            }else {
                                                
                                                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                if ( [object isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Notice出现异常，服务器约定为字典类型");
                                                }else if ([object isKindOfClass:[NSDictionary class]]){
                                                    if ([[object objectForKey:@"message"] intValue] != 30001 ) {
                                                        NSLog(@"Notice服务获得到数据，但是数据异常");
                                                    }else {
                                                        
                                                        _cyclePicturesDatasource = [[object  objectForKey:@"data"] objectForKey:@"img"];
                                                        NSLog(@"_cyclePicturesDatasource:%@", _cyclePicturesDatasource);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self addCyclePictures];
                                                        });
                                                    }
                                                }
                                            }
                                        }];
    [task resume];
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
