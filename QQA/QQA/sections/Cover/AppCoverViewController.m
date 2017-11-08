//
//  AppCoverViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/2.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppCoverViewController.h"
#import "ScanImageViewController.h"


#define  iphoneWidth    [[UIScreen mainScreen] bounds].size.width
#define  iphoneHeight   [[UIScreen mainScreen] bounds].size.height

#import "AppTBViewController.h"
#import "AppDelegate.h"


@interface AppCoverViewController ()<ScanImageView>

@end

@implementation AppCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    

    
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
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, iphoneWidth - 40, 90)];
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
    
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 440, iphoneWidth - 40, 90)];
    mattersNeedAttentionExplianLable.text = @"请不要删除青青OA，也不要清理青青OA中的数据。否则IOKey丢失，导致无法登录。";
//    mattersNeedAttentionExplianLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionExplianLable.textAlignment =  NSTextAlignmentLeft;
    //    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSizemattersNeedAttentionExplian = [mattersNeedAttentionExplianLable.text boundingRectWithSize:CGSizeMake(200, 150) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    mattersNeedAttentionExplianLable.frame = CGRectMake(mattersNeedAttentionExplianLable.frame.origin.x, mattersNeedAttentionExplianLable.frame.origin.y, mattersNeedAttentionExplianLable.frame.size.width, labelSizemattersNeedAttentionExplian.height);
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    
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
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, iphoneWidth - 40, 250)];
    plantIDKeyExplianLable.text = @"1.如果是新入职的同事，请让技术研发中心的技术人员先帮您创建一个OA账号。                                               \n\n 2.种植IDKey，技术人员会在OA的后台里为您的账号创建一个新的IDKey二维码。通过用手机OA扫描该二维码，IDKey会植入手机内。 \n\n 3.扫描时，请确保您的手机连上互联网，种植会很快完成。";
//        plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
    plantIDKeyExplianLable.textAlignment =  NSTextAlignmentLeft;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSize = [plantIDKeyExplianLable.text boundingRectWithSize:CGSizeMake(300, 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    plantIDKeyExplianLable.frame = CGRectMake(plantIDKeyExplianLable.frame.origin.x, plantIDKeyExplianLable.frame.origin.y, plantIDKeyExplianLable.frame.size.width, labelSize.height);
    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    
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
    
    //    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
//    [self presentViewController:scanImage animated:YES completion:nil];
    [self.navigationController  presentViewController:scanImage animated:YES completion:nil];
    
    
    
}


//- (void)reportScanResult:(NSString *)result{
//    NSLog(@"%@",result);
//    [self scanCrama:result];
//
//    NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
//
//
//}
- (void)reportScanResult:(NSString *)result{
    NSLog(@"%@",result);
    [self scanCrama:result];
    
    NSData * dictionartData =  [result  dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:dictionartData options:NSJSONReadingMutableContainers error:nil];
    [dict removeObjectForKey:@"server_type"];
    [self clientSendInformationsToServer:dict resultString:result];
    
}

-(void)clientSendInformationsToServer:(NSMutableDictionary *)clinetDictionaryDIct  resultString:(NSString *)str{
    
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/receive"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSDictionary * dataDic = clinetDictionaryDIct;
    [clinetDictionaryDIct setValue:@"IOS_APP" forKey:@"client_type"];
    
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    
    //    NSString  * string =[self convertToJsonData:clinetDictionaryDIct];
    //    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            NSLog(@"response, error :%@, %@", response, error);
                                            NSLog(@"data:%@", data);
                                            if (data != nil) {
                                                NSLog(@"success");
                                                NSDictionary * dictss =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]
                                                ;
                                                NSLog(@"%@", dictss);
                                                
//                                                [self scanCrama:str];
                                                [self gitAccess_token];
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问李鹏");
                                            }
                                            
                                        }];
    [task resume];
    
    
}


-(void)gitAccess_token{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/login"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSDictionary * dataDic = @{@"grant_type": @"client_credentials", @"client_id": @"1", @"client_secret": @"rgQx0K4ibiNVzIYhltqaRj9g8gr0w3T1fa8XKUz3", @"scope": @"1"};
    
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    
    //    NSString  * string =[self convertToJsonData:clinetDictionaryDIct];
    //    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            NSLog(@"tokenresponse, error :%@, %@", response, error);
                                            NSLog(@"tokendata:%@", data);
                                            if (data != nil) {
                                                NSLog(@"tokensuccess");
                                                NSDictionary * dictss =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]
                                                ;
                                                
                                                NSLog(@"token%@", [dictss objectForKey:@"access_token"]);
                                                
                                                NSString * newStr = [NSString new];
                                                [self scanCrama:newStr];
                                                
                                            } else{
                                                NSLog(@"token:获取数据失败，问李鹏");
                                            }
                                            
                                        }];
    [task resume];
    
}













-(void)scanCrama:(NSString *)reseutString {
    
    int result = 0;
    
    if (result == 1) {
        [self scanSuccess:@"https://"];
    } else if (result == 0) {
        
//        [self alert];
        NSString *title = reseutString;
        NSString *message = @"重新返回扫码指导界面";
        NSString *okButtonTitle = @"OK";
        // 初始化
        UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        // 创建操作
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
//            [self  plantIDKey];
             [self scanSuccess:@"https://"];
        }];
        
        // 添加操作
        [alertDialog addAction:okAction];
        // 呈现警告视图
//        [self presentViewController:alertDialog animated:YES completion:nil];
        [self.navigationController  presentViewController:alertDialog animated:YES completion:nil];
    }
    
}

-(void)alert{
    
    NSString *title = @"Alert Button Selected";
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
    
    // 呈现警告视图
//    [self presentViewController:alertDialog animated:YES completion:nil];
    
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
    //    plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionExplianLable.textAlignment =  NSTextAlignmentLeft;
    //    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSize = [mattersNeedAttentionExplianLable.text boundingRectWithSize:CGSizeMake(200, 1500) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    mattersNeedAttentionExplianLable.frame = CGRectMake(mattersNeedAttentionExplianLable.frame.origin.x, mattersNeedAttentionExplianLable.frame.origin.y, mattersNeedAttentionExplianLable.frame.size.width, labelSize.height);
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
  
    [scanSuccessView addSubview:mattersNeedAttentionExplianLable];
    
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight * 3 / 4 - 60, iphoneWidth - 40, 50)];
    nameLable.text = @"用户 ：小明";
//    nameLable.backgroundColor = [UIColor redColor];
    nameLable.textAlignment =  NSTextAlignmentCenter;
    nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [scanSuccessView addSubview:nameLable];

    
#pragma tset
    //数据持久化
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentfilePath = paths.firstObject;
    NSString *txtPath = [documentfilePath stringByAppendingPathComponent:@"bada.txt"];
    
    NSDictionary *dic5 = @{@"name": @"Duke", @"age": @33, @"gender": @"male"};
    [dic5 writeToFile:txtPath atomically:YES];
    
    NSLog(@"txtPath:%@", txtPath);
    
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:txtPath];
    NSLog(@"resultDicresultDicresultDicresultDicresultDicresultDicresultDic:%@", resultDic);
    
    
    
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
