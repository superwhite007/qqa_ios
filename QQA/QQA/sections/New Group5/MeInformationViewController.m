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


@interface MeInformationViewController ()


@end

@implementation MeInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    NSArray * titleArray = [NSArray arrayWithObjects:@"发起通知", @"修改登录密码", @"关于青春",  nil];
    for (int i = 0; i < [titleArray count]; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(60, iphoneWidth * 2 / 3 + 74 + i * 60, iphoneWidth - 120, 60);
        //    button1.backgroundColor = [UIColor darkGrayColor];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        
        button.titleLabel.textColor=[UIColor blackColor];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [button addTarget:self action:@selector(gotoSomeForwed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTintColor:[UIColor blackColor]];
        [self.view addSubview:button];
        
        
    }
    
    for (int i = 0; i < 3; i++) {
      
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 15, iphoneWidth * 2 / 3 + 64 + 10 + 15 + i * 60, 30, 30);
        //    imgView.backgroundColor = [UIColor yellowColor];
        UIImage *firstimage = [UIImage imageNamed:@"forward"];
        [firstimgView setImage:firstimage];
        [self.view addSubview:firstimgView];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, iphoneWidth * 2 / 3 + 64 + 10 + 15 + i * 60, 30, 30);
        UIImage *image = [UIImage imageNamed:@"forward"];
        [imgView setImage:image];
        [self.view addSubview:imgView];
    
    }
    
    for (int i = 0; i < 4; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, iphoneWidth  * 2 / 3 + 72 + i * 60 , iphoneWidth, .5)];
        view.alpha = .4;
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
    
    
    [self punchRecoret];
   
}

-(void)gotoSomeForwed:(UIButton *)sender{
    
    
    if (sender.tag == 0) {
        MessageViewController * messageVC = [MessageViewController new];
        [self.navigationController pushViewController:messageVC animated:YES];
        
    }else if (sender.tag == 1){
        
        
    }else if (sender.tag == 2){
        AboutYouthViewController * aboutYouthVC = [AboutYouthViewController new];
        [self.navigationController pushViewController:aboutYouthVC animated:YES];
        
    }
    
    
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
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/user/show"]];
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
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    
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
                                                
                                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                               NSLog(@"dict: %@", dict);
                                                
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self  gitSomeThingsdictionary:dict];
                                                    
                                                });
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];

}


-(void)gitSomeThingsdictionary:(NSDictionary *)dict{
    
    NSLog(@"dict: %@", dict);
    
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneWidth * 2 / 3)];
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [self.view addSubview: view];
    
    NSArray * labelNameArray = @[@"imageString", @"姓名:", @"部门：", @"职位：", @"性别：", @"NO.", @"电话：", @"email:", @"QQ:", @"WeChat:"];
    NSArray * urlRebackArray = @[[dict objectForKey:@"avatar"] , [dict objectForKey:@"username"], [dict objectForKey:@"departments"], [dict objectForKey:@"jobs"], [dict objectForKey:@"number"], [dict objectForKey:@"number"], [dict objectForKey:@"telephone"], [dict objectForKey:@"email"], [dict objectForKey:@"number"], [dict objectForKey:@"number"]];
    
    
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
            label.frame = CGRectMake(iphoneWidth * 4 / 9 + 25, iphoneWidth * 2 / 3 / 10 / 2 + ( iphoneWidth * 2 / 3 / 10  * (i - 1)), iphoneWidth  / 2 -20,  iphoneWidth * 2 / 3 / 10);
            
        }
//        label.backgroundColor = [UIColor blueColor];
        label.adjustsFontSizeToFitWidth = YES;
        [label setText:[NSString stringWithFormat:@"%@%@", labelNameArray[i], urlRebackArray[i]]];
        [view addSubview:label];
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
