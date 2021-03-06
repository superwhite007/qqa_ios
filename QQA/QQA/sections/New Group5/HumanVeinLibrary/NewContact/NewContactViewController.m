//
//  NewContactViewController.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "NewContactViewController.h"
#import "HumanVeinLibraryVC.h"

@interface NewContactViewController ()

@property (nonatomic, strong) NSArray * nameArray;
@property (nonatomic, strong) NSMutableArray * nameTextFieldMArray;

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"_receivedStr:%@", _receivedStr);
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:_receivedStr];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(ensure)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((iphoneWidth - 100)/2, 10, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"new_contact"]];
    [self.view addSubview:imageView];
    _nameArray = @[@"姓名", @"描述", @"电话", @"邮件", @"QQ", @"微信"];
    _nameTextFieldMArray = [NSMutableArray arrayWithObjects:_nameTextField, _describeTextField, _telephoneTextField, _mailTextField, _QQTextField, _weixinTextField, nil];
    [self addNamesAndTextViews];
}

-(void)addNamesAndTextViews{
    if (_nameArray.count > 0) {
        for (int i = 0; i < _nameArray.count; i++) {
            UILabel * namesLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 120 + i * 35 ,iphoneWidth / 3 - 60, 30)];
//            namesLabel.backgroundColor = [UIColor redColor];
            namesLabel.textAlignment = NSTextAlignmentCenter;
            namesLabel.text = _nameArray[i];
//            namesLabel.textColor = [UIColor whiteColor];
            [self.view addSubview:namesLabel];
        }
    }

    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 0 * 35 ,iphoneWidth * 2 / 3 , 30)];
    _describeTextField = [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 1 * 35 ,iphoneWidth * 2 / 3 , 30)];
    _telephoneTextField= [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 2 * 35 ,iphoneWidth * 2 / 3 , 30)];
    _mailTextField = [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 3 * 35 ,iphoneWidth * 2 / 3 , 30)];
    _QQTextField = [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 4 * 35 ,iphoneWidth * 2 / 3 , 30)];
    _weixinTextField= [[UITextField alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 25, 120 + 5 * 35 ,iphoneWidth * 2 / 3 , 30)];
    [_nameTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    [_describeTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    [_telephoneTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    [_mailTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    [_QQTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    [_weixinTextField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
    
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _describeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _mailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _QQTextField.borderStyle = UITextBorderStyleRoundedRect;
    _weixinTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_nameTextField];
    [self.view addSubview:_describeTextField];
    [self.view addSubview:_telephoneTextField];
    [self.view addSubview:_mailTextField];
    [self.view addSubview:_QQTextField];
    [self.view addSubview:_weixinTextField];
    
   
    if (_reviceDic.count > 0) {
        _nameTextField.text = [_reviceDic objectForKey:@"name"];
        _describeTextField.text = [_reviceDic objectForKey:@"describe"];
        _telephoneTextField.text = [_reviceDic objectForKey:@"telephone"];
        _mailTextField.text = [_reviceDic objectForKey:@"email"];
        _QQTextField.text = [_reviceDic objectForKey:@"QQ"];
        _weixinTextField.text = [_reviceDic objectForKey:@"weiXin"];
    }
    
}

- (void)limit:(UITextField *)textField{
    //限制文本的输入长度不得大于10个字符长度
    if (textField.text.length >= 20){
        //截取文本字符长度为10的内容
        textField.text = [textField.text substringToIndex:20];
    }
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendNewContactToServer];
        return NO;
    }else if (range.location >= 20){
        [self alert:@"最多输入20字符"];
        return NO;
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self giveUpFirstReponcedWithBool:YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView{
//    NSLog(@"123456：%@\n", textView.text);
}

-(void)ensure{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [self giveUpFirstReponcedWithBool:YES];
//    NSLog(@"姓名：%@, 描述：%@, 电话：%@,邮件： %@,QQ ：%@,微信： %@", _nameTextField.text, _describeTextField.text, _telephoneTextField.text, _mailTextField.text, _QQTextField.text, _weixinTextField.text);
    
    if (_nameTextField.text.length > 0 && _telephoneTextField.text.length > 0) {
//        [self alert:@"OK"];
        [self sendNewContactToServer];
    }else if(_nameTextField.text.length == 0){
        [self alert:@"请输入名字"];
    }else if(_telephoneTextField.text.length == 0){
        [self alert:@"请输入电话"];
    }
}

-(void)sendNewContactToServer{
    NSString * str = [NSString new];
    if ([_receivedStr isEqualToString:@"新建联系人"]) {
        str = @"/v1/api/v2/connection/store";
    }else if ([_receivedStr isEqualToString:@"编辑联系人"]) {
        str = @"/v1/api/v2/connection/update";
    }
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, str]];
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
    [mdict setObject:_nameTextField.text forKey:@"name"];
    [mdict setObject:_describeTextField.text forKey:@"describe"];
    [mdict setObject:_telephoneTextField.text forKey:@"telephone"];
    [mdict setObject:_mailTextField.text forKey:@"email"];
    [mdict setObject:_QQTextField.text forKey:@"QQ"];
    [mdict setObject:_weixinTextField.text forKey:@"weiXin"];
    if ([_receivedStr isEqualToString:@"编辑联系人"]) {
        [mdict setObject:[_reviceDic objectForKey:@"connectionId"] forKey:@"connectionId"];
    }
    NSLog(@"99999999999:%@",mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];                                 NSLog(@"HUman：%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ( [[dataBack objectForKey:@"message"] intValue] == 40001) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{                                           [self alert:@"增加成功!"];                                                      });
                                                    } else if ( [[dataBack objectForKey:@"message"] intValue] == 40009) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{                                           [self alert:@"编辑成功!"];                                                      });
                                                    } else if ( [[dataBack objectForKey:@"message"] intValue] == 40002) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{                                           [self alert:@"发送失败"];                                                      });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSLog(@"HUman2是个数组：%@", dataBack);
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSLog(@"HUMan3获取数据失败，问gitPersonPermissions"); dispatch_async(dispatch_get_main_queue(), ^{                                           [self alert:@"失败"];                                                      });
                                                }
                                            }else{
                                                NSLog(@"HUMan5获取数据失败，问gitPersonPermissions"); dispatch_async(dispatch_get_main_queue(), ^{                                           [self alert:@"失败"];                                                      });
                                            }
                                        }];
    [task resume];
}



- (void)giveUpFirstReponcedWithBool:(BOOL)flag{
    [_nameTextField endEditing:flag];
    [_describeTextField endEditing:flag];
    [_telephoneTextField endEditing:flag];
    [_mailTextField endEditing:flag];
    [_QQTextField endEditing:flag];
    [_weixinTextField endEditing:flag];
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([title isEqualToString:@"编辑成功!"] || [title isEqualToString:@"增加成功!"]) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                NSLog(@"Class:%@", [controller class]);
                if ([controller isKindOfClass:[HumanVeinLibraryVC class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
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
