//
//  TaskVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/6.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "TaskVC.h"
#import "TaskName.h"
#import "TaskNameTVCell.h"
#import "OneTaskDetailedListVC.h"
#import "InternalDepartmentVC.h"

#import "NewTask.h"

@interface TaskVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView * taskNewView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;
@property (nonatomic, strong) NSMutableString * conditionMStr;
@property (nonatomic, strong) UIView * privateORInternalListView;
@property (nonatomic, strong) UILabel * taskNameLabel;
@property (nonatomic, strong) NSMutableString  * taskIdMStr;

@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;

@end

@implementation TaskVC

static NSString  *  identifier = @"CELL";

-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}
-(NSMutableString *)taskIdMStr{
    if (!_taskIdMStr) {
        _taskIdMStr = [NSMutableString string];
    }
    return _taskIdMStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    NSLog(@"_mineOrOthersStr:%@", _mineOrOthersStr);
    _conditionMStr = [NSMutableString stringWithFormat:@"uncompleted"];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:_mineOrOthersStr];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, iphoneWidth, iphoneHeight - 104) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSegmentControl];
    [self addNewTaskNameView];
    if (![_mineOrOthersStr isEqualToString:@"私人任务"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addPrivateORInternalListView)];
    }
   
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds  设置响应时间
    lpgr.delegate = self;
    [_tableView addGestureRecognizer:lpgr]; //启用长按事件
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[TaskNameTVCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
    [self getTaskListFromServer:_pageNum];
    
    // Do any additional setup after loading the view.
}

-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self getTaskListFromServer:--self.pageNum];
    } else{
        [self getTaskListFromServer:1];
    }
    [self.tableView.mj_header endRefreshing];
}

-(void)loadMoreData
{
    //记录不是下拉刷新
    self.isDownRefresh = NO;
    [self getTaskListFromServer:++self.pageNum];
    [self.tableView.mj_footer endRefreshing];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer  //长按响应函数
{
    NSLog(@"11111111111111111111111111111111111111");
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [gestureRecognizer locationInView:_tableView ];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
        NSLog(@"indexPath.rowindexPath.rowindexPath.row:%ld", indexPath.row);
        if (indexPath == nil)
            NSLog(@"long press on table view but not on a row");
        else
            NSLog(@"long press on table view at row %ld", indexPath.row);
        TaskName * taskName = self.datasourceMArray[indexPath.row];
        if (taskName.isRename) {
             [self alert: @"有修改权限"];
            [self newTask];
            _messageTextView.text = taskName.title;
            _taskNameLabel.text = @"修改项目名称";
            _taskIdMStr = [ NSMutableString stringWithFormat:@"%@", taskName.taskId];
        } else{
             [self alert: @"无修改权限"];
        }
       
    }
    
}
-(void)alertAppCover:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @"请联系开发人员";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
}
-(void)addSegmentControl{
    NSArray * ary = [NSArray arrayWithObjects:@"进行中的任务", @"已完成的任务", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:ary];
    segment.frame = CGRectMake(0, 0, iphoneWidth, 40);
    segment.selectedSegmentIndex = 0;//设置默认选择项索引
    segment.tintColor = [UIColor redColor];
    [segment addTarget: self  action: @selector(selected:)  forControlEvents:UIControlEventValueChanged ];
    segment.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:segment];
}
#pragma mark - 分段选择的点击事件
-(void)selected:(id)sender{
    [self removePrivateORInternalListView];
    _pageNum = 1;
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            _conditionMStr = [NSMutableString stringWithFormat:@"uncompleted"];
            [self getTaskListFromServer:_pageNum];
            break;
        case 1:
            
            _conditionMStr = [NSMutableString stringWithFormat:@"completed"];
            [self getTaskListFromServer:_pageNum];
            break;
        default:
            break;
    }
}

-(void)getTaskListFromServer:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/index", CONST_SERVER_ADDRESS]];
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
    if ([_mineOrOthersStr isEqualToString:@"自己的任务"]) {
        [mdict setObject:@"own" forKey:@"type"];
    } else if ([_mineOrOthersStr isEqualToString:@"私人任务"]) {
        [mdict setObject:@"others" forKey:@"type"];
        [mdict setObject:_userIdStr forKey:@"userId"];
    } else if ([_mineOrOthersStr isEqualToString:@"下属任务"]) {
        [mdict setObject:@"subordinate" forKey:@"type"];
    }
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    [mdict setObject:_conditionMStr forKey:@"condition"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60001) {
                                                        [self.datasourceMArray removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            TaskName * taskName = [TaskName new];
                                                            [taskName setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:taskName];
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

#pragma  datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskNameTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    TaskName * taskName = self.datasourceMArray[indexPath.row];
    cell.taskName = taskName;
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
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskName * taskName = self.datasourceMArray[indexPath.row];
    OneTaskDetailedListVC * oneTaskDetailedListVC = [OneTaskDetailedListVC new];
    oneTaskDetailedListVC.taskIdStr = [NSString stringWithFormat:@"%@", taskName.taskId];
     if ([_mineOrOthersStr isEqualToString:@"私人任务"]) {
         oneTaskDetailedListVC.identifierPrivate = _mineOrOthersStr;
     }
    [self.navigationController pushViewController:oneTaskDetailedListVC animated:NO];

}


-(void)addNewTaskNameView{
    _taskNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9)];
    _taskNewView.layer.borderWidth = 1;
    _taskNewView.layer.cornerRadius = 5;
    _taskNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_taskNewView];
    
    _taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 1 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 6 / 27)];
    _taskNameLabel.text = @"新建项目名称";
    _taskNameLabel.textAlignment = NSTextAlignmentCenter;
    [_taskNewView addSubview:_taskNameLabel];
    
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
    _messageTextView.delegate = self;
    [_taskNewView addSubview:_messageTextView];
    
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(0 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [agreeButton setTitle:@"确定" forState:(UIControlStateNormal)];
    agreeButton.layer.borderWidth = 0.5;
    agreeButton.tag = 10001;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:agreeButton];
    
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(iphoneWidth / 3 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [refuseButton setTitle:@"取消" forState:(UIControlStateNormal)];
    refuseButton.layer.borderWidth = 0.5;
    refuseButton.tag = 10002;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:refuseButton];

}

-(void)addPrivateORInternalListView{
    _privateORInternalListView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth / 6 , iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 - 10)];
    _privateORInternalListView.layer.borderWidth = 1;
    _privateORInternalListView.layer.cornerRadius = 5;
    _privateORInternalListView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_privateORInternalListView];
    
    UIImageView * privateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 2 / 15, iphoneWidth * 4 / 9 / 6, iphoneWidth * 4 / 9 / 6)];
    privateImageView.image = [UIImage imageNamed:@"lock"];
    [_privateORInternalListView addSubview:privateImageView];
    
    
    UIButton * privateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    privateButton.frame = CGRectMake(15 + iphoneWidth * 4 / 9 / 6, iphoneWidth * 4 / 9 * 2 / 15 , iphoneWidth * 2 / 3 - 25 - iphoneWidth * 4 / 9 / 6 + 20, iphoneWidth * 4 / 9 / 6);
    privateButton.titleLabel.textColor = [UIColor blackColor];
    [privateButton setTitle:@"私有任务-仅任务执行者和领导可见" forState:UIControlStateNormal];
    if ([_mineOrOthersStr isEqualToString:@"自己的任务"]) {
        [privateButton addTarget:self action:@selector(newTask) forControlEvents:UIControlEventTouchUpInside];
    } else if ([_mineOrOthersStr isEqualToString:@"下属任务"]) {
        [privateButton addTarget:self action:@selector(Internal:) forControlEvents:UIControlEventTouchUpInside];
    }
    privateButton.tag =  12001;
    [_privateORInternalListView addSubview:privateButton];
    
    
    UIImageView * InternalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 3 / 15 + iphoneWidth * 4 / 9 / 3, iphoneWidth * 4 / 9 / 6, iphoneWidth * 4 / 9 / 6)];
    InternalImageView.image = [UIImage imageNamed:@"unlock"];
    [_privateORInternalListView addSubview:InternalImageView];
    UIButton * InternalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    InternalButton.frame = CGRectMake(15 + iphoneWidth * 4 / 9 / 6, iphoneWidth * 4 / 9 * 3 / 15 + iphoneWidth * 4 / 9 / 3  , iphoneWidth * 2 / 3 - 25 - iphoneWidth * 4 / 9 / 6 + 20, iphoneWidth * 4 / 9 / 6);
    InternalButton.titleLabel.textColor = [UIColor blackColor];
    [InternalButton setTitle:@"内部任务-执行者所在的部门可见" forState:UIControlStateNormal];
    [InternalButton addTarget:self action:@selector(Internal:) forControlEvents:UIControlEventTouchUpInside];
    InternalButton.tag = 12002;
    [_privateORInternalListView addSubview:InternalButton];

}
-(void)Internal:(UIButton *)sender{
    
    InternalDepartmentVC * internalDepartmentVC = [InternalDepartmentVC new];
    
    if (sender.tag == 12001  && [_mineOrOthersStr isEqualToString:@"自己的任务"]) {
        internalDepartmentVC.patternStr = @"1";
        internalDepartmentVC.typeStr = @"1";
    } else if (sender.tag == 12001  && [_mineOrOthersStr isEqualToString:@"下属任务"]) {
        internalDepartmentVC.patternStr = @"2";
        internalDepartmentVC.typeStr = @"1";
    } else if (sender.tag == 12002  && [_mineOrOthersStr isEqualToString:@"自己的任务"]) {
        internalDepartmentVC.patternStr = @"1";
        internalDepartmentVC.typeStr = @"2";
    } else if (sender.tag == 12002  && [_mineOrOthersStr isEqualToString:@"下属任务"]) {
        internalDepartmentVC.patternStr = @"2";
        internalDepartmentVC.typeStr = @"2";
    }
    
    [self removePrivateORInternalListView];
    [self.navigationController pushViewController:internalDepartmentVC animated:YES];
    
}

-(void)removePrivateORInternalListView{
    _privateORInternalListView.frame = CGRectMake(iphoneWidth / 6 + 2 * iphoneWidth , iphoneWidth / 6, iphoneWidth * 2 / 3 + 20, iphoneWidth * 4 / 9 - 10);
}



-(void)sendNewTaskToServer:(UIButton*)sender{
    if (sender.tag == 10001) {
        if ([_taskNameLabel.text isEqualToString:@"修改项目名称"]) {
            [self changeTasktitleStr:_messageTextView.text taskId:_taskIdMStr];
        } else {
            if ([_mineOrOthersStr isEqualToString:@"自己的任务"]) {
                [self SendNewTaskToServerWithpatternStr:@"1" typeStr:@"1" departmentIdStr:@"0" titleStr:_messageTextView.text];
            } else if ([_mineOrOthersStr isEqualToString:@"下属任务"]) {
                [self SendNewTaskToServerWithpatternStr:@"1" typeStr:@"1" departmentIdStr:@"0" titleStr:_messageTextView.text];
            }
        }
        
       [self.tableView reloadData];
    }else if (sender.tag == 10002) {
        [self removeNewTaskView];
        [self alert:@"取消创建"];
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
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
        if ([title isEqualToString:@"创建任务成功"]) {
            [self getTaskListFromServer:_pageNum];
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)newTask{
    [self removePrivateORInternalListView];
    _taskNameLabel.text = @"新建项目名称";
    _taskNewView.frame = CGRectMake(iphoneWidth / 6  + 20 , iphoneWidth / 6, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
}
-(void)SendNewTaskToServerWithpatternStr:(NSString *)patternStr typeStr:(NSString *)typeStr departmentIdStr:(NSString *)departmentIdStr titleStr:(NSString *)titleStr{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/create", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:patternStr forKey:@"pattern"];
    [mdict setObject:typeStr forKey:@"type"];
    [mdict setObject:departmentIdStr forKey:@"departmentId"];
    [mdict setObject:titleStr forKey:@"title"];
    NSLog(@"自己的任务-自己的任务-自己的任务-自己的任务-自己的任务-自己的任务-自己的任务-:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"4321234567:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60008) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
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

-(void)changeTasktitleStr:(NSString *)titleStr taskId:(NSString *)taskId {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/update", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:taskId forKey:@"taskId"];
    [mdict setObject:titleStr forKey:@"title"];
    NSLog(@"更新项目名称60014:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"60014:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60014) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"更改任务成功"];
                                                            [self getTaskListFromServer:_pageNum];
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
-(void)removeNewTaskView{
    _taskNewView.frame = CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
    _messageTextView.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getTaskListFromServer:_pageNum];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self removeNewTaskView];
    [self removePrivateORInternalListView];
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
