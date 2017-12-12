//
//  AppCoverViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/2.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppCoverViewController.h"
#import "ScanImageViewController.h"
#import <AVFoundation/AVFoundation.h>

#define  iphoneWidth    [[UIScreen mainScreen] bounds].size.width
#define  iphoneHeight   [[UIScreen mainScreen] bounds].size.height

#import "AppTBViewController.h"
#import "AppDelegate.h"


@interface AppCoverViewController ()<ScanImageView>

//数据持久化存储
//@property (nonatomic, strong) NSMutableDictionary * documentTxtPathDictionary;
@property (nonatomic, strong) NSString * documentTxtPath;

@end

@implementation AppCoverViewController

//-(NSMutableDictionary *)documentTxtPathDictionary{
//    if (!_documentTxtPathDictionary) {
//        self.documentTxtPathDictionary = [[NSMutableDictionary alloc] init];
//    }
//    return _documentTxtPathDictionary;
//}

//-(NSString *)documentTxtPath{
//    if (!_documentTxtPath) {
//        self.documentTxtPath = [[NSString alloc] init];
//    }
//    return _documentTxtPath;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    //数据持久化存储
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentfilePath = paths.firstObject;
    _documentTxtPath = [documentfilePath stringByAppendingPathComponent:@"bada.txt"];
    
    [self setAppCoverImageName:@"app_face.png"  title:@"V00.00.01"];
    
}


-(void)setAppCoverImageName:(NSString *)imageName   title:(NSString *)title{
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, iphoneWidth, iphoneHeight);
    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:imageName];
    [imgView setImage:image];
    
    [self.view addSubview:imgView];
    
    
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    UIButton  * welcomeButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [welcomeButton setFrame:CGRectMake( (iphoneWidth - 200) / 2,  (iphoneHeight - 30) - 160, 200, 30)];
    [welcomeButton setTitle:title forState:UIControlStateNormal];
    welcomeButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [welcomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [welcomeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

    [imgView addSubview:welcomeButton];
    imgView.userInteractionEnabled=YES;

    
}


- (void)clicked:(id)sender{
    
    [self setFirstLogin:@"首次登陆"  buttonTitle:@"下一步"];
    
}

-(void)setFirstLogin:(NSString *)loginString   buttonTitle:(NSString *)buttonTitle{
    
    UIView * firstAPPLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    firstAPPLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstAPPLoginView];
    
    UILabel * firstLoginTitleLable = [[UILabel alloc] initWithFrame:CGRectMake((iphoneWidth - 100) / 2, 64, 100, 30)];
    firstLoginTitleLable.text = loginString;
//    firstLoginTitleLable.backgroundColor = [UIColor redColor];
    firstLoginTitleLable.textAlignment =  NSTextAlignmentCenter;
    firstLoginTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:firstLoginTitleLable];
    
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake((iphoneWidth - 100) / 2, 110, 100, 100);
//    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"info.png"];
    [imgView setImage:image];
    
    [firstAPPLoginView addSubview:imgView];
    
    UILabel * plantIDKeyLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 200, 30)];
    plantIDKeyLable.text = @"种植IDKey";
//    plantIDKeyLable.backgroundColor = [UIColor redColor];
    plantIDKeyLable.textAlignment =  NSTextAlignmentLeft;
    plantIDKeyLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:plantIDKeyLable];
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, iphoneWidth - 40, 90)];
    plantIDKeyExplianLable.text = @"首次登陆或者丢失IDKey的同事，需要在手机内种植IDKey，该IDKey会授权只有此手机可以登陆青青OA系统。                                                请不要择换其它手机登录，因为只有种植IDKey的手机才可以登录。";
//    plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
    plantIDKeyExplianLable.textAlignment =  NSTextAlignmentLeft;
//    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSize = [plantIDKeyExplianLable.text boundingRectWithSize:CGSizeMake(200, 150) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    plantIDKeyExplianLable.frame = CGRectMake(plantIDKeyExplianLable.frame.origin.x, plantIDKeyExplianLable.frame.origin.y, plantIDKeyExplianLable.frame.size.width, labelSize.height);
    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    
    [firstAPPLoginView addSubview:plantIDKeyExplianLable];
    
    
    
    
    UILabel * mattersNeedAttentionLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, 200, 30)];
    mattersNeedAttentionLable.text = @"注意事项";
//    mattersNeedAttentionLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionLable.textAlignment =  NSTextAlignmentLeft;
    mattersNeedAttentionLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:mattersNeedAttentionLable];
    
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectZero];
    mattersNeedAttentionExplianLable.text = @"请不要删除青青OA，也不要清理青青OA中的数据。否则IOKey丢失，导致无法登录。";

    
//    mattersNeedAttentionExplianLable.textAlignment =  NSTextAlignmentLeft;
//    //    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
//    CGSize labelSizemattersNeedAttentionExplian = [mattersNeedAttentionExplianLable.text boundingRectWithSize:CGSizeMake(200, 150) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    mattersNeedAttentionExplianLable.frame = CGRectMake(mattersNeedAttentionExplianLable.frame.origin.x, mattersNeedAttentionExplianLable.frame.origin.y, mattersNeedAttentionExplianLable.frame.size.width, labelSizemattersNeedAttentionExplian.height);
//    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
//    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [mattersNeedAttentionExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : mattersNeedAttentionExplianLable.font} context:nil];
    mattersNeedAttentionExplianLable.frame = CGRectMake(20, 435, iphoneWidth - 40, CGRectGetHeight(targetRect));
    
    
    [firstAPPLoginView addSubview:mattersNeedAttentionExplianLable];
    
    
    
    
    
    
    UIButton  * nestStepButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [nestStepButton setFrame:CGRectMake( 60,  iphoneHeight * 3 / 4 , iphoneWidth -120, 50)];
    [nestStepButton setTitle:buttonTitle forState:UIControlStateNormal];
    nestStepButton.titleLabel.font = [UIFont systemFontOfSize:24];
    nestStepButton.backgroundColor = [UIColor redColor];
    [nestStepButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nestStepButton addTarget:self action:@selector(plantIDKey) forControlEvents:UIControlEventTouchUpInside];
    
    [firstAPPLoginView addSubview:nestStepButton];
    
    
    
}
    
-(void)plantIDKey{
    
    UIView * plantIDEeyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    plantIDEeyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:plantIDEeyView];
    
    UILabel * plantIDKeyLable = [[UILabel alloc] initWithFrame:CGRectMake((iphoneWidth - 200) / 2, 64, 200, 30)];
    plantIDKeyLable.text = @"种植IDKey";
//        plantIDKeyLable.backgroundColor = [UIColor redColor];
    plantIDKeyLable.textAlignment =  NSTextAlignmentCenter;
    plantIDKeyLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [plantIDEeyView addSubview:plantIDKeyLable];
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectZero];
    plantIDKeyExplianLable.text = @"1.如果是新入职的同事，请让技术研发中心的技术人员先帮您创建一个OA账号。\n\n 2.种植IDKey，技术人员会在OA的后台里为您的账号创建一个新的IDKey二维码。通过用手机OA扫描该二维码，IDKey会植入手机内。\n\n 3.扫描时，请确保您的手机连上互联网，种植会很快完成。";
    
//        plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
//    plantIDKeyExplianLable.textAlignment =  NSTextAlignmentLeft;
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
//    CGSize labelSize = [plantIDKeyExplianLable.text boundingRectWithSize:CGSizeMake(300, 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    plantIDKeyExplianLable.frame = CGRectMake(plantIDKeyExplianLable.frame.origin.x, plantIDKeyExplianLable.frame.origin.y, plantIDKeyExplianLable.frame.size.width, labelSize.height);
//    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
//    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    
    
    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
    plantIDKeyExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [plantIDKeyExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : plantIDKeyExplianLable.font} context:nil];
    plantIDKeyExplianLable.frame = CGRectMake(20, 130, iphoneWidth - 40, CGRectGetHeight(targetRect));
    
    
    [plantIDEeyView addSubview:plantIDKeyExplianLable];
    
    
    UIButton  * scanButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [scanButton setFrame:CGRectMake( 60,  iphoneHeight * 3 / 4 , iphoneWidth -120, 50)];
    [scanButton setTitle:@"扫码种植IDKey" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:24];
    scanButton.backgroundColor = [UIColor redColor];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(startScanssss) forControlEvents:UIControlEventTouchUpInside];
    
    [plantIDEeyView addSubview:scanButton];
    
    
}


-(void)startScanssss{
    
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
//    iOS 判断应用是否有使用相机的权限
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [self  alert:errorStr];
        return;
    }
    [self.navigationController  presentViewController:scanImage animated:YES completion:nil];
    
}

- (void)reportScanResult:(NSString *)result{
    NSLog(@"11111%@",result);
//    [self scanCrama:result];
    
    NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
    [dict removeObjectForKey:@"serverType"];
    
    NSMutableDictionary * ddict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentfilePath = paths.firstObject;
    NSString *txtPath = [documentfilePath stringByAppendingPathComponent:@"bada.txt"];
    [ddict writeToFile:txtPath atomically:YES];
    
    [self clientSendInformationsToServer:dict resultString:result];
 
}

-(void)clientSendInformationsToServer:(NSMutableDictionary *)clinetDictionaryDIct  resultString:(NSString *)str{
    

    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/receive", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    [clinetDictionaryDIct setValue:@"IOS_APP" forKey:@"clientType"];
    NSDictionary * dataDic = clinetDictionaryDIct;
   
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    

    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            NSLog(@"response, error :%@, %@", response, error);
                                            NSLog(@"data:%@", data);
                                            
                                            if (data != nil) {
                                                //NSLog(@"PlantKeysuccess");
                                            NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

                                              [self gitaccessToken:dict];
                                                
//                                                [self plantIDKeyFalse];
                                             
                                            } else{
                                                //NSLog(@"获取数据失败，问李鹏");
                                                
                                            }
                                            
                                        }];
    [task resume];
    
}


-(void)gitaccessToken:(NSDictionary *)dict{
    
    NSLog(@"gitaccessToken:dictss:%@", dict);
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    [mdict removeObjectForKey:@"serverType"];
    [mdict removeObjectForKey:@"status"];
    [mdict removeObjectForKey:@"code"];
    
    
    [mdict setObject:@"client_credentials" forKey:@"grantType"];
    [mdict setObject:@"1" forKey:@"clientId"];
    [mdict setObject:@"rgQx0K4ibiNVzIYhltqaRj9g8gr0w3T1fa8XKUz3" forKey:@"clientSecret"];
    [mdict setObject:@"1" forKey:@"scope"];
    
//    [mdict writeToFile:_documentTxtPath atomically:YES];
    
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/login", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            //NSLog(@"tokenresponse, error :%@, %@", response, error);
                                            //NSLog(@"tokendata:%@", data);
                                            if (data != nil) {
                                                //NSLog(@"tokensuccess");
                                                NSMutableDictionary * dictss =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]
                                                ;
                                               
                                                //NSLog(@"tokensuccess:%@",dictss);
//                                              //NSLog(@"token%@", [dictss objectForKey:@"accessToken"]);
//                                              NSString * newStr = [NSString new];
                                                [self scanCrama:dictss];
                                                
                                            } else{
                                                //NSLog(@"token:获取数据失败，问李鹏");
                                            }
                                            
                                        }];
    [task resume];
    
}



-(void)scanCrama:(NSMutableDictionary *)mDict {
    
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentfilePath = paths.firstObject;
    NSString *txtPath = [documentfilePath stringByAppendingPathComponent:@"badaAccessToktn.txt"];
    [mDict  writeToFile:txtPath atomically:YES];
    
  
    int result = 0;
    
    if (result == 1) {
        [self scanSuccess:@"https://"];
    } else if (result == 0) {
        
//        [self alert];
        NSString *title = [mDict objectForKey:@"accessToken"];
        NSString *message = @"扫码成功";
        NSString *okButtonTitle = @"OK";
        UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [self  plantIDKey];
             [self scanSuccess:@"https://"];
        }];
        
        [alertDialog addAction:okAction];

        [self.navigationController  presentViewController:alertDialog animated:YES completion:nil];
    }
    
}

-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"I need your attention NOW!";
    NSString *okButtonTitle = @"OK";
    // 初始化
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // 创建操作
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 操作具体内容
        // Nothing to do.
    }];
    
    // 添加操作
    [alertDialog addAction:okAction];
    
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
    
}


-(void)scanSuccess:(NSString *)urlString{
    
    UIView * scanSuccessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    scanSuccessView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scanSuccessView];
    
    UILabel * plantIDKeySuccessLable = [[UILabel alloc] initWithFrame:CGRectMake((iphoneWidth - 200) / 2, 64, 200, 30)];
    plantIDKeySuccessLable.text = @"种植IDKey完成";
//    plantIDKeySuccessLable.backgroundColor = [UIColor redColor];
    plantIDKeySuccessLable.textAlignment =  NSTextAlignmentCenter;
    plantIDKeySuccessLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [scanSuccessView addSubview:plantIDKeySuccessLable];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake((iphoneWidth - 150) / 2, 114, 150, 150);
    //    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"checkmark_green"];
    [imgView setImage:image];
    
    [scanSuccessView addSubview:imgView];
    
    
    UILabel * mattersNeedAttentionLable = [[UILabel alloc] initWithFrame:CGRectMake((iphoneWidth - 200) / 2, 284, 200, 30)];
    mattersNeedAttentionLable.text = @"注意事项";
//    mattersNeedAttentionLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionLable.textAlignment =  NSTextAlignmentCenter;
    mattersNeedAttentionLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [scanSuccessView addSubview:mattersNeedAttentionLable];
    
    
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(30 , 340, iphoneWidth - 60 , 120)];
    mattersNeedAttentionExplianLable.text = @"请不要删除青青OA，也不要清理青青OA中的数据。否则IOKey丢失，导致无法登录。";
    
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [mattersNeedAttentionExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : mattersNeedAttentionExplianLable.font} context:nil];
    mattersNeedAttentionExplianLable.frame = CGRectMake(30, 340, iphoneWidth - 40, CGRectGetHeight(targetRect));
    
  
    [scanSuccessView addSubview:mattersNeedAttentionExplianLable];
    
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight * 3 / 4 - 60, iphoneWidth - 40, 50)];
    nameLable.text = @"用户 ：小明";
//    nameLable.backgroundColor = [UIColor redColor];
    nameLable.textAlignment =  NSTextAlignmentCenter;
    nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
//    [scanSuccessView addSubview:nameLable];

    
#pragma tset
    
    UIButton  * scanButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [scanButton setFrame:CGRectMake( 60,  iphoneHeight * 3 / 4 , iphoneWidth -120, 50)];
    [scanButton setTitle:@"下一步" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:24];
    scanButton.backgroundColor = [UIColor redColor];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(goBbackToAPP:) forControlEvents:UIControlEventTouchUpInside];
    
    [scanSuccessView addSubview:scanButton];
    
    
    UILabel * statementLable = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight - 60, iphoneWidth - 40, 30)];
    statementLable.text = @"2017 版权所有 ：中国青年网";
//    statementLable.backgroundColor = [UIColor redColor];
    statementLable.textAlignment =  NSTextAlignmentCenter;
    statementLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    
    [scanSuccessView addSubview:statementLable];
    
    
}

-(void)goBbackToAPP:(NSString *)userInfomation{
    
    AppTBViewController *appTBVController = [AppTBViewController new];
    UINavigationController * tbNC = [[UINavigationController alloc] initWithRootViewController:appTBVController];
     ((AppDelegate *)([UIApplication sharedApplication].delegate)).window.rootViewController = tbNC;
    
}



-(void)plantIDKeyFalse{
    
    UIView * plantIDKeyFalseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    plantIDKeyFalseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:plantIDKeyFalseView];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake((iphoneWidth - 200) / 2, 64, 220, 400);
    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"plantIDKeyFalse"];
    [imgView setImage:image];
    
    [plantIDKeyFalseView addSubview:imgView];
    
    UILabel * statementLable = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight * 3 / 4  - 100, iphoneWidth - 40, 30)];
    statementLable.text = @"种植IDKey失败";
    //    statementLable.backgroundColor = [UIColor redColor];
    statementLable.textAlignment =  NSTextAlignmentCenter;
    statementLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    
    [plantIDKeyFalseView addSubview:statementLable];
    
    
    UIButton  * scanButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    
    //    statementLable.frame.origin.y + statementLable.frame.size.height
    
    [scanButton setFrame:CGRectMake( 60,  iphoneHeight * 3 / 4 , iphoneWidth -120, 50)];
    [scanButton setTitle:@"重新扫描" forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:24];
    scanButton.backgroundColor = [UIColor redColor];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(removeViewFroSuperVIew) forControlEvents:UIControlEventTouchUpInside];
    
    [plantIDKeyFalseView addSubview:scanButton];
    
    
    
}


-(void)removeViewFroSuperVIew{
    
//    [view removeFromSuperview];
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
