//
//  RequestAndLeaveDetailsViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/28.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RequestAndLeaveDetailsViewController.h"

@interface RequestAndLeaveDetailsViewController ()

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * created_atTimeLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * statusReasonLabel;
@property (nonatomic, strong) UILabel * startTimeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * longTimeLabel;
@property (nonatomic, strong) UILabel * reasonLabel;

@property (nonatomic, strong) NSMutableArray * cCMarray;
@property (nonatomic, strong) NSMutableArray * approvalMarray;
@property (nonatomic, strong) NSMutableArray * datasourceMArray;


@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) BOOL buttonAgree;


@end

@implementation RequestAndLeaveDetailsViewController



-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        self.datasourceMArray = [[NSMutableArray alloc] init];
    }
    return _datasourceMArray;
}

-(NSMutableArray *)approvalMarray{
    if (!_approvalMarray) {
        self.approvalMarray = [[NSMutableArray alloc] init];
    }
    return  _approvalMarray;
}

-(NSMutableArray *)cCMarray{
    if (!_cCMarray) {
        self.cCMarray = [[NSMutableArray alloc] init];
    }
    return _cCMarray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
    NSLog(@"%f, %f",iphoneWidth, iphoneHeight);
    NSLog(@"_leaveIdStr:%@", _leaveIdStr);
    [self.navigationItem setTitle:_titleIdentStr];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发  送" style:(UIBarButtonItemStyleDone) target:self action:@selector(sendApprovalMessagesToServer)];
    
    [self loadNewData];
    [self setViewAboutNameTimeReason];
    [self setTextView];
  
    
    
}

-(void)setViewAboutNameTimeReason{
    
//
//    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 25)];
//    _nameLabel.backgroundColor = [UIColor redColor];
//    _nameLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_nameLabel];
//
//    _created_atTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, iphoneWidth - 40, 25)];
//    _created_atTimeLabel.backgroundColor = [UIColor redColor];
//    _created_atTimeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_created_atTimeLabel];
//
//    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  134, (iphoneWidth  - 50) / 2 , 25)];
//    _statusLabel.backgroundColor = [UIColor redColor];
//
//
//    _statusReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  134, (iphoneWidth  - 50) / 2 , 25)];
//    _statusReasonLabel.backgroundColor = [UIColor redColor];
//
//
//
//    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 164, iphoneWidth / 2 - 25, 25)];
//    _startTimeLabel.backgroundColor = [UIColor redColor];
//    _startTimeLabel.adjustsFontSizeToFitWidth = YES;
//
//
//    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  164, (iphoneWidth  - 50) / 2, 25)];
//    _endTimeLabel.backgroundColor = [UIColor redColor];
//    _endTimeLabel.adjustsFontSizeToFitWidth = YES;
//
//
//
//    _longTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 194, iphoneWidth - 40, 25)];
//    _longTimeLabel.backgroundColor = [UIColor redColor];
//
//
//    if ([_titleIdentStr isEqualToString:@"请假"]) {
//        [self.view addSubview:_startTimeLabel];
//        [self.view addSubview:_statusLabel];
//        [self.view addSubview:_statusReasonLabel];
//        [self.view addSubview:_endTimeLabel];
//        [self.view addSubview:_longTimeLabel];
//        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 234 , iphoneWidth - 40, iphoneHeight / 7 + 15)];
//    } else{
//        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 134 , iphoneWidth - 40, iphoneHeight / 7 + 115)];
//    }
//
//
//
//
//
//
//
//    _reasonLabel.backgroundColor = [UIColor redColor];
//    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    _reasonLabel.layer.borderWidth = 1;
//    _reasonLabel.layer.cornerRadius = 10;
//    _reasonLabel.layer.masksToBounds = YES;
//    [self.view addSubview:_reasonLabel];
//
}

-(void)setTextView{
    
   
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 229 + iphoneWidth * 1 / 3, iphoneWidth - 40, iphoneHeight / 7 - 20)];
    //    messageTextView.backgroundColor = [UIColor blueColor];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    
    _messageTextView.delegate = self;
    
    
    
    NSArray * array = @[@"拒绝", @"同意"];
    for (int i = 0; i < 2; i++) {
        UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame = CGRectMake(iphoneWidth - 230 + i * 110, 189 + iphoneWidth * 2 / 3  , 100, 30);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 5;
        NSLog(@"array[i]:%@", array[i]);
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(changeButtonAgree:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = i;
        [self.view addSubview:button];
        
    }
    [self.view addSubview:_messageTextView];
    
    
//    [self ApproverAndCC];
}

-(void)changeButtonAgree:(UIButton *)sender{
    
    
    if ([self.title isEqualToString:@"拒绝"]) {
        _buttonAgree = NO;
        
        
    } else if ([self.title isEqualToString:@"同意"]){
        _buttonAgree = YES;
    }
    
}

-(void)ApproverAndCC{
    
    NSLog(@"66663464%@", self.datasourceMArray);

    
    
    for (int i = 0; i < [_datasourceMArray count]; i++) {
        NSString * str = [_datasourceMArray[i] objectForKey:@"type"] ;
        if ([str isEqualToString:@"approver"]) {
//            NSLog(@"");
            NSDictionary * dict = _datasourceMArray[i];
            [self.approvalMarray addObject:dict];
//            NSLog(@"%@", self.approvalMarray);
        } else if ([str isEqualToString:@"reader"]){
            
            [self.cCMarray addObject:_datasourceMArray[i]];
//            NSLog(@"111%@", self.cCMarray);
        }
    }
    if ([self.approvalMarray count] == 0 || self.cCMarray.count == 0) {
        return;
    }
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
//
//    NSArray * peopleOfApprover = @[@"A", @"AA", @"A", @"A"];
//    NSArray * peopleOfCC = @[@"CC", @"CC", @"CC", @"CC", @"CC"];
    
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    
//    NSLog(@"peopleOfApprover, peopleOfCC:111111%@,\n %@\n", self.approvalMarray, self.cCMarray);
    
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneHeight *  7 / 10 + (iphoneHeight * 1 / 10  + 20 )  * i + 30,  60, 30)];//iphoneHeight * ( 7 / 10  + i * 1 / 10)
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



-(void)viewWillAppear:(BOOL)animated{
//    [self loadNewData];
    //获取数据
}
-(void)loadNewData
{
    //记录是下拉刷新
    self.isDownRefresh = YES;
    [self loadDataAndShowWithPageNum:1];
    //    [self.foodListView.tableView.header endRefreshing];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page
{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, _urlStr]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveIdStr forKey:@"leaveId"];
    } else if ([_titleIdentStr isEqualToString:@"请示件"]) {
        [mdict setObject:_leaveIdStr forKey:@"askId"];
    }
    

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
                                                    NSLog(@"Request: %@,\n ", dictArray);
                                                    
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6008 || [[dictArray[0] objectForKey:@"message"] intValue] == 6019) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        NSDictionary * dict = array1[0];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            
                                                             [self setvaleKeyAndValue:dict];
                                                         });
                                                       
                                                        [array1 removeObjectAtIndex:0];
//                                                        NSLog(@"4444444444\n\narray1: %@,\n ", array1);
                                                        self.datasourceMArray = array1;
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self ApproverAndCC];
                                                        });
                                                        
                                                        
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    NSLog(@"1234567dict: %@,\n ", dict);
                                                    
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6007 ){
//                                                        self.isEmpty = YES;
//                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
//                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            [self.aCPApprovalListView.tableView  reloadData];
//                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                //NSLog(@"获取数据失败，问");
//                                                [self.datasouceArray addObject:@"获取数据失败"];
//                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    [self.aCPApprovalListView.tableView  reloadData];
//                                                });
                                            }
                                        }];
    [task resume];
    
}

-(void)setvaleKeyAndValue:(NSDictionary *)dict{
    
    
    
    
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
    
    
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [self.view addSubview:_startTimeLabel];
        [self.view addSubview:_statusLabel];
        [self.view addSubview:_statusReasonLabel];
        [self.view addSubview:_endTimeLabel];
        [self.view addSubview:_longTimeLabel];
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 234 , iphoneWidth - 40, iphoneHeight / 7 + 15)];
    } else{
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 134 , iphoneWidth - 40, iphoneHeight / 7 + 115)];
    }
    
    _reasonLabel.backgroundColor = [UIColor redColor];
    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _reasonLabel.layer.borderWidth = 1;
    _reasonLabel.layer.cornerRadius = 10;
    _reasonLabel.layer.masksToBounds = YES;
    [self.view addSubview:_reasonLabel];
    
    
    _nameLabel.text = [dict objectForKey:@"username"];
    
//    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
    _created_atTimeLabel.text = [dict objectForKey:@"createdAt"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起始:%@", [dict objectForKey:@"starttime"]];
    
    if ([_titleIdentStr isEqualToString:@"请假"]) {
       _reasonLabel.text = [dict objectForKey:@"reason"];
    } else{
       _reasonLabel.text = [dict objectForKey:@"content"];
    }
    
    
    _statusLabel.text =[NSString stringWithFormat:@"类型:%@", [dict objectForKey:@"type"]];
    _endTimeLabel.text = [NSString stringWithFormat:@"结束:%@", [dict objectForKey:@"endtime"]];
    _longTimeLabel.text =[NSString stringWithFormat:@"请假天数:%@",  [dict objectForKey:@"betweentime"]];
    
//    [self ApproverAndCC];
    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
    
}







-(void)chageColor{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
}




-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendNoticeToServer];
        //NSLog(@"%@", text);
        return NO;
        
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        return NO;
    }
    
    
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}



-(void)sendNoticeToServer{
    
    if (_messageTextView.text.length == 0){
        //NSLog(@"请输入通知内容");
        [self alert:@"请输入通知内容"];
        [self sendToServerTOBack];
    }
   
    
}

-(void)sendApprovalMessagesToServer{
    
    ///v1/api/ask/update
    NSString  * uMStr =  [NSMutableString new];
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        uMStr = @"/v1/api/leave/update";
    } else{
        uMStr = @"/v1/api/ask/update";
    }
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, uMStr]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    
    
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveIdStr forKey:@"leaveId"];
    } else{
        [mdict setObject:_leaveIdStr forKey:@"askId"];
    }
 
    if (_buttonAgree) {
        [mdict setObject:@"agree" forKey:@"status"];
    } else {
         [mdict setObject:@"refuse" forKey:@"status"];
    }
    if (_messageTextView.text.length == 0) {
        [mdict setObject:@"NULL" forKey:@"comment"];
    }else{
        [mdict setObject:_messageTextView.text forKey:@"comment"];
    }
    
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
//                                                    NSLog(@"1111111234567dictArray: %@,\n ", dictArray);
                                                    
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6010 ) {
                                                        self.isEmpty = NO;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"审批完成"];
                                                        });
                                                        
                                                        
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    NSLog(@"1234567dict: %@,\n ", dict);
                                                    
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6010 || [[dict objectForKey:@"message"] intValue] == 6022) {
                                                        self.isEmpty = NO;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"审批完成"];
                                                        });
                                                    }
                                                    
                                                    
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                
                                            }
                                        }];
    [task resume];
    
    
    
    
}






-(void)sendToServerTOBack{
    //NSLog(@"准备发送服务器：success");
    [self alert:@"发送服务器：success"];
    
}




-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"I need your attention NOW!";
    NSString *okButtonTitle = @"OK";
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Nothing to do.
    }];
    
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
    
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
