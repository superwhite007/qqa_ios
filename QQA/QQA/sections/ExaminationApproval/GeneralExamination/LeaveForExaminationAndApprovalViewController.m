//
//  LeaveForExaminationAndApprovalViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/20.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "LeaveForExaminationAndApprovalViewController.h"

#import "LMJDropdownMenu.h"

#import "WSDatePickerView.h"

#define RGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]


@interface LeaveForExaminationAndApprovalViewController ()<LMJDropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray * typeMArray;
@property (nonatomic, strong) NSMutableArray * cCMarray;
@property (nonatomic, strong) NSMutableArray * approvalMarray;

@property (nonatomic, strong) NSString * typeOfStr;
@property (nonatomic, strong) NSString * startTimeStr;
@property (nonatomic, strong) NSString * endTimeStr;
//messageTextView



@end

@implementation LeaveForExaminationAndApprovalViewController


//-(NSMutableArray *)cCMarray{
//    if (!_cCMarray) {
//        self.cCMarray = [NSMutableArray array];
//    }
//    return _cCMarray;
//}
//-(NSMutableArray *)approvalMarray{
//    if (!_approvalMarray) {
//        self.approvalMarray = [NSMutableArray array];
//    }
//    return _approvalMarray;
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [self gitInformationCCAndApprovalGroup];
    
    
}

-(void)gitInformationCCAndApprovalGroup{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/leave/scope", CONST_SERVER_ADDRESS]];
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
    NSLog(@"mdict%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"CCAndApprovalGroup: %@,\n %@\n", dictArray, [dictArray[0] objectForKey:@"message"]);
                                                
                                              
                                                if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6002 ) {
                                                  
                                                    self.approvalMarray = dictArray[1];
                                                    self.cCMarray = dictArray[2];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                      
                                                        [self ApproverAndCC];
                                                        
                                                    });
                                                    
                    
                                                    
                                                }
//
                                                
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"请假"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提  交" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    
    self.cCMarray = [NSMutableArray array];
    self.approvalMarray = [NSMutableArray array];
    self.typeOfStr = [NSString new];
    self.startTimeStr = [NSString new];
    self.endTimeStr = [NSString new];
    
    UILabel * introducePersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 30)];
//    introducePersonLabel.backgroundColor = [UIColor redColor];
    NSMutableString * introduceStr = [NSMutableString stringWithFormat:@"11111"];
    
    [self.view addSubview:introducePersonLabel];
    
    _typeMArray = [NSMutableArray arrayWithObjects:@"调休", @"年假", @"婚假", @"产假", @"病假", @"事假", @"丧假", @"工伤假", @"其他", nil];
    
    
    
    for (int i = 0; i < 3 ; i++) {
        
        if (i == 0) {
            LMJDropdownMenu * dropdownMenu = [[LMJDropdownMenu alloc] init];
            [dropdownMenu setFrame:CGRectMake(20, 110 + i * 45, iphoneWidth - 40, 40)];
            [dropdownMenu setMenuTitles:_typeMArray rowHeight:30];
            dropdownMenu.delegate = self;
            [self.view addSubview:dropdownMenu];
        } else {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 110 + i * 45, iphoneWidth - 40, 40)];
            view.backgroundColor = [UIColor redColor];
//            [self.view addSubview:view];
            
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(20, 110 + i * 45, iphoneWidth - 40, 40);
            selectBtn.layer.cornerRadius = 5;
            selectBtn.backgroundColor = [UIColor lightGrayColor];
            [selectBtn setTitle:@"选择时间" forState:UIControlStateNormal];
            [self.view addSubview:selectBtn];
            selectBtn.tag = i;
            [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
        }
       
    }
    
    UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 245, 100, 30)];
    reasonTitleLabel.text = @"请假事由";
    reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
//    reasonTitleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:reasonTitleLabel];
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 280, iphoneWidth - 40, iphoneWidth * 1 / 3)];
    //    messageTextView.backgroundColor = [UIColor blueColor];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    
    _messageTextView.delegate = self;
    
//    [self ApproverAndCC];
    
}


- (void)selectAction:(UIButton *)btn {
    
    //_________________________年-月-日-时-分____________________________________________
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        if (btn.tag == 1) {
            NSString *date = [selectDate stringWithFormat:@"开始时间：yyyy-MM-dd HH:mm"];
            NSString *data1 = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.startTimeStr = data1;
            NSLog(@"start：%@",self.startTimeStr);
            [btn setTitle:date forState:UIControlStateNormal];
        } else if (btn.tag == 2) {
            NSString *date = [selectDate stringWithFormat:@"结束时间：yyyy-MM-dd HH:mm"];
            NSString *data1 = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.endTimeStr = data1;
            NSLog(@"self.endTimeStr：%@",self.endTimeStr);
            [btn setTitle:date forState:UIControlStateNormal];
        }
//         NSLog(@"选择的日期：%@",date);
//        [btn setTitle:date forState:UIControlStateNormal];
        
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
    
}

-(void)chageColor{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
    [self sendNoticeToServer];
    
}

#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    
    
    if (number == 0) {
        self.typeOfStr = @"100";
        
    } else if (number == 1){
        self.typeOfStr = @"101";
        
    } else if (number == 2){
        self.typeOfStr = @"102";
        
    } else if (number == 3){
        self.typeOfStr = @"103";
        
    } else if (number == 4){
        self.typeOfStr = @"104";
        
    } else if (number == 5){
        self.typeOfStr = @"105";
        
    } else if (number == 6){
        self.typeOfStr = @"106";
        
    } else if (number == 7){
        self.typeOfStr = @"107";
        
    } else if (number == 8){
        self.typeOfStr = @"108";
        
    }
    
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    NSLog(@"--将要显示--");
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    NSLog(@"--已经显示--");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--将要隐藏--");
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--已经隐藏--");
}

-(void)ApproverAndCC{
    
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    
    NSLog(@"peopleOfApprover, peopleOfCC:111111%@,\n %@\n", peopleOfApprover, peopleOfCC);
    
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 5 , 100, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
//        reasonTitleLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:reasonTitleLabel];
        
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  , (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5)];
            
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  , (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5)];
            titleLabe.backgroundColor = [UIColor blueColor];
            titleLabe.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
            titleLabe.text = [mArrayOFApproverAndCC[i][j] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            [self.view addSubview:titleLabe];
            
            
            imgView.backgroundColor = [UIColor redColor];
            imgView.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
//            [self.view addSubview:imgView];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  +  (iphoneWidth - 70 ) / 5 + 5, (iphoneWidth - 70 ) / 5, (iphoneWidth - 70 ) / 5 / 3)];
            nameLabel.text = mArrayOFApproverAndCC[i][j];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.backgroundColor = [UIColor redColor];
            [self.view addSubview:nameLabel];
          
        }
    }
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
    
    //NSLog(@"%@", textView.text);
    //    if ([_mutableArray count] == 0) {
    //        //NSLog(@"请选择发送范围");
    //    } else if (textView.text.length == 0){
    //        //NSLog(@"请输入通知内容");
    //    }else if ([_mutableArray count] != 0 && textView.text.length != 0){
    //        //NSLog(@"准备发送服务器");
    //        [self sendNoticeToServer];
    //    }
     [textView resignFirstResponder];
    
}



-(void)sendNoticeToServer{
    
    if (_messageTextView.text.length == 0){
        [self alert:@"请输入请假事由"];
    } else if (_typeOfStr.length == 0){
        [self alert:@"请选择请假类型"];
    } else if (_startTimeStr.length == 0){
        [self alert:@"请选择开始时间"];
    } else if (_endTimeStr.length == 0){
        [self alert:@"请选择结束时间"];
    } else {
        
        [self sendMessagesToServer];
    }
 
}

-(void)sendMessagesToServer{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/leave/store", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_typeOfStr forKey:@"type"];
    [mdict setObject:_startTimeStr forKey:@"starttime"];
    [mdict setObject:_endTimeStr forKey:@"endtime"];
    [mdict setObject:_messageTextView.text forKey:@"reason"];
    
    
    
    
    NSLog(@"mdict%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                
                                                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"3dict:%@", dict);
//                                                NSLog(@"222222CCAndApprovalGroup: %@,\n %@\n", dictArray, [dictArray[0] objectForKey:@"message"]);
                                                
                                                
                                                if ( [[dict objectForKey:@"message"] intValue] == 6003 ) {
//
//
//
                                                    dispatch_async(dispatch_get_main_queue(), ^{

                                                        [self sendToServerTOBack];

                                                    });
                                                }
                                                
                                            } else{
                                                //NSLog(@"获取数据失败，问");
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
