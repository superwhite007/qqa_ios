//
//  NewContactViewController.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "NewContactViewController.h"

@interface NewContactViewController ()

@property (nonatomic, strong) NSArray * nameArray;
@property (nonatomic, strong) NSMutableArray * nameTextViewMArray;

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"新建联系人"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(ensure)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((iphoneWidth - 100)/2, 10, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"new_contact"]];
    [self.view addSubview:imageView];
    _nameArray = @[@"姓名", @"描述", @"电话", @"邮件", @"QQ", @"微信"];
    _nameTextViewMArray = [NSMutableArray arrayWithObjects:_nameTextView, _describeTextView, _telephoneTextView, _mailTextView, _QQTextView, _weixinTextView, nil];
    [self addNamesAndTextViews];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)addNamesAndTextViews{
    if (_nameArray.count > 0) {
        for (int i = 0; i < _nameArray.count; i++) {
            UILabel * namesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120 + i * 35 ,iphoneWidth / 3 - 40, 30)];
            namesLabel.backgroundColor = [UIColor redColor];
            namesLabel.textAlignment = NSTextAlignmentCenter;
            namesLabel.text = _nameArray[i];
            namesLabel.textColor = [UIColor whiteColor];
            [self.view addSubview:namesLabel];
            
            _nameTextViewMArray[i] = [[UITextView alloc] initWithFrame:CGRectMake(iphoneWidth / 3 - 20, 120 + i * 35 ,iphoneWidth * 2 / 3 - 40, 30)];
//            [_nameTextViewMArray[i] setFont:[UIFont systemFontOfSize:24]];
            [_nameTextViewMArray[i] setDelegate:self];
            [self.view addSubview:_nameTextViewMArray[i]];
        }
        
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
      
    }else if (range.location >= 200){
        
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"123456 %@,%@\n", textView,textView.text);
    
}


-(void)ensure{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [self cacellresignFirstResponder];
    
}
-(void)cacellresignFirstResponder{
    [_nameTextView resignFirstResponder];
    [_describeTextView resignFirstResponder];
    [_telephoneTextView resignFirstResponder];
    [_mailTextView resignFirstResponder];
    [_QQTextView resignFirstResponder];
    [_weixinTextView resignFirstResponder];

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
