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
@end

@implementation LeaveForExaminationAndApprovalViewController

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
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                
//                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                if ([dataBack isKindOfClass:[NSArray class]]) {
//                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                    NSLog(@"MessageViewControllerdict: %@", dictArray);
//                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5002) {
//                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
//                                                        [array1 removeObjectAtIndex:0];
//
////                                                        [self setDataToDatasoureSendScopeArray:array1];
//
//                                                    }
//
//                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
//                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                    NSLog(@"1234567dict: %@,\n ", dict);
//                                                }
                                                
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6002 ) {
                                                    self.approvalMarray = dictArray[1];
                                                    self.cCMarray = dictArray[2];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self ApproverAndCC];
                                                    });
                                                }
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
    UILabel * introducePersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, iphoneWidth - 40, 30)];
//    introducePersonLabel.backgroundColor = [UIColor redColor];
//    NSMutableString * introduceStr = [NSMutableString stringWithFormat:@"11111"];
    [self.view addSubview:introducePersonLabel];
    _typeMArray = [NSMutableArray arrayWithObjects:@"调休", @"年假", @"婚假", @"产假", @"病假", @"事假", @"丧假", @"工伤假", @"其他", nil];
    for (int i = 0; i < 3 ; i++) {
        if (i == 0) {
            LMJDropdownMenu * dropdownMenu = [[LMJDropdownMenu alloc] init];
            [dropdownMenu setFrame:CGRectMake(20, 10, iphoneWidth - 40, 40)];
            [dropdownMenu setMenuTitles:_typeMArray rowHeight:30];
            dropdownMenu.delegate = self;
            [self.view addSubview:dropdownMenu];
        } else {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 110 + i * 45, iphoneWidth - 40, 40)];
            view.backgroundColor = [UIColor redColor];
//            [self.view addSubview:view];
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(20, 56 + ( i - 1 ) * 45, iphoneWidth - 40, 40);
            selectBtn.layer.cornerRadius = 5;
            selectBtn.backgroundColor = [UIColor lightGrayColor];
            [selectBtn setTitle:@"选择时间" forState:UIControlStateNormal];
            [self.view addSubview:selectBtn];
            selectBtn.tag = i;
            [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 151, 100, 30)];
    reasonTitleLabel.text = @"请假事由";
    reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
//    reasonTitleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:reasonTitleLabel];
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 186, iphoneWidth - 40, iphoneWidth * 1 / 3 + 30)];
    //    messageTextView.backgroundColor = [UIColor blueColor];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    _messageTextView.delegate = self;
}


- (void)selectAction:(UIButton *)btn {
    //_________________________年-月-日-时-分____________________________________________
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        if (btn.tag == 1) {
            NSString *date = [selectDate stringWithFormat:@"开始时间：yyyy-MM-dd HH:mm"];
            NSString *data1 = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.startTimeStr = data1;
            [btn setTitle:date forState:UIControlStateNormal];
        } else if (btn.tag == 2) {
            NSString *date = [selectDate stringWithFormat:@"结束时间：yyyy-MM-dd HH:mm"];
            NSString *data1 = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.endTimeStr = data1;
            [btn setTitle:date forState:UIControlStateNormal];
        }
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
}

-(void)chageColor{
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [self sendNoticeToServer];
}

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
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


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_messageTextView isExclusiveTouch]) {
        [_messageTextView resignFirstResponder];
    }
}

-(void)ApproverAndCC{
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        [self ApproverAndCCAfteriPhone6];;
    }else{
        [self ApproverAndCCSEAnd5S];
    }
}

-(void)ApproverAndCCSEAnd5S{
    
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5  ) + 5 , 100, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
//            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 8 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 8 + 30 ) + 40  , (iphoneWidth - 70 ) / 10 , (iphoneWidth - 70 ) / 10)];
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(40 + j * ((iphoneWidth - 70 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 ) + 30  , (iphoneWidth - 70 ) / 6 , (iphoneWidth - 70 ) / 6)];
            titleLabe.layer.borderColor = [UIColor blackColor].CGColor;
            titleLabe.layer.borderWidth = 1;
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 70 ) / 6 / 2;
            titleLabe.text = [mArrayOFApproverAndCC[i][j] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            [self.view addSubview:titleLabe];
//            imgView.layer.borderWidth = 1;
//            imgView.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 + j * ((iphoneWidth - 70 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5  ) + 25  +  (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5, (iphoneWidth - 70 ) / 5 / 3)];
            nameLabel.text = mArrayOFApproverAndCC[i][j];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:nameLabel];
        }
    }
}

-(void)ApproverAndCCAfteriPhone6{
    
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 5 , 100, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  , (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5)];
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  , (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5)];
            titleLabe.layer.borderColor = [UIColor blackColor].CGColor;
            titleLabe.layer.borderWidth = 1;
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
            titleLabe.text = [mArrayOFApproverAndCC[i][j] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            [self.view addSubview:titleLabe];
            imgView.layer.borderWidth = 1;
            imgView.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  +  (iphoneWidth - 70 ) / 5 + 5, (iphoneWidth - 70 ) / 5, (iphoneWidth - 70 ) / 5 / 3)];
            nameLabel.text = mArrayOFApproverAndCC[i][j];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
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
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ( [[dict objectForKey:@"message"] intValue] == 6003 ) {
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
    [self alert:@"发送服务器：success"];
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"请注意!";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
        if ([title isEqualToString:@"发送服务器：success"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
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
