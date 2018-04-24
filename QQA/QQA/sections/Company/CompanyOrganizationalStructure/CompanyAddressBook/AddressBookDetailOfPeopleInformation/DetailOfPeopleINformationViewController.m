//
//  DetailOfPeopleINformationViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/6.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "DetailOfPeopleINformationViewController.h"

@interface DetailOfPeopleINformationViewController ()

@end

@implementation DetailOfPeopleINformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self punchRecoret];
}

-(void)gotoSomeForwed:(UIButton *)sender{
    if (sender.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }else if (sender.tag == 1){
        NSString * str = [NSString stringWithFormat:@"sms://%@",[sender.titleLabel.text substringFromIndex:5]];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    }else if (sender.tag == 0){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[sender.titleLabel.text substringFromIndex:5]];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }else if (sender.tag == 3){
        [self openQQ];
    }else if (sender.tag == 4){
        NSString * str = [NSString stringWithFormat:@"mailto://%@",[sender.titleLabel.text substringFromIndex:5]];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)openQQ
{
    NSURL *url = [NSURL URLWithString:@"mqq://"];
        [[UIApplication sharedApplication] openURL:url];
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"敬请期待";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
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
    [mdict setObject:_userId forKey:@"userId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 7006 ) {
//                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                       
                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            [self  gitSomeThingsdictionary:dict];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 4001 ){
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                             [self  gitSomeThingsdictionary:dict];
                                                        });
                                                    }
                                                }
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}


-(void)gitSomeThingsdictionary:(NSDictionary *)dict{
    
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneWidth * 2 / 3)];
    [self.view addSubview: view];
    NSArray * labelNameArray = @[@"imageString", @"姓名:", @"部门：", @"职位：",  @"NO.", @"电话：", @"email:", @"QQ:", @"微信:"];
    
    NSMutableString * nameAndSex = [NSMutableString new];
    if ([[dict objectForKey:@"sex"] intValue] == 1) {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ ♂", [dict objectForKey:@"username"]];
    } else if ([[dict objectForKey:@"sex"] intValue] == 2) {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ ♀", [dict objectForKey:@"username"]];
    } else  {
        nameAndSex = [NSMutableString stringWithFormat:@"%@ 未知", [dict objectForKey:@"username"]];
    }
    
    NSArray * urlRebackArray = @[[dict objectForKey:@"avatar"] , nameAndSex, [dict objectForKey:@"departments"], [dict objectForKey:@"jobs"],  [dict objectForKey:@"number"], [dict objectForKey:@"telephone"], [dict objectForKey:@"email"], [dict objectForKey:@"qq"], [dict objectForKey:@"weiXin"]];
    UIImageView * imgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(15, iphoneWidth  / 9 , iphoneWidth * 4 / 9 , iphoneWidth * 4 / 9)];
    imgVIew.backgroundColor = [UIColor redColor];
    imgVIew.layer.cornerRadius = imgVIew.frame.size.width/2;
    imgVIew.clipsToBounds = YES;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"avatar"]]];
    UIImage *image = [UIImage imageWithData:data];
    [imgVIew setImage:image];
    [view addSubview:imgVIew];
    for (int i = 1; i < 9; i++) {
        UILabel * label = [[UILabel alloc] init];
        if ( i > 0 && i < 10) {
            label.frame = CGRectMake(iphoneWidth * 4 / 9 + 25, iphoneWidth * 2 / 3 / 10 / 2 + ( iphoneWidth * 2 / 3 / 10  * (i - 1)) + 10, iphoneWidth  / 2 - 20,  iphoneWidth * 2 / 3 / 10);
        }
        label.adjustsFontSizeToFitWidth = YES;
        [label setText:[NSString stringWithFormat:@"%@%@", labelNameArray[i], urlRebackArray[i]]];
        [view addSubview:label];
    }
    
    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
    NSString * emailStr = [NSString stringWithFormat:@"发邮件  %@",[dict objectForKey:@"email"]];
    NSString * telephoneStr = [NSString stringWithFormat:@"打电话  %@",[dict objectForKey:@"telephone"]];
    NSString * sendMessage = [NSString stringWithFormat:@"发消息  %@",[dict objectForKey:@"telephone"]];
    NSString * weixin = [NSString stringWithFormat:@"微信  %@",[dict objectForKey:@"weiXin"]];
    NSString * QQ = [NSString stringWithFormat:@"QQ  %@",[dict objectForKey:@"qq"]];
    NSArray * titleArray = [NSArray arrayWithObjects:telephoneStr, sendMessage, weixin, QQ , emailStr,  nil];
    for (int i = 0; i < [titleArray count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35, iphoneWidth * 2 / 3 + 10 + i * 60, iphoneWidth - 35, 60);
//        button.backgroundColor = [UIColor darkGrayColor];
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
    
    NSArray * imageArray = [NSArray arrayWithObjects:@"tel", @"sms", @"wechat", @"qq", @"email",  nil];
    for (int i = 0; i < 5; i++) {
        
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 20, iphoneWidth * 2 / 3  + 10 + 15  + 5+ i * 60, 20, 20);
        //    imgView.backgroundColor = [UIColor yellowColor];
        UIImage *firstimage = [UIImage imageNamed:imageArray[i]];
        [firstimgView setImage:firstimage];
        firstimgView.alpha = 0.6;
        [self.view addSubview:firstimgView];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, iphoneWidth * 2 / 3  + 10 + 15 + 5 + i * 60, 20, 20);
        UIImage *image = [UIImage imageNamed:@"forward"];
        [imgView setImage:image];
        imgView.alpha = 0.6;
    }
    
    for (int i = 0; i < 6; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, iphoneWidth  * 2 / 3 + 8 + i * 60 , iphoneWidth, .5)];
        view.alpha = .4;
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
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
