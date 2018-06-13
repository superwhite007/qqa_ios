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

@interface TaskVC ()

@property (nonatomic, strong) UIView * taskNewView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *datasourceMArray;
@property (nonatomic, strong) NSMutableString * conditionMStr;

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
    _conditionMStr = [NSMutableString stringWithFormat:@"uncompleted"];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:_mineOrOthersStr];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, iphoneWidth, iphoneHeight - 104) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSegmentControl];
    [self addNewTaskNameView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newTask)];
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[TaskNameTVCell class] forCellReuseIdentifier:identifier];
//    [self.datasourceMArray addObject:@"test1"];
//    [self.datasourceMArray addObject:@"test2"];
//    [self.datasourceMArray addObject:@"test3"];
//    [self.datasourceMArray addObject:@"test4"];
//    [self.datasourceMArray addObject:@"test5"];
//    [self.datasourceMArray addObject:@"test6"];
   
    [self getTaskListFromServer];
    
    // Do any additional setup after loading the view.
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
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            _conditionMStr = [NSMutableString stringWithFormat:@"uncompleted"];
            [self getTaskListFromServer];
            break;
        case 1:
            
            _conditionMStr = [NSMutableString stringWithFormat:@"completed"];
            [self getTaskListFromServer];
            break;
        default:
            break;
    }
}

-(void)getTaskListFromServer{
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
    } else if ([_mineOrOthersStr isEqualToString:@"下属任务"]) {
        [mdict setObject:@"subordinate" forKey:@"type"];
    }
    [mdict setObject:@"1" forKey:@"pageNum"];
    [mdict setObject:_conditionMStr forKey:@"condition"];
    NSLog(@"6666666%@", mdict);
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
    [self.navigationController pushViewController:oneTaskDetailedListVC animated:NO];

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
