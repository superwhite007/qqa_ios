//
//  HumanDetailVC.m
//  QQA
//
//  Created by wang huiming on 2018/5/31.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanDetailVC.h"
#import "NewContactViewController.h"

@interface HumanDetailVC ()

@property(nonatomic, strong) UIView * headerView;
@property(nonatomic, strong) UILabel * nameLabel;
@property(nonatomic, strong) UILabel * describeLabel;

@end

@implementation HumanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"人脉库"];
    [self addHeadView];
   
    
}
-(void)addHeadView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, 190)];
    _headerView.backgroundColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    [self.view addSubview:_headerView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((iphoneWidth - 100)/2, 10, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"new_contact"]];
    [_headerView addSubview:imageView];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, iphoneWidth, 30)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:_nameLabel];
    _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, iphoneWidth, 25)];
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:_describeLabel];
    [self getHumanInformationFromServer];
}
-(void)getHumanInformationFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/connection/show", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_connectionIdStr  forKey:@"connectionId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 40005) {
//                                                        NSLog(@"Server tapy is OK.");
//                                                        NSLog(@"dataBackdataBack:%@", dataBack);;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self addHeaderView:dataBack];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                NSLog(@"HUMan5获取数据失败，问gitPersonPermissions");
                                            }
                                        }];
    [task resume];
}

-(void)addHeaderView:(NSDictionary *)dict{
    _nameLabel.text = [dict objectForKey:@"name"];
    _describeLabel.text = [dict objectForKey:@"describe"];
    [self addInformationAboutTelephone:dict];
}
-(void)addInformationAboutTelephone:(NSDictionary *)dict{
    NSString * emailStr = [NSString stringWithFormat:@"发邮件  %@",[dict objectForKey:@"email"]];
    NSString * telephoneStr = [NSString stringWithFormat:@"打电话  %@",[dict objectForKey:@"telephone"]];
    NSString * sendMessage = [NSString stringWithFormat:@"发消息  %@",[dict objectForKey:@"telephone"]];
    NSString * weixin = [NSString stringWithFormat:@"微信  %@",[dict objectForKey:@"weiXin"]];
    NSString * QQ = [NSString stringWithFormat:@"QQ  %@",[dict objectForKey:@"qq"]];
    NSString * mobileTelephoneStr = [NSString stringWithFormat:@"打固话  %@",[dict objectForKey:@"mobile"]];
    NSMutableArray * titleArray = [NSMutableArray arrayWithObjects:telephoneStr, sendMessage, weixin, QQ , emailStr,  nil];
    if (![[dict objectForKey:@"mobile"] isEqualToString:@"暂无"]) {
        [titleArray addObject:mobileTelephoneStr];
    }
    for (int i = 0; i < [titleArray count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35, 190 + 10 + i * 50, iphoneWidth - 35, 50);
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
    NSMutableArray * imageArray = [NSMutableArray arrayWithObjects:@"tel", @"sms", @"wechat", @"qq", @"email",  nil];
    if (![[dict objectForKey:@"mobile"] isEqualToString:@"暂无"]) {
        [imageArray addObject:@"tel"];
    }
    for (int i = 0; i < titleArray.count ; i++) {
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 20, 190  + 10 + 15 + i * 50, 20, 20);
        //    imgView.backgroundColor = [UIColor yellowColor];
        UIImage *firstimage = [UIImage imageNamed:imageArray[i]];
        [firstimgView setImage:firstimage];
        firstimgView.alpha = 0.6;
        [self.view addSubview:firstimgView];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, 190  + 10 + 15 + i * 50, 20, 20);
        UIImage *image = [UIImage imageNamed:@"forward"];
        [imgView setImage:image];
        imgView.alpha = 0.6;
    }
    
    for (int i = 0; i < titleArray.count+1 ; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 190 + 8 + i * 50 , iphoneWidth, .5)];
        view.alpha = .4;
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
    NSLog(@"idEdit:%@", [dict objectForKey:@"idEdit"]);
    if ([[dict objectForKey:@"idEdit"] intValue] == 1) {
        NSLog(@"有编辑权限");
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStyleDone) target:self action:@selector(changeHumanInformations:)];
    }else if ([[dict objectForKey:@"idEdit"] intValue] == 0) {
        NSLog(@"无编辑权限");
    }
}
-(void)changeHumanInformations:(NSDictionary *)dict{
    NSLog(@"555555555%@",dict);
    NewContactViewController * newContactVC = [NewContactViewController new];
    [self.navigationItem setTitle:@"编辑"];
    [self.navigationController pushViewController:newContactVC animated:NO];

}

-(void)gotoSomeForwed:(UIButton *)sender{
    if (sender.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }else if (sender.tag == 1){
        NSString * str = [NSString stringWithFormat:@"sms://%@",[sender.titleLabel.text substringFromIndex:5]];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    }else if (sender.tag == 0 || sender.tag == 5){
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
