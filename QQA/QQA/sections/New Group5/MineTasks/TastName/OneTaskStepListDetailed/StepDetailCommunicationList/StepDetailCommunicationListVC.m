//
//  StepDetailCommunicationListVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/13.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "StepDetailCommunicationListVC.h"
#import "StepDetailCommunication.h"
#import "StepDetailCommunicationTVCell.h"

@interface StepDetailCommunicationListVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) UIView * communicationNewView;
@property (nonatomic, strong) NSMutableString * indexRowTempStr;
@property (nonatomic, strong) UIView * reminderOrNewCommunicationView;

@end

@implementation StepDetailCommunicationListVC

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self.navigationItem setTitle:@"任务交流"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayReminderOrNewCommunicationView)];
    [self getOneTaskStepCommunicationListFromServer];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[StepDetailCommunicationTVCell class] forCellReuseIdentifier:identifier];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [_tableView addGestureRecognizer:lpgr]; //启用长按事件
    
    [self addNewTaskNameView];
    [self addReminderOrNewCommunicationView];
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
        NSString * str = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        _indexRowTempStr = [NSMutableString stringWithFormat:@"%@", str];
    }
    
}

#pragma changeNameDeleteCompleteStep
-(void)addReminderOrNewCommunicationView{
    _reminderOrNewCommunicationView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth / 6  + 2 * iphoneWidth, iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9  - ((iphoneWidth * 4 / 9 - 20 ) / 3 + 5 ))];
    _reminderOrNewCommunicationView.layer.borderWidth = 1;
    _reminderOrNewCommunicationView.layer.cornerRadius = 5;
    _reminderOrNewCommunicationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_reminderOrNewCommunicationView];
    NSMutableArray * ary = [NSMutableArray arrayWithObjects:@"催单", @"交流", nil];
    for (int i = 0; i < ary.count; i++) {
        UIButton * changeNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        changeNameButton.frame = CGRectMake(15 , 5 + i * ((iphoneWidth * 4 / 9 - 20 ) / 3 + 5 ) , iphoneWidth * 2 / 3 - 10, (iphoneWidth * 4 / 9 - 20 ) / 3);
        changeNameButton.titleLabel.textColor = [UIColor blackColor];
        changeNameButton.layer.borderWidth = 0.5;
        changeNameButton.layer.cornerRadius = 4;
        changeNameButton.tag = 12110 + i;
        [changeNameButton setTitle:ary[i] forState:UIControlStateNormal];
        [changeNameButton addTarget:self action:@selector(changeNameDeleteCompleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [_reminderOrNewCommunicationView addSubview:changeNameButton];
    }
}
-(void)displayReminderOrNewCommunicationView{
    _reminderOrNewCommunicationView.frame = CGRectMake(iphoneWidth / 6 , iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 - ((iphoneWidth * 4 / 9 - 20 ) / 3 + 5 ));
}
-(void)undisplayReminderOrNewCommunicationView{
    _reminderOrNewCommunicationView.frame = CGRectMake(iphoneWidth / 6  +  iphoneWidth * 2, iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 );
}
-(void)changeNameDeleteCompleteButton:(UIButton *)button{
    [self undisplayReminderOrNewCommunicationView];
    switch (button.tag) {
        case 12110:
            [self  gitPersonCommentPermissions];
            break;
        case 12111:
            [self newCommunication];
            break;
        
        default:
            break;
    }
}


-(void)gitPersonCommentPermissions{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/comment/permission/", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_subtaskIdStr forKey:@"subtaskId"];
    NSError * error = nil;
    NSLog(@"mdictComment:%@", mdict);
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSLog(@"%@", error);
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"dataBackdataBack111:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ( [[dataBack objectForKey:@"message"] intValue] == 60036 ) {
                                                        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dataBack];
                                                        if ([[dict objectForKey:@"isReminder"] intValue] == 1) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self havePermissionsYes];
                                                            });
                                                        }else{
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [self alert:@"没有相关权限1"];
                                                            });
                                                        }
                                                    }else {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"没有相关权限2"];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self alert:@"没有相关权限3"];
                                                    });
                                                }
                                            }else{
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self alert:@"没有相关权限4"];
                                                });
                                            }
                                        }];
    [task resume];
    
}
-(void)havePermissionsYes{
 [self SendNewCommunicationToServerWithtitleStr:_messageTextView.text taskId:_subtaskIdStr type:@"1"];
}

-(void)addNewTaskNameView{
    _communicationNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9)];
    _communicationNewView.layer.borderWidth = 1;
    _communicationNewView.layer.cornerRadius = 5;
    _communicationNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_communicationNewView];
    
    UILabel * taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 1 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 6 / 27)];
    taskNameLabel.text = @"新建工作交流内容";
    taskNameLabel.textAlignment = NSTextAlignmentCenter;
    [_communicationNewView addSubview:taskNameLabel];
    
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
    _messageTextView.attributedText = [[NSAttributedString alloc] initWithString:@"请输入交流内容。不超过200个字符。" attributes:attributes];
    //    _messageTextView.text = @"请输入任务名称。不超过30个字符。";
    _messageTextView.delegate = self;
    [_communicationNewView addSubview:_messageTextView];
    
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(0 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [agreeButton setTitle:@"确定" forState:(UIControlStateNormal)];
    agreeButton.layer.borderWidth = 0.5;
    agreeButton.tag = 11001;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_communicationNewView addSubview:agreeButton];
    
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(iphoneWidth / 3 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [refuseButton setTitle:@"取消" forState:(UIControlStateNormal)];
    refuseButton.layer.borderWidth = 0.5;
    refuseButton.tag = 11002;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_communicationNewView addSubview:refuseButton];
    
}

-(void)sendNewTaskToServer:(UIButton*)sender{
    if (sender.tag == 11001) {
        if (_messageTextView.text.length >= 200){
            [self alert:@"最多输入200字符"];
            _messageTextView.text = [_messageTextView.text substringToIndex:200];
        }
        [self SendNewCommunicationToServerWithtitleStr:_messageTextView.text taskId:_subtaskIdStr type:@"2"];
        [self removeNewTaskView];
        [self undisplayReminderOrNewCommunicationView];
    }else if (sender.tag == 11002) {
        [self alert:@"取消交流内容的创建"];
        [self removeNewTaskView];
        [self undisplayReminderOrNewCommunicationView];
    }
    [self removeNewTaskView];
}
-(void)SendNewCommunicationToServerWithtitleStr:(NSString *)titleStr taskId:(NSString *)taskId type:(NSString *)type{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/comment/create", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:titleStr forKey:@"content"];
    [mdict setObject:taskId forKey:@"subtaskId"];
    [mdict setObject:type forKey:@"type"];//评论类型：1为催单 2为交流
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"OK60012:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60012) {
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self getOneTaskStepCommunicationListFromServer];
                                                            [self alert:@"创建交流内容成功!"];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]] ) {
                                                    NSLog(@"Server tapy is wrong.");
                                                }
                                            }else{
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self alert:@"创建交流任务失败2"];
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
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textview:%@", textView.text);
}

-(void)alert:(NSString *)str{
    NSLog(@"111111111%@", str);
    NSString *title = str;
    NSString *message = @" ";
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
    _communicationNewView.frame = CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
    _messageTextView.text = nil;
}

-(void)getOneTaskStepCommunicationListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/comment/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_subtaskIdStr forKey:@"subtaskId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60005) {
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            StepDetailCommunication * stepDetailCommunication = [StepDetailCommunication new];
                                                            [stepDetailCommunication setValuesForKeysWithDictionary:dict];
                                                            [self.datasource addObject:stepDetailCommunication];
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
-(void)newCommunication{
    _communicationNewView.frame = CGRectMake(iphoneWidth / 6  + 20 , iphoneWidth / 6, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
}

#pragma mark  tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    StepDetailCommunicationTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    StepDetailCommunication * stepDetailCommunication = self.datasource[indexPath.row];
    cell.stepDetailCommunication = stepDetailCommunication;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StepDetailCommunication * stepDetailCommunication = self.datasource[indexPath.row];
    UILabel * label = [UILabel new];
    label.text = stepDetailCommunication.content;
    label.font = [UIFont systemFontOfSize:18];
    label.numberOfLines = 0;//表示label可以多行显示
    label.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 120, 2000);
    CGRect targetRect = [label.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
    if (CGRectGetHeight(targetRect) < 60) {
        return 100;
    }else{
        return CGRectGetHeight(targetRect) + 40;
    }
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
