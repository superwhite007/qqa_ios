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
    
    
    if (sender.tag == 0) {
        
//        MessageViewController * messageVC = [MessageViewController new];
//        [self.navigationController pushViewController:messageVC animated:YES];
//
    }else if (sender.tag == 1){
//        [self  alert:@"敬请期待中、、、"];
        
    }else if (sender.tag == 2){
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[sender.titleLabel.text substringFromIndex:5]];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }
    
    
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
    [mdict setObject:_userId forKey:@"user_id"];
    
    NSLog(@"mdict%@", mdict);
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
                                                    NSLog(@"1234567dictArray: %@,\n ", dictArray);
                                                    
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
                                                    NSLog(@"7777777dict: %@,\n ", dict);
                                                    
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
    
    NSLog(@"me:dict: %@", dict);
    
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneWidth * 2 / 3)];
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [self.view addSubview: view];
    
    NSArray * labelNameArray = @[@"imageString", @"姓名:", @"部门：", @"职位：",  @"NO.", @"电话：", @"email:", @"QQ:", @"WeChat:"];
    NSArray * urlRebackArray = @[[dict objectForKey:@"avatar"] , [dict objectForKey:@"username"], [dict objectForKey:@"departments"], [dict objectForKey:@"jobs"],  [dict objectForKey:@"number"], [dict objectForKey:@"telephone"], [dict objectForKey:@"email"], [dict objectForKey:@"qq"], [dict objectForKey:@"weiXin"]];
    
    
    UIImageView * imgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(15, iphoneWidth  / 9 , iphoneWidth * 4 / 9 , iphoneWidth * 4 / 9)];
    imgVIew.backgroundColor = [UIColor redColor];
    imgVIew.layer.cornerRadius = imgVIew.frame.size.width/2;
    
    imgVIew.clipsToBounds = YES;
    //    UIImage *image = [UIImage imageNamed:labelNameArray[0]]; hongjinbao
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"avatar"]]];
    UIImage *image = [UIImage imageWithData:data];
    [imgVIew setImage:image];
    [view addSubview:imgVIew];
    
    
    for (int i = 1; i < 9; i++) {
        UILabel * label = [[UILabel alloc] init];
        if ( i > 0 && i < 10) {
            label.frame = CGRectMake(iphoneWidth * 4 / 9 + 25, iphoneWidth * 2 / 3 / 10 / 2 + ( iphoneWidth * 2 / 3 / 10  * (i - 1)) + 10, iphoneWidth  / 2 - 20,  iphoneWidth * 2 / 3 / 10);
            
        }
        //        label.backgroundColor = [UIColor blueColor];
        label.adjustsFontSizeToFitWidth = YES;
        [label setText:[NSString stringWithFormat:@"%@%@", labelNameArray[i], urlRebackArray[i]]];
        [view addSubview:label];
    }
    
    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
    
    NSString * emailStr = [NSString stringWithFormat:@"发邮件  %@",[dict objectForKey:@"email"]];
    NSString * telephoneStr = [NSString stringWithFormat:@"打电话  %@",[dict objectForKey:@"telephone"]];
    NSArray * titleArray = [NSArray arrayWithObjects:@"发消息", emailStr, telephoneStr,  nil];
    for (int i = 0; i < [titleArray count]; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35, iphoneWidth * 2 / 3 + 74 + i * 60, iphoneWidth - 35, 60);
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
    
    NSArray * imageArray = [NSArray arrayWithObjects:@"notify", @"key", @"about",  nil];
    for (int i = 0; i < 3; i++) {
        
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 20, iphoneWidth * 2 / 3 + 64 + 10 + 15  + 5+ i * 60, 20, 20);
        //    imgView.backgroundColor = [UIColor yellowColor];
        UIImage *firstimage = [UIImage imageNamed:imageArray[i]];
        [firstimgView setImage:firstimage];
        firstimgView.alpha = 0.6;
        [self.view addSubview:firstimgView];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, iphoneWidth * 2 / 3 + 64 + 10 + 15 + 5 + i * 60, 20, 20);
        UIImage *image = [UIImage imageNamed:@"forward"];
        [imgView setImage:image];
        imgView.alpha = 0.6;
//        [self.view addSubview:imgView];
        
    }
    
    for (int i = 0; i < 4; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, iphoneWidth  * 2 / 3 + 72 + i * 60 , iphoneWidth, .5)];
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
