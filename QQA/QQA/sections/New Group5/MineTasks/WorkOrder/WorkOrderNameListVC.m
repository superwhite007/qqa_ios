//
//  WorkOrderNameListVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderNameListVC.h"
#import "OneOrderVC.h"
#import "WorkOrderTVCell.h"

#define kWORKORDERWIDTH  iphoneWidth - 20 //WORKORDERWIDTH
#define kWORKORDERORGINh  (iphoneHeight - iphoneWidth)/2   //iphoneHeight
#define kWORKORDERORGINHSPACE  (iphoneWidth - 20) / 20   //workOrderSpace

@interface WorkOrderNameListVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView * addOrEditWorkOrderView;
@property (nonatomic, strong) UILabel * workOrderTitle;
@property (nonatomic, strong) UITextField * workOrderTextField;
@property (nonatomic, strong) UIButton * workOrderNameAgreeBtn;
@property (nonatomic, strong) UIButton * workOrderNameRejectBtn;
@property (nonatomic, assign) BOOL agreeBTN;

@property (nonatomic, strong) UITableView * tableView;

@end
@implementation WorkOrderNameListVC

static  NSString  * identifier = @"CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    _addOrEditWorkOrderView = [UIView new];
    _workOrderTitle = [UILabel new];
    _workOrderTextField = [[UITextField alloc] init];
    _workOrderTextField.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"工单列表"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayaddOrEditWorkOrderView)];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[WorkOrderTVCell class] forCellReuseIdentifier:identifier];
    
    [self addNewOREditWorkOrderView];
}

-(void)addNewOREditWorkOrderView{
    _addOrEditWorkOrderView.frame = CGRectMake(10 + 2 * iphoneWidth, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
    _addOrEditWorkOrderView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_addOrEditWorkOrderView];
    
    _workOrderTitle.frame = CGRectMake(10, kWORKORDERORGINHSPACE, kWORKORDERWIDTH, kWORKORDERORGINHSPACE);
    _workOrderTitle.textAlignment = NSTextAlignmentCenter;
    _workOrderTitle.text = @"新建/编辑工单";
    [_addOrEditWorkOrderView addSubview:_workOrderTitle];
    
    NSArray * labelNameAboutTitleANDContent = @[@"工单标题",@"工单内容"];
    for (int i = 0; i < labelNameAboutTitleANDContent.count; i++) {
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (3 + i * 2)* kWORKORDERORGINHSPACE,100, kWORKORDERORGINHSPACE)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.text = labelNameAboutTitleANDContent[i];
        [_addOrEditWorkOrderView addSubview:nameLabel];
    }
    
    _workOrderTextField.frame = CGRectMake(100 , 3 * kWORKORDERORGINHSPACE - kWORKORDERORGINHSPACE / 2,  kWORKORDERWIDTH  - 120, kWORKORDERORGINHSPACE * 2);
    _workOrderTextField.backgroundColor = [UIColor whiteColor];
    _workOrderTextField.borderStyle = UITextBorderStyleLine;
    _workOrderTextField.adjustsFontSizeToFitWidth = YES;
    [_addOrEditWorkOrderView addSubview:_workOrderTextField];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [_addOrEditWorkOrderView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:tap];
    
    _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 6.5 * kWORKORDERORGINHSPACE,kWORKORDERWIDTH - 20, kWORKORDERORGINHSPACE * 10)];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    _messageTextView.delegate = self;
    [_addOrEditWorkOrderView addSubview:_messageTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

    _workOrderNameAgreeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _workOrderNameAgreeBtn.frame = CGRectMake(kWORKORDERWIDTH - 110, 17.5 * kWORKORDERORGINHSPACE,100, kWORKORDERORGINHSPACE * 2);
    _workOrderNameAgreeBtn.backgroundColor = [UIColor whiteColor];
    [_workOrderNameAgreeBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    _workOrderNameAgreeBtn.layer.borderWidth = 0.5;
    _workOrderNameAgreeBtn.tag = 60002;
    [_workOrderNameAgreeBtn addTarget:self action:@selector(selectAgreeORRejectONWorkOrderNameSendToServer:) forControlEvents:UIControlEventTouchUpInside];
    _agreeBTN = YES;
    _workOrderNameAgreeBtn.backgroundColor = [UIColor redColor];
    [_addOrEditWorkOrderView addSubview:_workOrderNameAgreeBtn];
    
    _workOrderNameRejectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _workOrderNameRejectBtn.frame = CGRectMake(kWORKORDERWIDTH - 220, 17.5 * kWORKORDERORGINHSPACE,100, kWORKORDERORGINHSPACE * 2);
    _workOrderNameRejectBtn.backgroundColor = [UIColor whiteColor];
    [_workOrderNameRejectBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    _workOrderNameRejectBtn.layer.borderWidth = 0.5;
    _workOrderNameRejectBtn.tag = 60001;
    [_workOrderNameRejectBtn addTarget:self action:@selector(selectAgreeORRejectONWorkOrderNameSendToServer:) forControlEvents:UIControlEventTouchUpInside];
    _workOrderNameRejectBtn.backgroundColor = [UIColor whiteColor];
    [_addOrEditWorkOrderView addSubview:_workOrderNameRejectBtn];
}

#pragma UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.workOrderTextField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (string.length == 0) {
            return YES;
        }else if (self.workOrderTextField.text.length >= 20) {
            [self alert:@"工单标题不能超过20个字符!"];
            self.workOrderTextField.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [textField resignFirstResponder];
    return YES;
}
- (void)reKeyBoard
{
    [_workOrderTextField resignFirstResponder];
    [_messageTextView resignFirstResponder];//textView
}
#pragma UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {//判断按的是不是return
        [_messageTextView resignFirstResponder];
        return NO;
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        self.messageTextView.text = [_messageTextView.text substringToIndex:200];
        return NO;
    }
    return YES;
}
#pragma keyboard
- (void)keyboardWillShow:(NSNotification *)notification{
    [self displayaddOrEditWorkOrderViewHeader];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    [self displayaddOrEditWorkOrderView];
}
-(void)displayaddOrEditWorkOrderViewHeader{
    _addOrEditWorkOrderView.frame = CGRectMake(10, 10, kWORKORDERWIDTH, kWORKORDERWIDTH);
}
-(void)displayaddOrEditWorkOrderView{
    _addOrEditWorkOrderView.frame = CGRectMake(10, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
}
-(void)undisplayaddOrEditWorkOrderView{
    [self reKeyBoard];
    _addOrEditWorkOrderView.frame = CGRectMake(10 + 2 * iphoneWidth, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
}

#pragma agreeANDreject button
-(void)selectAgreeORRejectONWorkOrderNameSendToServer:(UIButton*)sender{
    [self reKeyBoard];
    if (sender.tag == 60001) {
        _workOrderNameAgreeBtn.backgroundColor = [UIColor whiteColor];
        _workOrderNameRejectBtn.backgroundColor = [UIColor redColor];
        _agreeBTN = NO;
        [self alert:@"取消创建"];
    }else if (sender.tag == 60002) {
        _workOrderNameAgreeBtn.backgroundColor = [UIColor redColor];
        _workOrderNameRejectBtn.backgroundColor = [UIColor whiteColor];
        _agreeBTN = YES;
        if (_workOrderTextField.text.length > 0) {
            [self sendWorkOrderTitleToServer];//待开发
            [self alert:@"创建成功"];
        }else{
            [self alert:@"请输入工单名称"];
        }
    }
   
}

-(void)sendWorkOrderTitleToServer{
    //发往服务器
}


-(void)gotoOneOrderVC{
    
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
}

#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkOrderTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return  cell;
}




-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"]) {
            [self undisplayaddOrEditWorkOrderView];
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    [self undisplayaddOrEditWorkOrderView];
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
