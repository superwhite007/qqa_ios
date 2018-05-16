//
//  RequestLeaveDetailViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/30.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RequestLeaveDetailViewController.h"

@interface RequestLeaveDetailViewController ()

@property (nonatomic, strong) NSMutableArray * cCMarray;
@property (nonatomic, strong) NSMutableArray * approvalMarray;
@property (nonatomic, strong) NSMutableArray * datasourceMArray;

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * created_atTimeLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * statusReasonLabel;
@property (nonatomic, strong) UILabel * startTimeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * longTimeLabel;
@property (nonatomic, strong) UILabel * reasonLabel;
@property (nonatomic, strong) UILabel * resultStatus;



@end

@implementation RequestLeaveDetailViewController


-(NSMutableArray *)cCMarray{
    if (!_cCMarray) {
        self.cCMarray = [NSMutableArray array];
    }
    return _cCMarray;
}
-(NSMutableArray *)approvalMarray{
    if (!_approvalMarray) {
        self.approvalMarray = [NSMutableArray array];
    }
    return _approvalMarray;
}

-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        self.datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
    [self setViewAboutNameTimeReason];
}

-(void)viewWillAppear:(BOOL)animated{
//    [self loadNewData];
    //获取数据
}

-(void)setViewAboutNameTimeReason{
   
}


-(NSString *)tepyOfLeave:(NSString *)str{
    if ([str isEqualToString:@"100"]) {
        return  @"调休";
    } else if ([str isEqualToString:@"101"]){
        return  @"年假";
    } else if ([str isEqualToString:@"102"]){
        return @"婚假";
    } else if ([str isEqualToString:@"103"]){
        return  @"产假";
    } else if ([str isEqualToString:@"104"]){
        return  @"病假";
    } else if ([str isEqualToString:@"105"]){
        return @"事假";
    } else if ([str isEqualToString:@"106"]){
        return @"丧假";
    } else if ([str isEqualToString:@"107"]){
        return  @"工伤假";
    } else if ([str isEqualToString:@"108"]){
        return @"外出";
    }  else if ([str isEqualToString:@"109"]){
        return @"其他";
    }
    return @"其他";
//    _statusLabel.text =[NSString stringWithFormat:@"类型:%@", [self tepyOfLeave:[NSString stringWithFormat:@"%@", [dict objectForKey:@"type"]]]];

}

-(void)setvaleKeyAndValue:(NSDictionary *)dict{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, iphoneWidth - 40, 25)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLabel];
    _created_atTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, iphoneWidth - 40, 25)];
    _created_atTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_created_atTimeLabel];
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  70, (iphoneWidth  - 50) / 2 , 25)];
    _statusReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  70, (iphoneWidth  - 50) / 2 , 25)];
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, iphoneWidth / 2 - 25, 25)];
    _startTimeLabel.adjustsFontSizeToFitWidth = YES;
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  100, (iphoneWidth  - 50) / 2, 25)];
    _endTimeLabel.adjustsFontSizeToFitWidth = YES;
    _longTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, iphoneWidth - 40, 25)];
    if ([_titleStr isEqualToString:@"请假"]) {
        [self.view addSubview:_startTimeLabel];
        [self.view addSubview:_statusLabel];
        [self.view addSubview:_statusReasonLabel];
        [self.view addSubview:_endTimeLabel];
        [self.view addSubview:_longTimeLabel];
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 170 , iphoneWidth - 40, iphoneHeight / 7 + 15)];
    } else{
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 70 , iphoneWidth - 40, iphoneHeight / 7 + 115)];
    }
    _resultStatus = [[UILabel alloc] initWithFrame: CGRectMake(iphoneWidth - 140, 196 + iphoneHeight / 7 , 100, 30)];
    _resultStatus.layer.borderWidth = 1;
    _resultStatus.layer.cornerRadius = 5;
    _resultStatus.layer.borderColor = [UIColor blackColor].CGColor;
    _resultStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_resultStatus];
    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    _reasonLabel.layer.borderWidth = 1;
    _reasonLabel.layer.cornerRadius = 10;
    _reasonLabel.layer.masksToBounds = YES;
    [self.view addSubview:_reasonLabel];
    _nameLabel.text = [dict objectForKey:@"username"];
    _created_atTimeLabel.text = [dict objectForKey:@"createdAt"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起始:%@", [dict objectForKey:@"starttime"]];
    if ([_titleStr isEqualToString:@"请假"]) {
        _reasonLabel.text = [dict objectForKey:@"reason"];
    } else{
        _reasonLabel.text = [dict objectForKey:@"content"];
    }
    _statusLabel.text =[NSString stringWithFormat:@"类型:%@", [self tepyOfLeave:[NSString stringWithFormat:@"%@", [dict objectForKey:@"type"]]]];
    _endTimeLabel.text = [NSString stringWithFormat:@"结束:%@", [dict objectForKey:@"endtime"]];
    _longTimeLabel.text =[NSString stringWithFormat:@"请假天数:%@",  [dict objectForKey:@"betweentime"]];
    if ([[dict objectForKey:@"status"] isEqualToString:@"Unapproved"]) {
        _resultStatus.text = [NSString stringWithFormat:@"审批中"];
    } else  if ([[dict objectForKey:@"status"] isEqualToString:@"Agreed"]) {
        _resultStatus.text = [NSString stringWithFormat:@"已同意"];
    }else  if ([[dict objectForKey:@"status"] isEqualToString:@"Denyed"]) {
        _resultStatus.text = [NSString stringWithFormat:@"已拒绝"];
    }
    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
}


-(void)loadNewData
{
    //记录是下拉刷新
    [self loadDataAndShowWithPageNum];
    //    [self.foodListView.tableView.header endRefreshing];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum
{
    if ([_titleStr isEqualToString:@"请假"]) {
        _urlStr = @"/v1/api/leave/show";
    } else if ([_titleStr isEqualToString:@"请示件"]) {
        _urlStr = @"/v1/api/ask/show"; //
    }
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, _urlStr]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0;
    request.HTTPMethod = @"POST";
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    if ([_titleStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveOrAskId forKey:@"leaveId"];
    } else if ([_titleStr isEqualToString:@"请示件"]) {
        [mdict setObject:_leaveOrAskId forKey:@"askId"]; //
    }
    NSLog( @"66666666%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6008 ||  [[dictArray[0] objectForKey:@"message"] intValue] == 6019 ) {
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        NSDictionary * dict1 = array1[0];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self setvaleKeyAndValue:dict1];
                                                        });
                                                        [array1 removeObjectAtIndex:0];
                                                        self.datasourceMArray = array1;
                                                        NSLog(@"array1array1array1array1:%@", array1);
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self ApproverAndCC];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6006 ){
                                                    }
                                                }
                                            } else{
//                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
}

-(void)ApproverAndCC{
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        [self ApproverAndCCAfteriPhone6];
    }else{
        [self ApproverAndCCSEAnd5S];
    }
}

-(void)ApproverAndCCSEAnd5S{
    for (int i = 0; i < [_datasourceMArray count]; i++) {
        NSString * str = [_datasourceMArray[i] objectForKey:@"type"] ;
        if ([str isEqualToString:@"approver"]) {
            NSDictionary * dict = _datasourceMArray[i];
            [self.approvalMarray addObject:dict];
        } else if ([str isEqualToString:@"reader"]){
            [self.cCMarray addObject:_datasourceMArray[i]];
        }
    }
    if ([self.approvalMarray count] == 0 || self.cCMarray.count == 0) {
        return;
    }
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth + 35 + (iphoneWidth * 1 / 5  + 10 )  * i ,  60, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 25  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5)];
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
            titleLabe.text = [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            if (i == 0) {
                NSString * str = [NSString stringWithFormat:@"%@", [mArrayOFApproverAndCC[i][j] objectForKey:@"type"]];
                if ([str isEqualToString:@"Agreed"]) {
                    titleLabe.backgroundColor = [UIColor greenColor];
                } else if ([str isEqualToString:@"Denyed"]) {
                    //                    titleLabe.backgroundColor = [UIColor redColor];
                }
            }
            if ( i == 1 ) {
                [self.view addSubview:titleLabe];
            }else if( i == 0 ){
                UIButton * titleLabe = [UIButton buttonWithType:UIButtonTypeSystem];
                titleLabe.frame = CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 30  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5);
                titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
                NSString * str = [NSString stringWithFormat:@"%@", [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1]];
                [titleLabe setTitle:str forState:(UIControlStateNormal)];
                [titleLabe setTintColor:[UIColor blackColor]];
                titleLabe.layer.masksToBounds = YES;
                titleLabe.titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabe.titleLabel.font = [UIFont systemFontOfSize:30];
                [self.view addSubview:titleLabe];
                [titleLabe addTarget:self action:@selector(displayComment:) forControlEvents:UIControlEventTouchUpInside];
                titleLabe.tag = 100 + j;
                
                UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5) + (iphoneWidth - 110 ) / 5 -15, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 30 , 15, 15)];
                pointLabel.backgroundColor = [UIColor redColor];
                pointLabel.layer.cornerRadius = 7.5;
                //    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
                //    _nameShorthandLabel.layer.borderWidth = 1;
                pointLabel.layer.masksToBounds = YES;
                [self.view addSubview:pointLabel];
                
            }
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 25  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
            nameLabel.text = [mArrayOFApproverAndCC[i][j] objectForKey:@"name"];
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            //            nameLabel.backgroundColor = [UIColor redColor];
            [self.view addSubview:nameLabel];
            
        }
    }
}


-(void)ApproverAndCCAfteriPhone6{
    for (int i = 0; i < [_datasourceMArray count]; i++) {
        NSString * str = [_datasourceMArray[i] objectForKey:@"type"] ;
        if ([str isEqualToString:@"approver"]) {
            NSDictionary * dict = _datasourceMArray[i];
            [self.approvalMarray addObject:dict];
        } else if ([str isEqualToString:@"reader"]){
            [self.cCMarray addObject:_datasourceMArray[i]];
        }
    }
    if ([self.approvalMarray count] == 0 || self.cCMarray.count == 0) {
        return;
    }
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth + 55 + (iphoneWidth * 1 / 5  + 20 )  * i ,  60, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
//                        reasonTitleLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5)];
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
            titleLabe.text = [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            if (i == 0) {
                NSString * str = [NSString stringWithFormat:@"%@", [mArrayOFApproverAndCC[i][j] objectForKey:@"type"]];
                if ([str isEqualToString:@"Agreed"]) {
                    titleLabe.backgroundColor = [UIColor greenColor];
                } else if ([str isEqualToString:@"Denyed"]) {
//                    titleLabe.backgroundColor = [UIColor redColor];  
                }
            }
            if ( i == 1 ) {
                [self.view addSubview:titleLabe];
            }else if( i == 0 ){
                UIButton * titleLabe = [UIButton buttonWithType:UIButtonTypeSystem];
                titleLabe.frame = CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5);
                titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
                NSString * str = [NSString stringWithFormat:@"%@", [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1]];
                [titleLabe setTitle:str forState:(UIControlStateNormal)];
                [titleLabe setTintColor:[UIColor blackColor]];
                titleLabe.layer.masksToBounds = YES;
                titleLabe.titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabe.titleLabel.font = [UIFont systemFontOfSize:30];
                [self.view addSubview:titleLabe];
                [titleLabe addTarget:self action:@selector(displayComment:) forControlEvents:UIControlEventTouchUpInside];
                titleLabe.tag = 100 + j;
                
                UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 8) + (iphoneWidth - 110 ) / 5 -15, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80 , 15, 15)];
                pointLabel.backgroundColor = [UIColor redColor];
                pointLabel.layer.cornerRadius = 7.5;
                //    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
                //    _nameShorthandLabel.layer.borderWidth = 1;
                pointLabel.layer.masksToBounds = YES;
                [self.view addSubview:pointLabel];
                
            }
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
            nameLabel.text = [mArrayOFApproverAndCC[i][j] objectForKey:@"name"];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            //            nameLabel.backgroundColor = [UIColor redColor];
            [self.view addSubview:nameLabel];
            
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)displayComment:(UIButton *)sender{
    [self alert:[self.approvalMarray[(long)sender.tag - 100] objectForKey:@"comment"]];
}
-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
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
