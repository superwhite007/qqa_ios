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

@interface OneOrderVC ()
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
}

-(void)addNewOrderDetailViews{
    
    _orderDetailView = [[UIView alloc] initWithFrame:CGRectMake(10 + 3 * iphoneWidth, kORDERDETAILHEIGHT, kORDERDETAILWIDTH, kORDERDETAILWIDTH)];
    _orderDetailView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_orderDetailView];
    
    _orderDetailTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, kNEWSPACE, iphoneWidth - 40, 2 * kNEWSPACE)];
    _orderDetailTitle.text = @"新建工单详情";
    _orderDetailTitle.textAlignment = NSTextAlignmentCenter;
    [_orderDetailView addSubview:_orderDetailTitle];
    
    UILabel * describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4 * kNEWSPACE, iphoneWidth - 40,  kNEWSPACE)];
    describeLabel.text = @"交流内容";
    [_orderDetailView addSubview:describeLabel];
    
    _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5.5 * kNEWSPACE,kORDERDETAILWIDTH - 20, kNEWSPACE * 11)];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_messageTextView];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    _messageTextView.delegate = self;
    [_orderDetailView addSubview:_messageTextView];
    
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
        if (_messageTextView.text.length > 0) {
//            if ([_workOrderTitle.text isEqualToString:@"新建工单"]) {
//                [self sendWorkOrderTitleToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workList/create", CONST_SERVER_ADDRESS] workListId:[NSMutableString stringWithFormat:@"无"]];
//            }else if ([_workOrderTitle.text isEqualToString:@"编辑工单"]) {
//                [self sendWorkOrderTitleToServer:[NSString stringWithFormat:@"%@/v1/api/v2/workList/update", CONST_SERVER_ADDRESS] workListId:_workListId];
//            }
        }else{
            [self alert:@"请输入工单内容"];
        }
    }
}

#pragma UITextViewDelegate
- (void)reKeyBoard
{
    [_messageTextView resignFirstResponder];
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
    _orderDetailTitle.text = @"新建工单";
    _messageTextView.text = @"";
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
                                                NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSArray * dataListArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"workListDetails"];
                                                        NSLog(@"dataBack:oneOrder:dataListArray::::%@", dataListArray);
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneOrder * oneOrder = [OneOrder new];
                                                            [oneOrder setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:oneOrder];
                                                        }
                                                        NSLog(@"self.datasourceMArray:%@", self.datasourceMArray);
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
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
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
                                                NSLog(@"dataBack:oneOrder:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70006) {
                                                        NSMutableArray * leaderMArray = [[[dataBack objectForKey:@"data"] objectForKey:@"data_list"] objectForKey:@"leaders"];
                                                        NSLog(@"self.datasourceMArrayleader:%@", self.datasourceMArray);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self addLeadersViews:leaderMArray];
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
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50001:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50002:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 50003:
            NSLog(@"%ld", (long)sender.tag);
            break;
        case 51001:
            NSLog(@"%ld", (long)sender.tag);
            [self testCodes];
            break;
        default:
            break;
    }
}


-(void)testCodes{
    MenuAlertViewController *vc = [[MenuAlertViewController alloc]initWithTitleItems:@[@"技术魏总监", @"技术魏总监" ,@"技术魏总监",@"技术魏总监",@"技术魏总监",@"技术魏总监"] detailsItems:@[@"2017-10-10", @"2019-10-10"] selectImage:@"select_normal" normalImage:@"select_not"];
    vc.leftBtnTitle = @"取消";
    vc.title = @"我是标题";
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
        
        NSLog(@"index: %zd", index);
    };
    
    [self presentViewController:vc animated:false completion:nil];
    
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
        // 操作具体内容
        // Nothing to do.
        if ([str isEqualToString:@"取消创建"] ||[str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
            [self undisplayaddOrEditWorkOrderView];
            if ([str isEqualToString:@"创建成功"] ||[str isEqualToString:@"发送成功"]) {
//                [self getWorkOrder51001ListFromServer:_pageNum];
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
