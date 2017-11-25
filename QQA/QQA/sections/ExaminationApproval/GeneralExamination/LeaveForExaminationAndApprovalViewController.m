//
//  LeaveForExaminationAndApprovalViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/20.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "LeaveForExaminationAndApprovalViewController.h"

#import "LMJDropdownMenu.h"


@interface LeaveForExaminationAndApprovalViewController ()<LMJDropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray * typeMArray;
@property (nonatomic, strong) NSMutableArray * cCMarray;
@property (nonatomic, strong) NSMutableArray * approvalMarray;


@end

@implementation LeaveForExaminationAndApprovalViewController


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

-(void)viewWillAppear:(BOOL)animated{
    
    [self gitInformationCCAndApprovalGroup];
    
}

-(void)gitInformationCCAndApprovalGroup{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/leave/scope"]];
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
                                            
                                            if (data != nil) {
                                                
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"companyNOtice: %@,\n %@\n", dictArray, [dictArray[0] objectForKey:@"message"]);
                                                
                                              
//                                                if ( [[dictArray[0] objectForKey:@"messages"] intValue] == 5005 ) {
//                                                    NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
//                                                    [array1 removeObjectAtIndex:0];
//
//                                                    for (NSDictionary * dict in array1) {
//                                                        ACPApproval * aCPApproval = [ACPApproval new];
//                                                        [ACPApproval setValuesForKeysWithDictionary:dict];
//                                                        [self.datasouceArray addObject:aCPApproval];
//
//                                                        //                                                    dispatch_async(dispatch_get_main_queue(), ^{
////                                                        [self.aCPApprovalListView.tableView  reloadData];
//                                                        //                                                    });
//                                                        //
//                                                    }
//                                                }
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
    
    UILabel * introducePersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 30)];
    introducePersonLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:introducePersonLabel];
    
    _typeMArray = [NSMutableArray arrayWithObjects:@"事假", @"病假", @"懒癌晚期", nil];
    
    
    
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
            [self.view addSubview:view];
        }
       
    }
    
    UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 245, 100, 30)];
    reasonTitleLabel.text = @"reason";
    reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
    reasonTitleLabel.backgroundColor = [UIColor redColor];
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
    
    [self ApproverAndCC];
    
}


-(void)chageColor{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
}

#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
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
    NSArray * peopleOfApprover = @[@"A", @"AA", @"A", @"A"];
    NSArray * peopleOfCC = @[@"CC", @"CC", @"CC", @"CC", @"CC"];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    
    
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 5 , 100, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
        reasonTitleLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:reasonTitleLabel];
        
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  , (iphoneWidth - 70 ) / 5 , (iphoneWidth - 70 ) / 5)];
            
            
            imgView.backgroundColor = [UIColor redColor];
            imgView.layer.cornerRadius = (iphoneWidth - 70 ) / 5 / 2;
            [self.view addSubview:imgView];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + j * ((iphoneWidth - 70 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 70 ) / 5 + 30 ) + 40  +  (iphoneWidth - 70 ) / 5 + 5, (iphoneWidth - 70 ) / 5, (iphoneWidth - 70 ) / 5 / 3)];
            nameLabel.text = titleArray[i];
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
    
    
}



-(void)sendNoticeToServer{
    
//    if ([_mutableArray count] == 0) {
//        //NSLog(@"请选择发送范围");
//        [self alert:@"请选择发送范围"];
//    } else
    if (_messageTextView.text.length == 0){
        //NSLog(@"请输入通知内容");
        [self alert:@"请输入通知内容"];
        [self sendToServerTOBack];
    }
//    else if ([_mutableArray count] != 0 && _messageTextView.text.length != 0){
//        //NSLog(@"准备发送服务器");
//        [self sendToServerTOBack];
//    }
    
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
