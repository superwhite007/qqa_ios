//
//  InternalDepartmentVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/14.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "InternalDepartmentVC.h"
#import "TaskVC.h"
#import "NewTask.h"

@interface InternalDepartmentVC ()

@property (nonatomic, strong) UIView * taskNewView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableString * departmentIdStr;
@end

@implementation InternalDepartmentVC

static  NSString  * identifier = @"CELL";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
-(NSMutableString *)departmentIdStr{
    if (!_departmentIdStr) {
        _departmentIdStr = [NSMutableString string];
    }
    return _departmentIdStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.navigationItem setTitle:@"内部部门"];
    // Do any additional setup after loading the view.
    
    [self getDepartmentsListFromServer];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
//    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self addNewTaskNameView];
    
    
    
    
    
}



-(void)addNewTaskNameView{
    _taskNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9)];
    _taskNewView.layer.borderWidth = 1;
    _taskNewView.layer.cornerRadius = 5;
    _taskNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_taskNewView];
    
    UILabel * taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 1 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 6 / 27)];
    taskNameLabel.text = @"新建项目名称";
    taskNameLabel.textAlignment = NSTextAlignmentCenter;
    [_taskNewView addSubview:taskNameLabel];
    
    
    
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
    [_taskNewView addSubview:_messageTextView];
    
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(0 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [agreeButton setTitle:@"确定" forState:(UIControlStateNormal)];
    agreeButton.layer.borderWidth = 0.5;
    agreeButton.tag = 10011;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:agreeButton];
    
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(iphoneWidth / 3 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [refuseButton setTitle:@"取消" forState:(UIControlStateNormal)];
    refuseButton.layer.borderWidth = 0.5;
    refuseButton.tag = 10012;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_taskNewView addSubview:refuseButton];
    
}

-(void)sendNewTaskToServer:(UIButton*)sender{
    NSLog(@"sender:%@", sender);
    if (sender.tag == 10011) {
        
        [self SendNewTaskToServerWithpatternStr:@"1" typeStr:@"2" departmentIdStr:_departmentIdStr titleStr:_messageTextView.text];
        
        [self removeNewTaskView];
    }else if (sender.tag == 10012) {
        [self alert:@"取消创建任务"];
        [self removeNewTaskView];
    }
    [self removeNewTaskView];
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


-(void)removeNewTaskView{
    _taskNewView.frame = CGRectMake(iphoneWidth  / 6 + iphoneWidth, (iphoneHeight - 135) / 2, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
    _messageTextView.text = nil;
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
                NSLog(@"Class:%@", [controller class]);
                
                NewTask * newTask = [NewTask new];
//                [newTask NewTaskSendToServerWithpatternStr:@"1" typeStr:@"1" departmentIdStr:@"1" titleStr:@"111111"];
                [newTask SendNewTaskToServerWithpatternStr:@"1" typeStr:@"1" departmentIdStr:@"1" titleStr:@"111111"];
                if ([controller isKindOfClass:[TaskVC class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}



-(void)getDepartmentsListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/task/department/index", CONST_SERVER_ADDRESS]];
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
    NSLog(@"77777777%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60007) {
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            [self.datasource addObject:dict];
                                                        }
                                                        NSLog(@"%@", self.datasource);
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

#pragma mark  tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [self.datasource[indexPath.row] objectForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _departmentIdStr = [self.datasource[indexPath.row] objectForKey:@"departmentId"];
    [self newTask];
}

-(void)newTask{
    _taskNewView.frame = CGRectMake(iphoneWidth / 6  + 20 , iphoneWidth / 6, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
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
