//
//  OneTaskDetailedListVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/6.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneTaskDetailedListVC.h"
#import "OneTasKStep.h"
#import "OneTasKStepTVCell.h"
#import "StepDetailCommunicationListVC.h"
#import "OneTasKStep.h"
@interface OneTaskDetailedListVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) UIView * stepNewView;
@property (nonatomic, strong) NSMutableString * indexRowTempStr;
@property (nonatomic, strong) UIView * changeNameDeleteCompletestepNewView;

@end

@implementation OneTaskDetailedListVC

static  NSString  * identifier = @"CELL";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(NSMutableString *)indexRowTempStr{
    if (!_indexRowTempStr) {
        _indexRowTempStr = [NSMutableString string];
    }
    return _indexRowTempStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getOneTaskStepListFromServer];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"任务步骤"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newStep)];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneTasKStepTVCell class] forCellReuseIdentifier:identifier];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [_tableView addGestureRecognizer:lpgr]; //启用长按事件
    
    [self addNewTaskNameView];
    [self ADDchangeNameDeleteCompleteStepView];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer  //长按响应函数
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:_tableView ];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
        NSLog(@"NewStepOfTask.rowindexPath.row:%ld", indexPath.row);
        if (indexPath == nil)
            NSLog(@"long press on table view but not on a row");
        else
            NSLog(@"long press on table view at row %ld", indexPath.row);
        
        OneTasKStep * oneTasKStep = self.datasource[indexPath.row];
        NSString * str = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        _indexRowTempStr = [NSMutableString stringWithFormat:@"%@",  oneTasKStep.subtaskId];
        [self alert: str];
        [self displayChangeNameDeleteCompleteStepView];
    }
    
}



#pragma changeNameDeleteCompleteStep
-(void)ADDchangeNameDeleteCompleteStepView{
    _changeNameDeleteCompletestepNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth / 6  - iphoneWidth, iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 )];
    _changeNameDeleteCompletestepNewView.layer.borderWidth = 1;
    _changeNameDeleteCompletestepNewView.layer.cornerRadius = 5;
    _changeNameDeleteCompletestepNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_changeNameDeleteCompletestepNewView];
    NSMutableArray * ary = [NSMutableArray arrayWithObjects:@"更改步骤名称", @"删除该步骤", @"标记该步骤(完成/未完成)", nil];
    for (int i = 0; i < ary.count; i++) {
        UIButton * changeNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        changeNameButton.frame = CGRectMake(15 , 5 + i * ((iphoneWidth * 4 / 9 - 20 ) / 3 + 5 ) , iphoneWidth * 2 / 3 - 10, (iphoneWidth * 4 / 9 - 20 ) / 3);
        changeNameButton.titleLabel.textColor = [UIColor blackColor];
        changeNameButton.layer.borderWidth = 0.5;
        changeNameButton.layer.cornerRadius = 4;
        [changeNameButton setTitle:ary[i] forState:UIControlStateNormal];
        [changeNameButton addTarget:self action:@selector(changeNameDeleteCompleteButton:) forControlEvents:UIControlEventTouchUpInside];
        changeNameButton.tag =  12001;
        [_changeNameDeleteCompletestepNewView addSubview:changeNameButton];
    }
}
-(void)displayChangeNameDeleteCompleteStepView{
    _changeNameDeleteCompletestepNewView.frame = CGRectMake(iphoneWidth / 6 , iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 );
}
-(void)undisplayChangeNameDeleteCompleteStepView{
    _changeNameDeleteCompletestepNewView.frame = CGRectMake(iphoneWidth / 6  - iphoneWidth * 2, iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 );
}
-(void)changeNameDeleteCompleteButton:(UIButton *)button{
    [self undisplayChangeNameDeleteCompleteStepView];
    [self changeStepAfterUrl:@"/v1/api/v2/task/detail/delete" titleStr:_messageTextView.text subtaskId:_indexRowTempStr];
}

-(void)changeStepAfterUrl:(NSString *)afterUrlStr titleStr:(NSString *)titleStr subtaskId:(NSString *)subtaskId {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, afterUrlStr]];///v1/api/v2/task/detail/rename  /v1/api/v2/task/detail/delete   /v1/api/v2/task/detail/remark
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
    [mdict setObject:subtaskId forKey:@"subtaskId"];
//    [mdict setObject:titleStr forKey:@"title"];
    NSLog(@"更新项目名称60020:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"60020:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60016) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"更改步骤成功"];
                                                            [self getOneTaskStepListFromServer];
                                                        });
                                                    }else if ([[dataBack objectForKey:@"message"] intValue] == 60020) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"删除步骤成功"];
                                                            [self getOneTaskStepListFromServer];
                                                        });
                                                    }else if ([[dataBack objectForKey:@"message"] intValue] == 60018) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"完成/未完成标记成功"];
                                                            [self getOneTaskStepListFromServer];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self alert:@"创建任务失败"];
                                                });
                                            }
                                        }];
    [task resume];
}

#pragma changeNameDeleteCompleteStep  end

-(void)addNewTaskNameView{
    _stepNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9)];
    _stepNewView.layer.borderWidth = 1;
    _stepNewView.layer.cornerRadius = 5;
    _stepNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_stepNewView];
    
    UILabel * taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 1 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 6 / 27)];
    taskNameLabel.text = @"新建项目步骤的名称";
    taskNameLabel.textAlignment = NSTextAlignmentCenter;
    [_stepNewView addSubview:taskNameLabel];
    
    
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 8 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 12 / 27)];
    _messageTextView.font = [UIFont systemFontOfSize:21];
    //    _messageTextView.backgroundColor = [UIColor greenColor];
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _messageTextView.attributedText = [[NSAttributedString alloc] initWithString:@"请输入任务名称。不超过30个字符。" attributes:attributes];
    //    _messageTextView.text = @"请输入任务名称。不超过30个字符。";
    _messageTextView.delegate = self;
    [_stepNewView addSubview:_messageTextView];
    
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(0 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [agreeButton setTitle:@"确定" forState:(UIControlStateNormal)];
    agreeButton.layer.borderWidth = 0.5;
    agreeButton.tag = 10101;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_stepNewView addSubview:agreeButton];
    
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(iphoneWidth / 3 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [refuseButton setTitle:@"取消" forState:(UIControlStateNormal)];
    refuseButton.layer.borderWidth = 0.5;
    refuseButton.tag = 10102;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_stepNewView addSubview:refuseButton];
    
}

-(void)sendNewTaskToServer:(UIButton*)sender{
    if (sender.tag == 10101) {
        [self SendNewTaskToServerWithtitleStr:_messageTextView.text taskId:_taskIdStr];
        [self removeNewTaskView];
    }else if (sender.tag == 10102) {
        [self alert:@"取消项目步骤的创建"];
        [self removeNewTaskView];
    }
    [self removeNewTaskView];
}
-(void)SendNewTaskToServerWithtitleStr:(NSString *)titleStr taskId:(NSString *)taskId{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/detail/create", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:titleStr forKey:@"title"];
    [mdict setObject:_taskIdStr forKey:@"taskId"];
    NSLog(@"mdict11111111111111111111111111234567,60010:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"OK60010:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60010) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self getOneTaskStepListFromServer];
                                                            [self alert:@"创建任务成功"];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self alert:@"创建任务失败"];
                                                });
                                            }
                                        }];
    [task resume];
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

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"请注意!";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
        if ([title isEqualToString:@"创建任务成功"]) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[InternalDepartmentVC class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
            }
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}


-(void)removeNewTaskView{
    _stepNewView.frame = CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
    _messageTextView.text = nil;
}
-(void)addTaskDetailed{
     self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
}
-(void)getOneTaskStepListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/detail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"1" forKey:@"pageNum"];
    [mdict setObject:_taskIdStr forKey:@"taskId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60003) {
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneTasKStep * oneTasKStep = [OneTasKStep new];
                                                            [oneTasKStep setValuesForKeysWithDictionary:dict];
                                                            [self.datasource addObject:oneTasKStep];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                NSLog(@"HUMan5获取数据失败，问gitPersonPermissions");
                                            }
                                        }];
    [task resume];
}
-(void)newStep{
    _stepNewView.frame = CGRectMake(iphoneWidth / 6  + 20 , iphoneWidth / 6, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
}



#pragma mark  tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OneTasKStepTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OneTasKStep * oneTasKStep = self.datasource[indexPath.row];
    cell.oneTasKStep = oneTasKStep;
    cell.orderCircleLabel.text = [NSMutableString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    switch (indexPath.row % 10) {
        case 0:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
            break;
        case 1:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
            break;
        case 2:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
            break;
        case 3:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
            break;
        case 4:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
            break;
        case 5:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 37/ 255.0 green:155 / 255.0 blue: 35 / 255.0 alpha:1];
            break;
        case 6:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed:0 green:151 / 255.0 blue: 136 / 255.0 alpha:0.8];
            break;
        case 7:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 238/ 255.0 green:23 / 255.0 blue: 39 / 255.0 alpha:1];
            break;
        case 8:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed: 254/ 255.0 green:65 / 255.0 blue: 129 / 255.0 alpha:1];
            break;
        case 9:
            cell.orderCircleLabel.backgroundColor = [UIColor colorWithRed:62/ 255.0 green:80 / 255.0 blue: 182 / 255.0 alpha:1];
            break;
        default:
            break;
    }    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OneTasKStep *  oneTasKStep = self.datasource[indexPath.row];
    StepDetailCommunicationListVC * stepDetailCommunicationListVC = [StepDetailCommunicationListVC new];
    stepDetailCommunicationListVC.subtaskIdStr = oneTasKStep.subtaskId;
    [self.navigationController pushViewController:stepDetailCommunicationListVC animated:YES];
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
