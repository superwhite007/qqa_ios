//
//  RequestForInstructionViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/20.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RequestForInstructionViewController.h"

@interface RequestForInstructionViewController ()

@end

@implementation RequestForInstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"请示件内容"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提  交" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    
    UILabel * introducePersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, iphoneWidth - 40, 30)];
    introducePersonLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:introducePersonLabel];
    
    for (int i = 0; i < 3 ; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 110 + i * 45, iphoneWidth - 40, 40)];
        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
    }
    
    UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 100, 30)];
    reasonTitleLabel.text = @"请示件内容";
    reasonTitleLabel.textAlignment = NSTextAlignmentCenter;
    reasonTitleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:reasonTitleLabel];
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 150, iphoneWidth - 40, iphoneWidth * 2 / 3)];
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





-(void)chageColor{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
}




-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendNoticeToServer];
        NSLog(@"%@", text);
        return NO;
        
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        return NO;
    }
    
    
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSLog(@"%@", textView.text);
    //    if ([_mutableArray count] == 0) {
    //        NSLog(@"请选择发送范围");
    //    } else if (textView.text.length == 0){
    //        NSLog(@"请输入通知内容");
    //    }else if ([_mutableArray count] != 0 && textView.text.length != 0){
    //        NSLog(@"准备发送服务器");
    //        [self sendNoticeToServer];
    //    }
    
    
}



-(void)sendNoticeToServer{
    
    //    if ([_mutableArray count] == 0) {
    //        NSLog(@"请选择发送范围");
    //        [self alert:@"请选择发送范围"];
    //    } else
    if (_messageTextView.text.length == 0){
        NSLog(@"请输入通知内容");
        [self alert:@"请输入通知内容"];
        [self sendToServerTOBack];
    }
    //    else if ([_mutableArray count] != 0 && _messageTextView.text.length != 0){
    //        NSLog(@"准备发送服务器");
    //        [self sendToServerTOBack];
    //    }
    
}

-(void)sendToServerTOBack{
    NSLog(@"准备发送服务器：success");
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
