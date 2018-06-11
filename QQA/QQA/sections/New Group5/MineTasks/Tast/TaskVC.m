//
//  TaskVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/6.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "TaskVC.h"

@interface TaskVC ()

@property (nonatomic, strong) UIView * taskNewView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;

@end

@implementation TaskVC

static NSString  *  identifier = @"CELL";

-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"_mineOrOthersStr:%@", _mineOrOthersStr);
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:_mineOrOthersStr];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight -64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addNewTaskNameView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newTask)];
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.datasourceMArray addObject:@"test1"];
    [self.datasourceMArray addObject:@"test2"];
    [self.datasourceMArray addObject:@"test3"];
    [self.datasourceMArray addObject:@"test4"];
    [self.datasourceMArray addObject:@"test5"];
    [self.datasourceMArray addObject:@"test6"];
    
   
    
    // Do any additional setup after loading the view.
}

#pragma  datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.datasourceMArray[indexPath.row];
    return cell;
}


-(void)addNewTaskNameView{
    _taskNewView = [[UIView alloc] initWithFrame:CGRectMake(30 + iphoneWidth, 20, iphoneWidth - 60, 160)];
    _taskNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_taskNewView];
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 20, iphoneWidth - 80, 70)];
    _messageTextView.font = [UIFont systemFontOfSize:24];
//    _messageTextView.backgroundColor = [UIColor greenColor];
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _messageTextView.attributedText = [[NSAttributedString alloc] initWithString:@"请输入任务名称。不超过30个字符。" attributes:attributes];
//    _messageTextView.text = @"请输入任务名称。不超过30个字符。";
    _messageTextView.delegate = self;
    [_taskNewView addSubview:_messageTextView];
    
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(10, 95, (iphoneWidth - 90) /2, 60);
    [agreeButton setTitle:@"确定" forState:(UIControlStateNormal)];
    
    agreeButton.tag = 10001;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:agreeButton];
    
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(10 + (iphoneWidth - 90) /2 + 10, 95, (iphoneWidth - 90) /2 , 60);
    [refuseButton setTitle:@"取消" forState:(UIControlStateNormal)];
    agreeButton.tag = 10002;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:refuseButton];

}

-(void)sendNewTaskToServer:(UIButton*)sender{
    NSLog(@"sender:%@", sender);
    if (sender.tag == 10001) {
        
    }else if (sender.tag == 10002) {
        
    }
    [self removeNewTaskView];
}

#pragma UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = nil;
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }else if (range.location >= 30){
        [self alert:@"最多输入30字符"];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textview:%@", textView.text);
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;


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




-(void)newTask{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
    _taskNewView.frame = CGRectMake(0 , 0, iphoneWidth, 160);
    
}
-(void)removeNewTaskView{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
    NSLog(@"_messageTextView.text::%@",_messageTextView.text );
    _taskNewView.frame = CGRectMake(30 + iphoneWidth , 20, iphoneWidth - 60, 160);
    _messageTextView.text = nil;
    
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
