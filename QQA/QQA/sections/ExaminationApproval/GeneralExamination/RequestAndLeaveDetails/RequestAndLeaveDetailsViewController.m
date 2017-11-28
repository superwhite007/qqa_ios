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


@end

@implementation RequestAndLeaveDetailsViewController

//-(UILabel *)reasonLabel{
//    if (!_reasonLabel) {
//        self.reasonLabel = [[UILabel alloc] init];
//    }
//    return _reasonLabel;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
    NSLog(@"%f, %f",iphoneWidth, iphoneHeight);
    
    [self setViewAboutNameTimeReason];
    [self setTextView];
    
    
}

-(void)setViewAboutNameTimeReason{
    
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 25)];
    _nameLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_nameLabel];
    
    _created_atTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, iphoneWidth - 40, 25)];
    _created_atTimeLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_created_atTimeLabel];
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  134, (iphoneWidth  - 50) / 2 , 25)];
    _statusLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_statusLabel];
    
    _statusReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  134, (iphoneWidth  - 50) / 2 , 25)];
    _statusReasonLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_statusReasonLabel];
    
    
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 164, iphoneWidth / 2 - 25, 25)];
    _startTimeLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_startTimeLabel];
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  164, (iphoneWidth  - 50) / 2, 25)];
    _endTimeLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_endTimeLabel];
    
    
    _longTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 194, iphoneWidth - 40, 25)];
    _longTimeLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_longTimeLabel];
  
    
    
    
    
    _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 234 , iphoneWidth - 40, iphoneHeight / 7 + 15)];
    _reasonLabel.backgroundColor = [UIColor redColor];
    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _reasonLabel.layer.borderWidth = 1;
    _reasonLabel.layer.cornerRadius = 10;
    _reasonLabel.layer.masksToBounds = YES;
    [self.view addSubview:_reasonLabel];
    
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
        button.backgroundColor = [UIColor redColor];
        button.layer.cornerRadius = 5;
        NSLog(@"array[i]:%@", array[i]);
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        button.tag = i;
        [self.view addSubview:button];
        
    }
    [self.view addSubview:_messageTextView];
    
    
    [self ApproverAndCC];
}



-(void)ApproverAndCC{
    
    
    NSArray * titleArray =@[@"审批人", @"抄送人"];
//    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
//    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    
    NSArray * peopleOfApprover = @[@"A", @"AA", @"A", @"A"];
    NSArray * peopleOfCC = @[@"CC", @"CC", @"CC", @"CC", @"CC"];
    
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    
    NSLog(@"peopleOfApprover, peopleOfCC:111111%@,\n %@\n", peopleOfApprover, peopleOfCC);
    
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
            titleLabe.text = [mArrayOFApproverAndCC[i][j] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            [self.view addSubview:titleLabe];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 280 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
            nameLabel.text = mArrayOFApproverAndCC[i][j];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
//            nameLabel.backgroundColor = [UIColor redColor];
            [self.view addSubview:nameLabel];
           
        }
    }
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
