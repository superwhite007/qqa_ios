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
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self loadNewData];
    [self setViewAboutNameTimeReason];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [self loadNewData];
    //获取数据
}

-(void)setViewAboutNameTimeReason{
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 25)];
    _nameLabel.backgroundColor = [UIColor redColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLabel];
    
    _created_atTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, iphoneWidth - 40, 25)];
    _created_atTimeLabel.backgroundColor = [UIColor redColor];
    _created_atTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_created_atTimeLabel];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  134, (iphoneWidth  - 50) / 2 , 25)];
    _statusLabel.backgroundColor = [UIColor redColor];
    
    
    _statusReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  134, (iphoneWidth  - 50) / 2 , 25)];
    _statusReasonLabel.backgroundColor = [UIColor redColor];
    
    
    
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 164, iphoneWidth / 2 - 25, 25)];
    _startTimeLabel.backgroundColor = [UIColor redColor];
    _startTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  164, (iphoneWidth  - 50) / 2, 25)];
    _endTimeLabel.backgroundColor = [UIColor redColor];
    _endTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    _longTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 194, iphoneWidth - 40, 25)];
    _longTimeLabel.backgroundColor = [UIColor redColor];
    
    
    if ([_titleStr isEqualToString:@"请假"]) {
        [self.view addSubview:_startTimeLabel];
        [self.view addSubview:_statusLabel];
        [self.view addSubview:_statusReasonLabel];
        [self.view addSubview:_endTimeLabel];
        [self.view addSubview:_longTimeLabel];
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 234 , iphoneWidth - 40, iphoneHeight / 7 + 15)];
    } else{
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 134 , iphoneWidth - 40, iphoneHeight / 7 + 115)];
    }
    
    
    _resultStatus = [[UILabel alloc] initWithFrame: CGRectMake(iphoneWidth - 140, 260 + iphoneHeight / 7 , 100, 30)];
    _resultStatus.backgroundColor = [UIColor redColor];
    _resultStatus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_resultStatus];
    
    
    
    
    
    _reasonLabel.backgroundColor = [UIColor redColor];
    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _reasonLabel.layer.borderWidth = 1;
    _reasonLabel.layer.cornerRadius = 10;
    _reasonLabel.layer.masksToBounds = YES;
    [self.view addSubview:_reasonLabel];
    
}

-(void)setvaleKeyAndValue:(NSMutableArray *)mArray{
    
    NSLog(@"RequestLeaveDetailViewController：mArray:%@", mArray[0]);
    
    _nameLabel.text = [mArray[0] objectForKey:@"username"];
    
    //    [self.navigationItem setTitle:[mArray[0] objectForKey:@"username"]];
    _created_atTimeLabel.text = [mArray[0] objectForKey:@"createdAt"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起始:%@", [mArray[0] objectForKey:@"starttime"]];
    
    if ([_titleStr isEqualToString:@"请假"]) {
        _reasonLabel.text = [mArray[0] objectForKey:@"reason"];
    } else{
        _reasonLabel.text = [mArray[0] objectForKey:@"content"];
    }

    _statusLabel.text =[NSString stringWithFormat:@"类型:%@", [mArray[0] objectForKey:@"type"]];
    _endTimeLabel.text = [NSString stringWithFormat:@"结束:%@", [mArray[0] objectForKey:@"endtime"]];
    _longTimeLabel.text =[NSString stringWithFormat:@"请假天数:%@",  [mArray[0] objectForKey:@"betweentime"]];
    _resultStatus.text = [NSString stringWithFormat:@"%@",  [mArray[0] objectForKey:@"status"]];
    
    //    [self ApproverAndCC];
    [self.navigationItem setTitle:[mArray[0] objectForKey:@"username"]];
    
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
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    if ([_titleStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveOrAskId forKey:@"leaveId"];
    } else if ([_titleStr isEqualToString:@"请示件"]) {
        [mdict setObject:_leaveOrAskId forKey:@"askId"]; //
    }
    
    NSLog(@"55555555%@%@", CONST_SERVER_ADDRESS, _urlStr);
    NSLog( @"66666666%@", mdict);
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
//                                                    NSLog(@"requestleave: %@,\n ", dictArray);
                                                    
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6008 ||  [[dictArray[0] objectForKey:@"message"] intValue] == 6019 ) {

                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self setvaleKeyAndValue:array1];
                                                        });
                                                        [array1 removeObjectAtIndex:0];
                                                        [self.datasourceMArray removeAllObjects];
                                                        self.datasourceMArray = array1;
//
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self ApproverAndCC];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    NSLog(@"1234567dict: %@,\n ", dict);
                                                    
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6006 ){
                                                       
//
                                                    }
                                                }
                                            } else{
                                               
//                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}

-(void)ApproverAndCC{
    
//    NSLog(@"请假请示件详情页：%@", self.datasourceMArray);
    
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
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneHeight *  7 / 10 + (iphoneHeight * 1 / 10  + 20 )  * i + 30,  60, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
        //                reasonTitleLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:reasonTitleLabel];
        
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5)];
            titleLabe.backgroundColor = [UIColor blueColor];
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
                    titleLabe.backgroundColor = [UIColor redColor];  
                }
            }
            [self.view addSubview:titleLabe];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
