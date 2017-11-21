//
//  MessageViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/15.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MessageViewController.h"
#import "SendTheScopeViewController.h"

@interface MessageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray * mutableArray;
//@property (nonatomic, strong)

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"发送通知"];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送范围" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, iphoneWidth - 20, iphoneWidth * 2 / 3)];
//    messageTextView.backgroundColor = [UIColor blueColor];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    
    _messageTextView.delegate = self;
    
    
    
    

    
    UIButton  * sendButton =  [UIButton buttonWithType:UIButtonTypeSystem];
//    [sendButton setFrame:CGRectMake( ( iphoneWidth - 120 ) / 2, iphoneHeight  - 50, 120, 30)];
    [sendButton setFrame:CGRectMake( ( iphoneWidth - 120 ) / 2, iphoneWidth * 2 / 3 + 100, 120, 30)];
    
    [sendButton setTitle:@"下一步" forState:UIControlStateNormal];
//    sendButton.titleLabel.font = [UIFont systemFontOfSize:24];
//    sendButton.backgroundColor = [UIColor blueColor];
    
    sendButton.layer.borderColor = [UIColor blackColor].CGColor;
    sendButton.layer.borderWidth = 1;
    sendButton.layer.cornerRadius = 5;
    
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sends) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sendButton];
    
    UILabel * rangeOfTransmissionLabel = [[UILabel alloc] initWithFrame:CGRectMake( 10,  _messageTextView.frame.size.height + 84, 120, 30)];
    rangeOfTransmissionLabel.text = @"发送范围";
    rangeOfTransmissionLabel.textAlignment = NSTextAlignmentCenter;
    rangeOfTransmissionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    rangeOfTransmissionLabel.layer.borderWidth = 1;
    rangeOfTransmissionLabel.layer.cornerRadius = 5;
//    [self.view addSubview:rangeOfTransmissionLabel];
    
    
    
    [self gitMessageAboutGiveNotices];
    
    
//    [self sendRangeoftransmission];
//    [self scrlollVIew];
    
}


-(void)gitMessageAboutGiveNotices{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/message/scope"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    
    NSLog(@"resultDic, resultDicAccess:%@, %@", resultDic, resultDicAccess);
    
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
                                            
                                            //                                            NSLog(@"response, error :%@, %@", response, error);
                                            //                                            NSLog(@"data:%@", data);
                                            
                                            if (data != nil) {
                                                
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"MessageViewControllerdict: %@", dict);
                                                NSMutableArray * array = dict[@"departments"];
                                                
                                                
                                                
                                                
//                                                dispatch_async(dispatch_get_main_queue(), ^{
////                                                    [self  gitSomeThingsdictionary:dict];
//
//                                                });
                                                
                                            } else{
                                                NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}









-(void)scrlollVIew{
    
    UIView * scrollView = [[UIView alloc] initWithFrame:CGRectMake(0, _messageTextView.frame.size.height + 124, iphoneWidth - 20,  iphoneWidth * 2 / 3 - 50)];
    scrollView.backgroundColor = [UIColor blueColor];
    
//    [self.view addSubview: scrollView];
    
    UIScrollView * scrollsView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, _messageTextView.frame.size.height + 124, iphoneWidth - 20,  iphoneWidth * 2 / 3 - 50) ];
//    scrollsView.backgroundColor = [UIColor redColor];
    scrollsView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds) * 2);
//    scrollsView.contentOffset  = CGPointMake(CGRectGetWidth(scrollView.bounds), 0);
    scrollsView.showsHorizontalScrollIndicator = NO;
    
    scrollsView.delegate = self;
    
    scrollsView.layer.borderColor = [UIColor blackColor].CGColor;
    scrollsView.layer.borderWidth = 1;
    scrollsView.layer.cornerRadius = 5;
    
    
    [self.view addSubview:scrollsView];
    
    
    
    
    self.mutableArray = [NSMutableArray new];
    
    
    NSArray * array = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",nil];
    
    for (int i = 0 ; i  < [array count]; i++) {
        UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        clickBtn.backgroundColor = [UIColor clearColor];
        
        
        clickBtn.selected = NO;
        clickBtn.frame = CGRectMake(20, i * 50 + 10 , iphoneWidth - 60, 30);
        [clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn setTag:i];
        [clickBtn setTitle:array[i] forState:(UIControlStateNormal)];
        clickBtn.backgroundColor = [UIColor grayColor];
        
        clickBtn.layer.borderColor = [UIColor yellowColor].CGColor;
        clickBtn.layer.borderWidth = 2;
        clickBtn.layer.cornerRadius = 3;
        
        [scrollsView addSubview:clickBtn];
        
    }
    
}






-(void)sendRangeoftransmission{
 
    
}


- (void)btnClick:(UIButton *)sender{
    
    //    NSLog(@"sender::%ld, %@", (long)sender.tag, sender.titleLabel.text);
    ////    self.mutableArray = [NSMutableArray new];
    //    [self.mutableArray addObject:sender.titleLabel.text];
    //    NSLog(@" mutableArray%@", _mutableArray);
    
    NSString *str = sender.titleLabel.text;
    BOOL isbool = [_mutableArray containsObject: str];
    if (isbool) {
        [self.mutableArray removeObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor grayColor];
        
    }else{
        [self.mutableArray addObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor purpleColor];
        
    }
    NSLog(@" mutableArray%@", _mutableArray);
    
    
    NSLog(@"%i",isbool);
    
    
}





-(void)sends{
    
     [_messageTextView resignFirstResponder];
    [self sendNoticeToServer];
  
    
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendNoticeToServer];
        return NO;
        
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        return NO;
    }
    
    
    return YES;
    
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSLog(@"%@", textView.text);
    
    
}

-(void)sendNoticeToServer{
    
    if (_messageTextView.text.length == 0){
        NSLog(@"请输入通知内容");
        [self alert:@"请输入通知内容"];
    }else if ( _messageTextView.text.length != 0){
        NSLog(@"准备发送服务器");
//        [self sendToServerTOBack];
        
        SendTheScopeViewController * sendTheScopeVC = [SendTheScopeViewController new];
        [self.navigationController pushViewController:sendTheScopeVC animated:YES];
        
    
    }
    
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










-(void)chageColor{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
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
