//
//  MessageViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/15.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MessageViewController.h"


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
    [sendButton setFrame:CGRectMake( ( iphoneWidth - 120 ) / 2, iphoneHeight  - 50, 120, 30)];
    [sendButton setTitle:@"发   送" forState:UIControlStateNormal];
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
    [self.view addSubview:rangeOfTransmissionLabel];
    
    
    
    
    
    
//    [self sendRangeoftransmission];
    [self scrlollVIew];
    
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
    
//    self.mutableArray = [NSMutableArray new];
//
//
//    NSArray * array = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",nil];
//
//    for (int i = 0 ; i  < [array count]; i++) {
//        UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        //        clickBtn.backgroundColor = [UIColor clearColor];
//
//
//        clickBtn.selected = NO;
//        clickBtn.frame = CGRectMake(20, i * 50 + 124  + iphoneWidth * 2 / 3 , 100, 30);
//        [clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [clickBtn setTag:i];
//        [clickBtn setTitle:array[i] forState:(UIControlStateNormal)];
//        clickBtn.backgroundColor = [UIColor grayColor];
//
//        clickBtn.layer.borderColor = [UIColor yellowColor].CGColor;
//        clickBtn.layer.borderWidth = 2;
//        clickBtn.layer.cornerRadius = 3;
//
//        [self.view addSubview:clickBtn];
//
//    }
    
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

    if ([_mutableArray count] == 0) {
        NSLog(@"请选择发送范围");
        [self alert:@"请选择发送范围"];
    } else if (_messageTextView.text.length == 0){
        NSLog(@"请输入通知内容");
        [self alert:@"请输入通知内容"];
    }else if ([_mutableArray count] != 0 && _messageTextView.text.length != 0){
        NSLog(@"准备发送服务器");
        [self sendToServerTOBack];
    }
    
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




-(void)sendToServerTOBack{
    NSLog(@"准备发送服务器：success");
    [self alert:@"发送服务器：success"];
    
}


/*
 
 - (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
 - (BOOL)textViewShouldEndEditing:(UITextView *)textView;
 
 - (void)textViewDidBeginEditing:(UITextView *)textView;
 - (void)textViewDidEndEditing:(UITextView *)textView;
 
 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
 - (void)textViewDidChange:(UITextView *)textView;
 
 - (void)textViewDidChangeSelection:(UITextView *)textView;
 
 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0);
 - (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0);
 
 - (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead");
 - (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead");

 */









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
