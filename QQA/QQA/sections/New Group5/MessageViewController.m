//
//  MessageViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/15.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"发送消息"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送范围" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    
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
    [sendButton setFrame:CGRectMake(  iphoneWidth - 110,  _messageTextView.frame.size.height + 84, 100, 30)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    sendButton.titleLabel.font = [UIFont systemFontOfSize:24];
//    sendButton.backgroundColor = [UIColor blueColor];
    
    sendButton.layer.borderColor = [UIColor blackColor].CGColor;
    sendButton.layer.borderWidth = 1;
    sendButton.layer.cornerRadius = 10;
    
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sends) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sendButton];
    
    
    
    
    
}

-(void)sends{
     [_messageTextView resignFirstResponder];
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
        
    }
    return YES;
    
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSLog(@"%@", textView.text);
    
    
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
