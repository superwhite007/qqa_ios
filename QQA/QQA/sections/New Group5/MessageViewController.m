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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送范围" style:(UIBarButtonItemStyleDone) target:self action:@selector(sends)];
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, iphoneWidth - 20, iphoneWidth * 2 / 3)];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    _messageTextView.delegate = self;
    UIButton  * sendButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [sendButton setFrame:CGRectMake( ( iphoneWidth - 120 ) / 2, iphoneWidth * 2 / 3 + 100, 120, 30)];
    [sendButton setTitle:@"下一步" forState:UIControlStateNormal];
    sendButton.layer.borderColor = [UIColor blackColor].CGColor;
    sendButton.layer.borderWidth = 1;
    sendButton.layer.cornerRadius = 5;
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sends) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sendButton];
    UILabel * rangeOfTransmissionLabel = [[UILabel alloc] initWithFrame:CGRectMake( 10,  _messageTextView.frame.size.height + 84, 120, 30)];
    rangeOfTransmissionLabel.text = @"发送范围";
    rangeOfTransmissionLabel.textAlignment = NSTextAlignmentCenter;
    rangeOfTransmissionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    rangeOfTransmissionLabel.layer.borderWidth = 1;
    rangeOfTransmissionLabel.layer.cornerRadius = 5;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_messageTextView isExclusiveTouch]) {
        [_messageTextView resignFirstResponder];
    }
}

-(void)scrlollVIew{
    
    UIView * scrollView = [[UIView alloc] initWithFrame:CGRectMake(0, _messageTextView.frame.size.height + 124, iphoneWidth - 20,  iphoneWidth * 2 / 3 - 50)];
    scrollView.backgroundColor = [UIColor blueColor];
    UIScrollView * scrollsView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, _messageTextView.frame.size.height + 124, iphoneWidth - 20,  iphoneWidth * 2 / 3 - 50) ];
    scrollsView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds) * 2);
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

- (void)btnClick:(UIButton *)sender{
    NSString *str = sender.titleLabel.text;
    BOOL isbool = [_mutableArray containsObject: str];
    if (isbool) {
        [self.mutableArray removeObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor grayColor];
    }else{
        [self.mutableArray addObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor purpleColor];
    }
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
    //NSLog(@"%@", textView.text);

}

-(void)sendNoticeToServer{
    if (_messageTextView.text.length == 0){
        [self alert:@"请输入通知内容"];
    }else if ( _messageTextView.text.length != 0){
        SendTheScopeViewController * sendTheScopeVC = [SendTheScopeViewController new];
        sendTheScopeVC.sendMessage = _messageTextView.text;
        [self.navigationController pushViewController:sendTheScopeVC animated:YES];
    }
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
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}


-(void)chageColor{
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"122222222222222222222222");
}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"1111111111111111111111111");
    int   a=3 , b=4;
    int c = a+b-(b=a);
    NSLog(@"%d, %d", c, b);
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
