//
//  WorkOrderNameLIstsViewController.m
//  QQA
//
//  Created by wang huiming on 2018/8/9.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderNameLIstsViewController.h"
#import "OneOrderVC.h"
#import "WorkOrderTVCell.h"
#import "WorkOrder.h"
//#import "UILabel+HeightBYLabel.h"

#define kWORKORDERWIDTH  iphoneWidth - 20 //WORKORDERWIDTH
#define kWORKORDERORGINh  (iphoneHeight - iphoneWidth)/2   //iphoneHeight
#define kWORKORDERORGINHSPACE  (iphoneWidth - 20) / 20   //workOrderSpace


@interface WorkOrderNameLIstsViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * addOrEditWorkOrderView;
@property (nonatomic, strong) UILabel * workOrderTitle;
@property (nonatomic, strong) UITextField * workOrderTextField;
@property (nonatomic, strong) UIButton * workOrderNameAgreeBtn;
@property (nonatomic, strong) UIButton * workOrderNameRejectBtn;
@property (nonatomic, assign) BOOL agreeBTN;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;
@property (nonatomic, strong) NSMutableString * workListId;

@end
@implementation WorkOrderNameLIstsViewController

static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"工单列表"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayaddNewOrEditWorkOrderView)];
    
    _addOrEditWorkOrderView = [UIView new];
    _workOrderTitle = [UILabel new];
    _workOrderTextField = [[UITextField alloc] init];
    _workOrderTextField.delegate = self;
    _workListId = [NSMutableString new];
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[WorkOrderTVCell class] forCellReuseIdentifier:identifier];
    [self getWorkOrderListFromServer:1];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self addNewOREditWorkOrderView];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [_tableView addGestureRecognizer:lpgr]; //启用长按事件
    
}
#pragma shoushi
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:_tableView ];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
        if (indexPath == nil){
            NSLog(@"LongPress");
        }else{
            WorkOrder * workOrder = self.datasourceMArray[indexPath.row];
            if ([workOrder.isEdit intValue] == 1 ) {
                _workOrderTitle.text = @"编辑工单";
                _workOrderTextField.text = workOrder.title;
                _messageTextView.text = workOrder.content;
                _workListId = [NSMutableString stringWithFormat:@"%@", workOrder.workListId];
                [self displayaddOrEditWorkOrderView];
            }
        }
    }
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
    [_messageTextView resignFirstResponder];
}

#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkOrderTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    WorkOrder * workOrder = self.datasourceMArray[indexPath.row];
    cell.workOrder = workOrder;
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkOrder * stepDetailCommunication = self.datasourceMArray[indexPath.row];
    UILabel * label = [UILabel new];
    label.text = stepDetailCommunication.content;
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = 0;//表示label可以多行显示
    label.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake((iphoneWidth - 20) * 3 / 4, 2000);
    CGRect targetRect = [label.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
    label.frame = CGRectMake(100, 5, iphoneWidth - 110, CGRectGetHeight(targetRect));
    if (CGRectGetHeight(targetRect) < 40) {
        return 100;
    }else{
        return CGRectGetHeight(targetRect) + 60;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkOrder * workOrder = self.datasourceMArray[indexPath.row];
    if ([workOrder.isEdit intValue] == 1 ) {
        _workListId = [NSMutableString stringWithFormat:@"%@", workOrder.workListId];
    }
    //需要后续开发,补充数据
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    oneOrderVC.workListIdStr = _workListId;
    oneOrderVC.isEdit = [NSMutableString stringWithFormat:@"%@", workOrder.isEdit];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
}
#pragma getDataFServer
-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self getWorkOrderListFromServer:--self.pageNum];
    } else{
        [self getWorkOrderListFromServer:1];
    }
    [self.tableView.mj_header endRefreshing];
}

-(void)loadMoreData{
    self.isDownRefresh = NO;
    [self getWorkOrderListFromServer:++self.pageNum];
    [self.tableView.mj_footer endRefreshing];
}

-(void)getWorkOrderListFromServer:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workList/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70001) {
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            WorkOrder * workOrder = [WorkOrder new];
                                                            [workOrder setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:workOrder];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    [self alert:@"获取失败"];
                                                }
                                            }else{
                                                [self alert:@"获取失败"];
                                            }
                                        }];
    [task resume];
}

-(void)addNewOREditWorkOrderView{
    _addOrEditWorkOrderView.frame = CGRectMake(10 + 2 * iphoneWidth, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
    _addOrEditWorkOrderView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_addOrEditWorkOrderView];
    
    _workOrderTitle.frame = CGRectMake(10, kWORKORDERORGINHSPACE, kWORKORDERWIDTH, kWORKORDERORGINHSPACE);
    _workOrderTitle.textAlignment = NSTextAlignmentCenter;
    _workOrderTitle.text = @"新建工单";
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
            if ([_workOrderTitle.text isEqualToString:@"新建工单"]) {
                [self sendWorkOrderTitleToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workList/create", CONST_SERVER_ADDRESS] workListId:[NSMutableString stringWithFormat:@"无"]];
            }else if ([_workOrderTitle.text isEqualToString:@"编辑工单"]) {
                [self sendWorkOrderTitleToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workList/update", CONST_SERVER_ADDRESS] workListId:_workListId];
            }
        }else{
            [self alert:@"请输入工单名称"];
        }
    }
}

-(void)sendWorkOrderTitleToServer:(NSString *)urlStr workListId:(NSMutableString *)workListId{
    NSURL * url = [NSURL URLWithString:urlStr];
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
    [mdict setObject:_workOrderTextField.text forKey:@"title"];
    [mdict setObject:_messageTextView.text forKey:@"content"];
    if ([_workOrderTitle.text isEqualToString:@"编辑工单"]){
        [mdict setObject:workListId forKey:@"workListId"];
    }
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70003 || [[dataBack objectForKey:@"message"] intValue] == 70005) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"发送成功"];
                                                        });
                                                    }else{
                                                        [self alert:@"工单失败"];
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    [self alert:@"工单失败"];
                                                }
                                            }else{
                                                [self alert:@"工单失败"];
                                            }
                                        }];
    [task resume];
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
-(void)displayaddNewOrEditWorkOrderView{
    _workOrderTitle.text = @"新建工单";
    _workOrderTextField.text = @"";
    _messageTextView.text = @"";
    _workOrderNameAgreeBtn.backgroundColor = [UIColor redColor];
    _workOrderNameRejectBtn.backgroundColor = [UIColor whiteColor];
    _agreeBTN = YES;
    _addOrEditWorkOrderView.frame = CGRectMake(10, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
}
-(void)undisplayaddOrEditWorkOrderView{
    [self reKeyBoard];
    _addOrEditWorkOrderView.frame = CGRectMake(10 + 2 * iphoneWidth, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
            [self undisplayaddOrEditWorkOrderView];
            if ([str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
                [self getWorkOrderListFromServer:_pageNum];
            }
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
