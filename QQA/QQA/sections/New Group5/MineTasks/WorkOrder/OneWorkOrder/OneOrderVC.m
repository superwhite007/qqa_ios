//
//  OneOrderVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderVC.h"
#import "OneOrder.h"
#import "OneOrderCell.h"
#import "OneOrderCommunicationVController.h"
#import "UIButton+WebCache.h"

#import "MenuAlertViewController.h"
#import "CenterView.h"

#define kHEADERBTNSPACE  (iphoneWidth - 320) / 5 //button间隙
#define kORDERDETAILWIDTH  iphoneWidth - 20 //WORKORDERWIDTH
#define kORDERDETAILHEIGHT  (iphoneHeight - iphoneWidth)/2   //iphoneHeight
#define kNEWSPACE  (iphoneWidth - 20) / 20   //workOrderSpace

@interface OneOrderVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataOfHeaderOfTheDepartment;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;
@property (nonatomic, strong) NSMutableArray * leadersMArray;

@property (nonatomic, strong) UIView * orderDetailView;
@property (nonatomic, strong) UILabel * orderDetailTitle;
@property (nonatomic, strong) UIButton * orderDetailAgreeBtn;
@property (nonatomic, strong) UIButton * orderDetailRejectBtn;
@property (nonatomic, assign) BOOL agreeButton;
@property (nonatomic, strong) NSString * workListDetailIdStr;
@property (nonatomic, strong) NSMutableArray * departmentsDatasource;
@property (nonatomic, strong) UIView * changeDetailNameOrCompleteView;
@property (nonatomic, strong) NSString * longPressStr;
@end
@implementation OneOrderVC
static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}
-(NSMutableArray *)leadersMArray{
    if (!_leadersMArray) {
        _leadersMArray = [NSMutableArray new];
    }
    return _leadersMArray;
}
-(NSMutableArray *)departmentsDatasource{
    if (!_departmentsDatasource) {
        _departmentsDatasource = [NSMutableArray array];
    }
    return _departmentsDatasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _dataOfHeaderOfTheDepartment = [NSMutableArray array];
    [self.navigationItem  setTitle:@"工单详情"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayaddNewOrderView)];

    self.pageNum = 1;
    self.isDownRefresh = NO;
    _agreeButton = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneOrderCell class] forCellReuseIdentifier:identifier];
    [self getWorkOrderListFromServer:1];

    [self addNewOrderDetailViews];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [_tableView addGestureRecognizer:lpgr]; //启用长按事件
    
    [self addChangeDetailCompleteStepView];
}

#pragma shoushi
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:_tableView ];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
        if (indexPath == nil){
            //NSLog(@"LongPress");
        }else{
            _longPressStr = [NSString stringWithFormat:@"%ld", indexPath.row];
            [self displayChangeNameDeleteCompleteStepView];
        }
    }
}

#pragma changeNameDeleteCompleteStep
-(void)addChangeDetailCompleteStepView{
    _changeDetailNameOrCompleteView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth / 6  + 5 * iphoneWidth, iphoneWidth / 5, iphoneWidth * 2 / 3 + 20, iphoneWidth * 3 / 9 )];
    _changeDetailNameOrCompleteView.layer.borderWidth = 1;
    _changeDetailNameOrCompleteView.layer.cornerRadius = 5;
    _changeDetailNameOrCompleteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_changeDetailNameOrCompleteView];
    NSMutableArray * ary = [NSMutableArray arrayWithObjects:@"编辑工单内容",  @"标记该步骤(完成/未完成)", nil];
    for (int i = 0; i < ary.count; i++) {
        UIButton * changeNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        changeNameButton.frame = CGRectMake(15 , 5 + i * ((iphoneWidth * 4 / 9 - 20 ) / 3 + 5 ) , iphoneWidth * 2 / 3 - 10, (iphoneWidth * 4 / 9 - 20 ) / 3);
        changeNameButton.titleLabel.textColor = [UIColor blackColor];
        changeNameButton.layer.borderWidth = 0.5;
        changeNameButton.layer.cornerRadius = 4;
        changeNameButton.tag = 100000 + i;
        [changeNameButton setTitle:ary[i] forState:UIControlStateNormal];
        [changeNameButton addTarget:self action:@selector(changeNameDeleteCompleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [_changeDetailNameOrCompleteView addSubview:changeNameButton];
    }
}
-(void)displayChangeNameDeleteCompleteStepView{
    _changeDetailNameOrCompleteView.frame = CGRectMake(iphoneWidth / 6 , iphoneWidth / 5, iphoneWidth * 2 / 3 + 20, iphoneWidth * 3 / 9 );
}
-(void)undisplayChangeNameDeleteCompleteStepView{
    _changeDetailNameOrCompleteView.frame = CGRectMake(iphoneWidth / 6  +  iphoneWidth * 5, iphoneWidth / 5, iphoneWidth * 2 / 3 + 20, iphoneWidth * 3 / 9 );
}
-(void)changeNameDeleteCompleteButton:(UIButton *)button{
    [self undisplayChangeNameDeleteCompleteStepView];
    switch (button.tag) {
        case 100000:
            [self changeDetail];
            break;
        case 100001:
            [self changeComplete];
            break;
        default:
            break;
    }
}
-(void)changeDetail{
    OneOrder * onekOrder = self.datasourceMArray[[_longPressStr intValue]];
    if ([onekOrder.isUpdateStatus intValue] == 1 ) {
        _orderDetailTitle.text = @"编辑工单内容";
        _messageOneOrederTextView.text = onekOrder.content;
        _workListDetailIdStr = [NSMutableString stringWithFormat:@"%@", onekOrder.workListDetailId];
        [self displayaddOrEditWorkOrderView];
    }
}
-(void)changeComplete{
    
    OneOrder * onekOrder = self.datasourceMArray[[_longPressStr intValue]];
    if ([onekOrder.isUpdateStatus intValue] == 1 ) {
        _workListDetailIdStr = [NSMutableString stringWithFormat:@"%@", onekOrder.workListDetailId];
        if ([onekOrder.isFinished intValue] == 1 ) {
            [self changeStepAfterUrl:@"/v1/api/v2/workListDetail/status/update" isFinished:@"F"];
        }else if ([onekOrder.isFinished intValue] == 0 ) {
            [self changeStepAfterUrl:@"/v1/api/v2/workListDetail/status/update" isFinished:@"T"];
        }
    }
}

-(void)changeStepAfterUrl:(NSString *)afterUrlStr isFinished:(NSString *)isFinished{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, afterUrlStr]];
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
    [mdict setObject:isFinished forKey:@"isFinished"];
    [mdict setObject:_workListDetailIdStr forKey:@"workListDetailId"];
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    //NSLog(@"更新完成1111:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"100000000000000:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70018) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"标记成功！"];
                                                        });
                                                    }else{
                                                       //NSLog(@"标记失败");
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    //NSLog(@"标记失败");
                                                }
                                            }else{
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self alert:@"标记失败"];
                                                });
                                            }
                                        }];
    [task resume];
}

#pragma changeNameDeleteCompleteStep  end



-(void)addNewOrderDetailViews{
    
    _orderDetailView = [[UIView alloc] initWithFrame:CGRectMake(10 + 3 * iphoneWidth, kORDERDETAILHEIGHT, kORDERDETAILWIDTH, kORDERDETAILWIDTH)];
    _orderDetailView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_orderDetailView];
    
    _orderDetailTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, kNEWSPACE, iphoneWidth - 40, 2 * kNEWSPACE)];
    _orderDetailTitle.text = @"新建工单内容";
    _orderDetailTitle.textAlignment = NSTextAlignmentCenter;
    [_orderDetailView addSubview:_orderDetailTitle];
    
    UILabel * describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4 * kNEWSPACE, iphoneWidth - 40,  kNEWSPACE)];
    describeLabel.text = @"交流内容";
    [_orderDetailView addSubview:describeLabel];
    
    _messageOneOrederTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5.5 * kNEWSPACE,kORDERDETAILWIDTH - 20, kNEWSPACE * 11)];
    _messageOneOrederTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageOneOrederTextView];
    _messageOneOrederTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageOneOrederTextView.layer.borderWidth = 1;
    _messageOneOrederTextView.layer.cornerRadius = 10;
    _messageOneOrederTextView.returnKeyType = UIReturnKeySend;
    _messageOneOrederTextView.delegate = self;
    [_orderDetailView addSubview:_messageOneOrederTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _orderDetailAgreeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _orderDetailAgreeBtn.frame = CGRectMake(kORDERDETAILWIDTH - 110, 17.5 * kNEWSPACE,100, kNEWSPACE * 2);
    _orderDetailAgreeBtn.backgroundColor = [UIColor whiteColor];
    [_orderDetailAgreeBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    _orderDetailAgreeBtn.layer.borderWidth = 0.5;
    _orderDetailAgreeBtn.tag = 70702;
    [_orderDetailAgreeBtn addTarget:self action:@selector(selectAgreeORRejectSendToServer:) forControlEvents:UIControlEventTouchUpInside];
    _agreeButton = YES;
    _orderDetailAgreeBtn.backgroundColor = [UIColor redColor];
    [_orderDetailView addSubview:_orderDetailAgreeBtn];
    
    _orderDetailRejectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _orderDetailRejectBtn.frame = CGRectMake(kORDERDETAILWIDTH - 220, 17.5 * kNEWSPACE,100, kNEWSPACE * 2);
    _orderDetailRejectBtn.backgroundColor = [UIColor whiteColor];
    [_orderDetailRejectBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    _orderDetailRejectBtn.layer.borderWidth = 0.5;
    _orderDetailRejectBtn.tag = 70701;
    [_orderDetailRejectBtn addTarget:self action:@selector(selectAgreeORRejectSendToServer:) forControlEvents:UIControlEventTouchUpInside];
    _orderDetailRejectBtn.backgroundColor = [UIColor whiteColor];
    [_orderDetailView addSubview:_orderDetailRejectBtn];
    
}

#pragma agreeANDreject button
-(void)selectAgreeORRejectSendToServer:(UIButton*)sender{
    [self reKeyBoard];
    if (sender.tag == 70701) {
        _orderDetailAgreeBtn.backgroundColor = [UIColor whiteColor];
        _orderDetailRejectBtn.backgroundColor = [UIColor redColor];
        _agreeButton = NO;
        [self alert:@"取消创建"];
    }else if (sender.tag == 70702) {
        _orderDetailAgreeBtn.backgroundColor = [UIColor redColor];
        _orderDetailRejectBtn.backgroundColor = [UIColor whiteColor];
        _agreeButton = YES;
        if (_messageOneOrederTextView.text.length > 0) {
            if ([_orderDetailTitle.text isEqualToString:@"新建工单内容"]) {
                [self sendOrderDetailToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/add", CONST_SERVER_ADDRESS]];
            }else if ([_orderDetailTitle.text isEqualToString:@"编辑工单内容"]) {
                [self sendOrderDetailToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/content/update", CONST_SERVER_ADDRESS]];
            }
        }else{
            [self alert:@"请输入工单内容"];
        }
    }
}

-(void)sendOrderDetailToServer:(NSString *)urlStr{
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
    [mdict setObject:_messageOneOrederTextView.text forKey:@"content"];
    if ([_orderDetailTitle.text isEqualToString:@"新建工单内容"]){
        [mdict setObject:_workListIdStr forKey:@"workListId"];
    }else if([_orderDetailTitle.text isEqualToString:@"编辑工单内容"]){
        [mdict setObject:_workListDetailIdStr forKey:@"workListDetailId"];
    }
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"dataBack1:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70009) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"发送成功"];
                                                        });
                                                    }else if ([[dataBack objectForKey:@"message"] intValue] == 70017) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"编辑工单内容成功！"];
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





#pragma UITextViewDelegate
- (void)reKeyBoard
{
    [_messageOneOrederTextView resignFirstResponder];
}
#pragma keyboard
- (void)keyboardWillShow:(NSNotification *)notification{
    [self displayaddOrEditWorkOrderViewHeader];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    [self displayaddOrEditWorkOrderView];
}
-(void)displayaddOrEditWorkOrderViewHeader{
    _orderDetailView.frame = CGRectMake(10 , 10, kORDERDETAILWIDTH, kORDERDETAILWIDTH);
}
-(void)displayaddOrEditWorkOrderView{
    _orderDetailView.frame = CGRectMake(10 , kORDERDETAILHEIGHT, kORDERDETAILWIDTH, kORDERDETAILWIDTH);
}
-(void)displayaddNewOrderView{
    _orderDetailTitle.text = @"新建工单内容";
    _messageOneOrederTextView.text = @"";
    _orderDetailAgreeBtn.backgroundColor = [UIColor redColor];
    _orderDetailRejectBtn.backgroundColor = [UIColor whiteColor];
    _agreeButton = YES;
    _orderDetailView.frame = CGRectMake(10 , kORDERDETAILHEIGHT, kORDERDETAILWIDTH, kORDERDETAILWIDTH);
}
-(void)undisplayaddOrEditWorkOrderView{
    [self reKeyBoard];
    _orderDetailView.frame = CGRectMake(10 + 3 * iphoneWidth, kORDERDETAILHEIGHT, kORDERDETAILWIDTH, kORDERDETAILWIDTH);
}


-(void)getWorkOrderListFromServer:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSArray * dataListArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"workListDetails"];
                                                        //NSLog(@"dataBack:oneOrder:dataListArray::::%@", dataListArray);
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneOrder * oneOrder = [OneOrder new];
                                                            [oneOrder setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:oneOrder];
                                                        }
                                                        //NSLog(@"self.datasourceMArray:%@", self.datasourceMArray);
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


#pragma UItableDasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OneOrder * oneOrder = self.datasourceMArray[indexPath.row];
    cell.oneOrder = oneOrder;
    cell.selectPeopleButton.tag = 22000+ indexPath.row;
    [cell.selectPeopleButton addTarget:self action:@selector(cellButton:) forControlEvents:UIControlEventTouchUpInside];
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

#pragma cellButton---selectExecutor
-(void)cellButton:(UIButton *)sender{
    NSInteger numder = sender.tag % 1000;
    OneOrder * oneOrder = self.datasourceMArray[numder];
    _workListDetailIdStr = oneOrder.workListDetailId;
    if ([oneOrder.isAddExecutor intValue] == 1) {
        [self getMembersOfDepartment];
    }
}
-(void)getMembersOfDepartment{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/getMembersOfDepartment", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"Members:::%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 700012) {
                                                        NSMutableArray * MembersOfDepartmentMArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
//                                                        //NSLog(@"MembersOfDepartmentMArray:%@", MembersOfDepartmentMArray);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self menuAlertViewControllerMembersOfDepartmentsAboutSelectExecutor:MembersOfDepartmentMArray];
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

-(void)menuAlertViewControllerMembersOfDepartmentsAboutSelectExecutor:(NSMutableArray *)mArray{
    
    NSMutableArray * nameAndleaderJob = [NSMutableArray array];
    NSMutableArray * departmentName = [NSMutableArray array];
    for (int i = 0; i < mArray.count; i++) {
        NSString * str  = [NSString stringWithFormat:@"%@-%@",[mArray[i] objectForKey:@"username"],[mArray[i] objectForKey:@"memberJob"]];
        [nameAndleaderJob addObject:str];
        [departmentName addObject:[mArray[i] objectForKey:@"departmentName"]];
    }
    NSArray * nameAndleaderJobArray = nameAndleaderJob;
    NSArray * departmentNameArray = departmentName;
    //NSLog(@":::::::%@,%@", nameAndleaderJobArray, departmentNameArray);
    MenuAlertViewController *vc = [[MenuAlertViewController alloc]initWithTitleItems:nameAndleaderJobArray detailsItems:departmentNameArray selectImage:@"select_normal" normalImage:@"select_not"];
    
    vc.leftBtnTitle = @"取消";
    //    if (title.length == 0) {
    vc.title = @"选择执行人";
    //    }else{
    //        vc.title = title;
    //    }
    vc.leftTitleColor = [UIColor redColor];
    vc.btnFont = 20;
    vc.leftBtnBgColor = [UIColor grayColor];
    vc.titleFont = 17;
    vc.titleColor = [UIColor redColor];
    vc.confirmSelectRowBlock = ^(NSInteger index) {
        //NSLog(@"111111111111index: %zd", index);
        [self sendExecutorToserverMemberId:[mArray[index] objectForKey:@"memberId"] departmentId:[mArray[index] objectForKey:@"departmentId"]];
    };
    [self presentViewController:vc animated:false completion:nil];
}

-(void)sendExecutorToserverMemberId:(NSString *)memberId departmentId:(NSString *)departmentId{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/add/executor", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    [mdict setObject:memberId forKey:@"memberId"];
    [mdict setObject:departmentId forKey:@"departmentId"];
    [mdict setObject:_workListDetailIdStr forKey:@"workListDetailId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"executor:::%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70013) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"选择执行人成功！"];
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


#pragma  viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, 120)];
    _headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_headerView];
    [self getSelectedLeadersFromServer];
    return _headerView;
}
-(void)getSelectedLeadersFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSMutableArray * leaderMArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"leaders"];
                                                        NSMutableArray * departmentsMArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"departments"];
                                                        //NSLog(@"self.datasourceMArrayleader:%@", self.datasourceMArray);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self addLeadersViews:leaderMArray];
                                                            [self Valuedepartments:departmentsMArray];
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

-(void)Valuedepartments:(NSMutableArray *)mArray{
    _departmentsDatasource = mArray;
}

-(void)addLeadersViews:(NSMutableArray *)mAry{
    _dataOfHeaderOfTheDepartment = mAry;
    for (int i = 0; i < _dataOfHeaderOfTheDepartment.count; i++) {
        UIButton * headerOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        headerOfDepartmentBtn.frame = CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 5, 80, 80);
        headerOfDepartmentBtn.backgroundColor = [UIColor redColor];
        headerOfDepartmentBtn.layer.cornerRadius = headerOfDepartmentBtn.frame.size.width / 2;
        headerOfDepartmentBtn.layer.masksToBounds = YES;
        
        NSString * urlStr = [NSString stringWithFormat:@"%@", [_dataOfHeaderOfTheDepartment[0] objectForKey:@"img"]];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        [headerOfDepartmentBtn setBackgroundImage:image forState:UIControlStateNormal];
        headerOfDepartmentBtn.tag = 50000 + i;
        [headerOfDepartmentBtn addTarget:self action:@selector(viewOrIncrease:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:headerOfDepartmentBtn];
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((i + 1) * kHEADERBTNSPACE + i * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = [_dataOfHeaderOfTheDepartment[i] objectForKey:@"status"];
        [_headerView addSubview:nameLabel];
    }
    if(_dataOfHeaderOfTheDepartment.count < 4){
        UIButton * addNewHeaderOfDepartmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addNewHeaderOfDepartmentBtn.frame = CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 5, 80, 80);
        addNewHeaderOfDepartmentBtn.backgroundColor = [UIColor greenColor];
        addNewHeaderOfDepartmentBtn.layer.cornerRadius = addNewHeaderOfDepartmentBtn.frame.size.width / 2;
        addNewHeaderOfDepartmentBtn.layer.masksToBounds = YES;
        addNewHeaderOfDepartmentBtn.tag = 51001;
        [addNewHeaderOfDepartmentBtn addTarget:self action:@selector(viewOrIncrease:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:addNewHeaderOfDepartmentBtn];
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((_dataOfHeaderOfTheDepartment.count + 1) * kHEADERBTNSPACE + _dataOfHeaderOfTheDepartment.count * 80, 90, 80, 25)];
        nameLabel.backgroundColor = [UIColor redColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.text = @"添加部门负责人";
        [_headerView addSubview:nameLabel];
    }
}
-(void)viewOrIncrease:(UIButton *)sender{
    switch (sender.tag) {
        case 50000:
            //NSLog(@"%ld", (long)sender.tag);
            break;
        case 50001:
            //NSLog(@"%ld", (long)sender.tag);
            break;
        case 50002:
            //NSLog(@"%ld", (long)sender.tag);
            break;
        case 50003:
            //NSLog(@"%ld", (long)sender.tag);
            break;
        case 51001:
            //NSLog(@"%ld", (long)sender.tag);
            if ([_isEdit intValue] == 0) {
                [self alert:@"暂无增加责任人的权限"];
            }else{
                [self menuAlertViewControllerTitle:@"增加负责人"];
            }
            break;
        default:
            break;
    }
}


-(void)menuAlertViewControllerTitle:(NSString *)title{
    
    NSMutableArray * nameAndleaderJob = [NSMutableArray array];
    NSMutableArray * departmentName = [NSMutableArray array];
    for (int i = 0; i < _departmentsDatasource.count; i++) {
        NSString * str  = [NSString stringWithFormat:@"%@-%@",[_departmentsDatasource[i] objectForKey:@"leaderName"],[_departmentsDatasource[i] objectForKey:@"leaderJob"]];
        [nameAndleaderJob addObject:str];
        [departmentName addObject:[_departmentsDatasource[i] objectForKey:@"departmentName"]];
    }
    NSArray * nameAndleaderJobArray = nameAndleaderJob;
    NSArray * departmentNameArray = departmentName;
    //NSLog(@":::::::%@,%@", nameAndleaderJobArray, departmentNameArray);
    MenuAlertViewController *vc = [[MenuAlertViewController alloc]initWithTitleItems:nameAndleaderJobArray detailsItems:departmentNameArray selectImage:@"select_normal" normalImage:@"select_not"];

//    MenuAlertViewController *vc = [[MenuAlertViewController alloc]initWithTitleItems:@[@"技术魏总监", @"技术魏总监" ,@"技术魏总监",@"技术魏总监",@"技术魏总监",@"技术魏总监"] detailsItems:@[@"2017-10-10", @"2019-10-10"] selectImage:@"select_normal" normalImage:@"select_not"];
    vc.leftBtnTitle = @"取消";
//    if (title.length == 0) {
        vc.title = @"选择执行人";
//    }else{
//        vc.title = title;
//    }
    vc.leftTitleColor = [UIColor redColor];
    vc.btnFont = 20;
    vc.leftBtnBgColor = [UIColor grayColor];
    vc.titleFont = 17;
    vc.titleColor = [UIColor redColor];
    //    vc.rowTitleFont = 17;
    //    vc.rowDetailFont = 12;
    //    vc.rowTitleColor = [UIColor redColor];
    //    vc.rowDetailColor = [UIColor redColor];
    
    vc.confirmSelectRowBlock = ^(NSInteger index) {
        //NSLog(@"index: %zd", index);
        [self sendSelectedLeadersToServer:index];
    };
    [self presentViewController:vc animated:false completion:nil];
}

-(void)sendSelectedLeadersToServer:(NSInteger)index{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workList/add/leader", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdStr forKey:@"workListId"];
    [mdict setObject:[_departmentsDatasource[index] objectForKey:@"departmentId"] forKey:@"departmentId"];
    [mdict setObject:[_departmentsDatasource[index] objectForKey:@"leaderId"] forKey:@"leaderId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                //NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70007) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                           [self alert:@"增加负责人成功!"];
                                                           [self getSelectedLeadersFromServer];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OneOrderCommunicationVController * oneOrderCommunicationVController = [OneOrderCommunicationVController new];
    [self.navigationController pushViewController:oneOrderCommunicationVController animated:YES];
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]||[str isEqualToString:@"选择执行人成功！"]  ||[str isEqualToString:@"编辑工单内容成功！"] ) {
            [self undisplayaddOrEditWorkOrderView];
            if ([str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"] ||[str isEqualToString:@"选择执行人成功！"] ||[str isEqualToString:@"编辑工单内容成功！"]) {
                [self getWorkOrderListFromServer:1];
            }
        }
        if ([str isEqualToString:@"标记成功！"]){
            [self getWorkOrderListFromServer:1];
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
