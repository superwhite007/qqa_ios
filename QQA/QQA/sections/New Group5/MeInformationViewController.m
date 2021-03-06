//
//  MeInformationViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MeInformationViewController.h"
#import "AboutYouthViewController.h"
#import "MessageViewController.h"
#import "VersionInformationViewController.h"
#import "HumanVeinLibraryVC.h"
#import "MineTasksTVC.h"
#import "UIImage+ChangeColor.h"

@interface MeInformationViewController ()


@end

@implementation MeInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;


//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:238  / 255.0 green:0  / 255.0 blue:0 / 255.0 alpha:0.5];
    NSArray * titleArray = [NSArray arrayWithObjects:@"发起通知",  @"人脉库",  @"我的任务", @"版本更新", @"关于青青", nil];
    for (int i = 0; i < [titleArray count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35, iphoneWidth * 2 / 3 + 6 + i * 60, iphoneWidth - 35, 60);
        //    button1.backgroundColor = [UIColor darkGrayColor];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = i;
        button.titleLabel.textColor=[UIColor blackColor];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize: 17.0];
        [button addTarget:self action:@selector(gotoSomeForwed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTintColor:[UIColor blackColor]];
        [self.view addSubview:button];
    }
    NSArray * imageArray = [NSArray arrayWithObjects:@"notify", @"contact-1", @"TaskLists",@"update", @"about",  nil];
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 20, iphoneWidth * 2 / 3 +  6 + 15  + 5+ i * 60, 20, 20);
        UIImage *firstimage = [UIImage imageNamed:imageArray[i]];
        UIColor * changeColor= [UIColor colorWithRed:83/255.0 green:177/255.0 blue:232/255.0 alpha:1];
        [firstimgView setImage:[firstimage imageWithColor:changeColor]];
        firstimgView.alpha = 0.6;
        
        [self.view addSubview:firstimgView];
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, iphoneWidth * 2 / 3 + 6 + 15 + 5 + i * 60, 20, 20);
        UIImage *image = [UIImage imageNamed:@"forward"];
        [imgView setImage:image];
        imgView.alpha = 0.6;
        [self.view addSubview:imgView];
    }
    for (int i = 0; i <= imageArray.count; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, iphoneWidth  * 2 / 3 + 6 + i * 60 , iphoneWidth, .5)];
        view.alpha = .4;
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
    [self punchRecoret];
}

-(void)gotoSomeForwed:(UIButton *)sender{
    if (sender.tag == 0) {
        [self gitPersonPermissions];
    }else if (sender.tag == 1){
        HumanVeinLibraryVC * humanVC = [HumanVeinLibraryVC new];
        [self.navigationController pushViewController:humanVC animated:YES];
    }else if (sender.tag == 2){
        MineTasksTVC * mineTasksTVC = [MineTasksTVC new];
        [self.navigationController pushViewController:mineTasksTVC animated:YES];
    }else if (sender.tag == 3){
        [self versionCheck];
    }else if (sender.tag == 4){
        AboutYouthViewController * aboutYouthVC = [AboutYouthViewController new];
        [self.navigationController pushViewController:aboutYouthVC animated:YES];
    }
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"  ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)gotoTest{
    
}

-(void)gotoAboutQingqing{
    AboutYouthViewController * aboutYouthVC = [AboutYouthViewController new];
    [self.navigationController pushViewController:aboutYouthVC animated:YES];
}

-(void)gotoMessage{
    MessageViewController * messageVC = [MessageViewController new];
    [self.navigationController pushViewController:messageVC animated:YES];
}

-(void)punchRecoret{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/user/show", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self  gitSomeThingsdictionary:dict];
                                                });
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
}



-(void)gitSomeThingsdictionary:(NSDictionary *)dict{
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneWidth * 2 / 3)];
    view.backgroundColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
//    [ UIColor colorWithRed:241  / 255.0 green:142  / 255.0 blue:91 / 255.0 alpha:.8];
    [self.view addSubview: view];
    NSArray * labelNameArray = @[@"imageString", @"姓名:", @"部门：", @"职位：",  @"NO.", @"电话：", @"固话：", @"email:", @"QQ:", @"微信:"];
    NSMutableString * nameAndSex = [NSMutableString new];
    if ([[dict objectForKey:@"sex"] intValue] == 1) {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ ♂", [dict objectForKey:@"username"]];
    } else if ([[dict objectForKey:@"sex"] intValue] == 2) {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ ♀", [dict objectForKey:@"username"]];
    } else  {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ 未知", [dict objectForKey:@"username"]];
    }
   
    NSArray * urlRebackArray = @[[dict objectForKey:@"avatar"] , nameAndSex, [dict objectForKey:@"departments"], [dict objectForKey:@"jobs"],  [dict objectForKey:@"number"], [dict objectForKey:@"telephone"], [dict objectForKey:@"mobile"], [dict objectForKey:@"email"], [dict objectForKey:@"qq"], [dict objectForKey:@"weiXin"]];
    UIImageView * imgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(15, iphoneWidth  / 9 , iphoneWidth * 4 / 9 , iphoneWidth * 4 / 9)];
    imgVIew.backgroundColor = [UIColor redColor];
    imgVIew.layer.cornerRadius = imgVIew.frame.size.width/2;
    imgVIew.clipsToBounds = YES;
    //    UIImage *image = [UIImage imageNamed:labelNameArray[0]]; hongjinbao
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"avatar"]]];
    UIImage *image = [UIImage imageWithData:data];
    [imgVIew setImage:image];
    [view addSubview:imgVIew];
    for (int i = 1; i < 10; i++) {
        UILabel * label = [[UILabel alloc] init];
        if ( i > 0 && i < 10) {
            label.frame = CGRectMake(iphoneWidth * 4 / 9 + 25, iphoneWidth * 2 / 3 / 10 / 2 + ( iphoneWidth * 2 / 3 / 10  * (i - 1)) , iphoneWidth  / 2 - 20,  iphoneWidth * 2 / 3 / 10);
        }
//        label.backgroundColor = [UIColor blueColor];
        label.adjustsFontSizeToFitWidth = YES;
        [label setText:[NSString stringWithFormat:@"%@%@", labelNameArray[i], urlRebackArray[i]]];
        [view addSubview:label];
    }
}

-(void)versionCheck{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/version/check", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self compareVersion:dict];
                                                });
                                                
                                            } else{
                                                [self alert:@"已经是最新版本!"];
                                                NSLog(@"获取数据失败");
                                            }
                                        }];
    [task resume];
}
-(void)compareVersion:(NSDictionary *)dic{
    NSLog(@"Version:%@", dic);
    NSString * versionNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"newVerMajor"]];
    NSString * url = [NSString stringWithFormat:@"%@", [dic objectForKey:@"url"]];
    NSComparisonResult result = [@"2" compare:versionNumber options:NSNumericSearch];//比较的是字符串的值,如果有多个比较条件,加一个|然后加比较条件
    switch (result) {
        case NSOrderedAscending:
            [self alertSS:@"前往更新版本!" urlStr:url];
            break;
        case NSOrderedSame:
            [self alert:@"已经是最新版本!"];
            break;
        case NSOrderedDescending:
            [self alert:@"已经是最新版本!"];
            break;
        default:
            [self alert:@"已经是最新版本!"];
            break;
    }
}
    
-(void)alertSS:(NSString *)str urlStr:(NSString *)url{
    NSString *title = str;
    NSString *message = @"注  意";
    NSString *okButtonTitle = @"同意";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    }];
    [alertDialog addAction:okAction];
    
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    }];
    [alertDialog addAction:cancellAction];
    
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)gitPersonPermissions{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/user/permissions", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSLog(@"%@", error);
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"dataBackdataBack:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ( [[dataBack objectForKey:@"message"] intValue] == 8002 ) {
                                                        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dataBack];
                                                        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                        NSString * documentfilePath = paths.firstObject;
                                                        NSString *txtPath = [documentfilePath stringByAppendingPathComponent:@"Permissions.txt"];
                                                        [dict  writeToFile:txtPath atomically:YES];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self haveNoticeYesORNo];
                                                        });
                                                        
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSLog(@"获取数据失败，问gitPersonPermissions");
                                                }
                                            }else{
                                                
                                            }
                                        }];
    [task resume];
    
}
-(void)haveNoticeYesORNo{
    
    NSString *sTextPathPermissions = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Permissions.txt"];
    NSDictionary *resultPermissions = [NSDictionary dictionaryWithContentsOfFile:sTextPathPermissions];
    NSLog(@"1234567890%@", resultPermissions);
    if ([resultPermissions[@"notices"] isEqualToString:@"yes"]) {
        MessageViewController * messageVC = [MessageViewController new];
        [self.navigationController pushViewController:messageVC animated:YES];
    } else{
        [self alert:@"暂时没有发送通知权限"];
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
