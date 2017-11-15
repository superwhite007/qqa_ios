//
//  MeInformationViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MeInformationViewController.h"
#import "AboutYouthViewController.h"

@interface MeInformationViewController ()

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString * departmentStr;
@property (nonatomic, strong) NSString * positionStr;
@property (nonatomic, strong) NSString * telephoneNumber;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * qq;
@property (nonatomic, strong) NSString * wechat;

@property (nonatomic, strong) UIView * view;

@end

@implementation MeInformationViewController

-(NSString *)imgUrl{
    if (!_imgUrl) {
        self.imgUrl = [NSString new];
    }
    return _imgUrl;
}
-(NSString *)nameStr{
    if (_nameStr) {
        self.nameStr = [NSString new];
    }
    return _nameStr;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor greenColor];
    
    
//    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, 64, iphoneWidth, iphoneWidth * 2 / 3)];
////    view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
//    [self.view addSubview: view];
    
    
    
//    NSArray * labelNameArray = @[ @"imageString", @"姓名", @"名称", @"部门", @"职位", @"NO.", @"昵称", @"轻轻ID:"];
//    UIImageView * imgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(20, iphoneWidth  / 9 , iphoneWidth * 4 / 9 , iphoneWidth * 4 / 9)];
//    imgVIew.backgroundColor = [UIColor redColor];
//    imgVIew.layer.cornerRadius = imgVIew.frame.size.width/2;
//
//    imgVIew.clipsToBounds = YES;
//    //    UIImage *image = [UIImage imageNamed:labelNameArray[0]]; hongjinbao
//
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://172.19.12.6/v1/api/user/getImg/ff66070a3e8abc40d24f905467123d92-afcbc2ed6ed1896b1e9f8df03abad60c.jpg"]];
//    UIImage *image = [UIImage imageWithData:data];
////    NSLog(@"w = %f,h = %f",image.size.width,image.size.height);
////
////    UIImage *image = [UIImage imageNamed:@"hongjinbao"];
//    [imgVIew setImage:image];
//    [view addSubview:imgVIew];
//
//    for (int i = 1; i < 7; i++) {
//        UILabel * label = [[UILabel alloc] init];
//        if ( i > 0 && i < 7) {
//            label.frame = CGRectMake(iphoneWidth * 5 / 9, iphoneWidth * 4 / 9  / 7 + ( iphoneWidth * 2 / 3 / 7  * (i - 1)), iphoneWidth  / 3, iphoneWidth * 4 / 9 / 7);
//
//        }
//        label.backgroundColor = [UIColor blueColor];
//        [label setText:labelNameArray[i]];
//        [view addSubview:label];
//    }
    
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, iphoneWidth * 2 / 3 + 64 + 10, iphoneWidth, 60);
    button1.backgroundColor = [UIColor darkGrayColor];
    [button1 setTitle:@"发起通知" forState:(UIControlStateNormal)];
    button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);  
    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(0, CGRectGetMaxY(button1.frame) + 5, iphoneWidth, 60);
    button2.backgroundColor = [UIColor darkGrayColor];
    button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button2.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [button2 setTitle:@"修改登录密码" forState:(UIControlStateNormal)];
    [self.view addSubview:button2];
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake(0, CGRectGetMaxY(button2.frame) + 5, iphoneWidth, 60);
    button3.backgroundColor = [UIColor darkGrayColor];
    [button3 setTitle:@"关于青春" forState:(UIControlStateNormal)];
    button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button3.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [button3 addTarget:self action:@selector(gotoAboutQingqing) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button3];
    
    
    [self punchRecoret];
    

    
}



-(void)gotoAboutQingqing{
    AboutYouthViewController * aboutYouthVC = [AboutYouthViewController new];
    [self.navigationController pushViewController:aboutYouthVC animated:YES];
}



-(void)punchRecoret{
    
    __block NSDictionary * dictBack = [NSDictionary dictionary];
    
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
    
//    [mdict setObject:@"1" forKey:@"pageNum"];
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
                                                
//                                                [self  gitSomeThingsdictionary:dict];
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
