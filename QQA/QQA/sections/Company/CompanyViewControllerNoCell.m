//
//  CompanyViewControllerNoCell.m
//  QQA
//
//  Created by wang huiming on 2018/5/8.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "CompanyViewControllerNoCell.h"
#import "CycleScrollView.h"
#import "CompanyNoticeViewController.h"
#import "CompanyBylawsViewController.h"
#import "RulesDetailViewController.h"
#import "CompanyOrganizationalStructureViewController.h"


#import "SDCycleScrollView.h"

@interface CompanyViewControllerNoCell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) NSMutableArray * datasourceRedpoint;
@property (nonatomic, strong) NSMutableArray * cyclePicturesDatasource;
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@property (nonatomic, strong) UILabel * nameShorthandLabel;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation CompanyViewControllerNoCell

-(NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return  _datasource;
}
-(NSMutableArray *)datasourceRedpoint{
    if (!_datasourceRedpoint) {
        self.datasourceRedpoint = [NSMutableArray array];
    }
    return _datasourceRedpoint;
}
-(NSMutableArray *)cyclePicturesDatasource{
    if (!_cyclePicturesDatasource) {
        self.cyclePicturesDatasource = [NSMutableArray array];
    }
    return _cyclePicturesDatasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCycleScrollPitures];
    [self getStartTimerAboutRedPoint];
    // Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"青青";
    [self.datasourceRedpoint addObject:@"0"];
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:245  / 255.0 green:93  / 255.0 blue:84 / 255.0 alpha:1];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.datasource addObject:@"公司通知"];
    [self.datasource addObject:@"规章制度"];
    [self.datasource addObject:@"公司信息"];
    [self.datasource addObject:@"组织架构与通讯录"];
    [self.datasource addObject:@"公司云盘"];
    [self addPagesButtonCell];
    
    
}

-(void)addPagesButtonCell{
    NSArray * titleArray = [NSArray arrayWithObjects:@"公司通知", @"规章制度", @"公司信息",  @"组织架构与通讯录", @"公司云盘", nil];
    for (int i = 0; i < [titleArray count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(35, iphoneWidth * 2 / 3 + 10 + i * 60, iphoneWidth - 35, 60);
        //    button1.backgroundColor = [UIColor darkGrayColor];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = 1000 + i;
        button.titleLabel.textColor=[UIColor blackColor];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize: 17.0];
        [button addTarget:self action:@selector(gotoSomeForwed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTintColor:[UIColor blackColor]];
        [self.view addSubview:button];
    }
    NSArray * imageArray = [NSArray arrayWithObjects:@"notify", @"update", @"about", @"update", @"about", nil];
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *firstimgView = [[UIImageView alloc] init];
        firstimgView.frame = CGRectMake( 20, iphoneWidth * 2 / 3 +  10 + 15  + 5+ i * 60, 20, 20);
        //    imgView.backgroundColor = [UIColor yellowColor];
        UIImage *firstimage = [UIImage imageNamed:imageArray[i]];
        [firstimgView setImage:firstimage];
        firstimgView.alpha = 0.6;
        [self.view addSubview:firstimgView];
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(iphoneWidth - 55, iphoneWidth * 2 / 3 + 10 + 15 + 5 + i * 60, 20, 20);
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
    
    
    
}
-(void)gotoSomeForwed:(UIButton *)sender{
    if (sender.tag == 1000) {
        CompanyNoticeViewController * companyNoticeVC = [CompanyNoticeViewController new];
        [self.navigationController pushViewController:companyNoticeVC animated:YES];
    }else if (sender.tag == 1001){
        CompanyBylawsViewController * companyBylawsVC = [CompanyBylawsViewController new];
        companyBylawsVC.transmitTitleLabel = @"规章制度";
        [self.navigationController pushViewController:companyBylawsVC animated:YES];
        
        
    }else if (sender.tag == 1002){
        RulesDetailViewController * detailVC = [[RulesDetailViewController alloc] init];
        detailVC.urlStr = [NSString stringWithFormat:@"%@/v1/api/company/index", CONST_SERVER_ADDRESS];
        if (detailVC.urlStr.length >0 ) {
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        
    }else if (sender.tag == 1003){
        CompanyOrganizationalStructureViewController * organizationalStructurehVC = [CompanyOrganizationalStructureViewController new];
        [self.navigationController pushViewController:organizationalStructurehVC animated:YES];
        
    }else if (sender.tag == 1004){
        [self alert:@"开发中、、、"];
        
    }
}
-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"请注意!";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
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
    NSArray *titles = @[@" ",
                        @" ",
                        @" ",
                        @" "
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
//    for (int i = 0; i < 3; ++i) {
//        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"everyday_1"]];
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//        imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
//        [viewsArray addObject:imgView];
//    }
//    if (_cyclePicturesDatasource.count > 0) {
//        for (int i = 0; i < 3; ++i) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSURL * url = [NSURL URLWithString:_cyclePicturesDatasource[i]];
//                NSData * data = [NSData dataWithContentsOfURL:url];
//                UIImage *img = [UIImage imageWithData:data];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//                        imgView.frame = CGRectMake(0, 0, iphoneWidth , iphoneWidth * 2 / 3);
//                        viewsArray[i] = imgView;
//                    });
//            });
//        }
//    }
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

-(void)getStartTimerAboutRedPoint{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getRedpointOfNoticeFromServer) userInfo:nil repeats:YES];
}
-(void)getRedpointOfNoticeFromServer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/message/unread", CONST_SERVER_ADDRESS]];
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
                                                    //                                                    NSLog(@"Noticeredpoint字典%@", object);
                                                    if ([[object objectForKey:@"message"] intValue] != 20001 ) {
                                                        NSLog(@"Notice服务获得到数据，但是数据异常");
                                                    }else {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            NSString * str = [NSString stringWithFormat:@"%@", [object objectForKey:@"messagesUnreadTotalNum"]];
                                                            [self.datasourceRedpoint removeAllObjects];
                                                            [self.datasourceRedpoint addObject:str];
                                                            [self addRedPoint];
                                                        });
                                                    }
                                                }
                                            }
                                        }];
    [task resume];
}
-(void)addRedPoint{
    
    _nameShorthandLabel = [[UILabel alloc] initWithFrame:CGRectMake(iphoneWidth - 100, iphoneWidth * 2 / 3 + 20, 20, 20)];
    _nameShorthandLabel.layer.cornerRadius = _nameShorthandLabel.bounds.size.width/2;
    _nameShorthandLabel.layer.masksToBounds = YES;
    _nameShorthandLabel.textAlignment = NSTextAlignmentCenter;
    _nameShorthandLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_nameShorthandLabel];
    if ([self.datasourceRedpoint[0] intValue] > 0 ) {
        _nameShorthandLabel.text = [NSString stringWithFormat:@"%@", self.datasourceRedpoint[0]];
        _nameShorthandLabel.backgroundColor = [UIColor redColor];
    } else if ([self.datasourceRedpoint[0] intValue] == 0 ) {
        _nameShorthandLabel.text = [NSString stringWithFormat:@" "];
        _nameShorthandLabel.backgroundColor = [UIColor whiteColor];
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
