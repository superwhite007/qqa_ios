//
//  OneOrderCommunicationVController.m
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCommunicationVController.h"
#import "OneOrderCommunication.h"
#import "OneOrderCommunicationTVCell.h"

@interface OneOrderCommunicationVController ()
@property(nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * datasource;

@property (nonatomic, strong) UIView * orderCommunicationNewView;
@property (nonatomic, strong) NSMutableString * indexRowTempStr;


@end
@implementation OneOrderCommunicationVController

static  NSString  * identifier = @"CELL";
-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"工单交流"];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(displayNewCommunicationView)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneOrderCommunicationTVCell class] forCellReuseIdentifier:identifier];
    [self getOneOrderdetailCommunicationListFromServer];
    [self addNewOneOrderCommunicatonsView];
}


-(void)addNewOneOrderCommunicatonsView{
    _orderCommunicationNewView = [[UIView alloc] initWithFrame:CGRectMake(iphoneWidth / 6  + 8 * iphoneWidth, 20, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9)];
    _orderCommunicationNewView.layer.borderWidth = 1;
    _orderCommunicationNewView.layer.cornerRadius = 5;
    _orderCommunicationNewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_orderCommunicationNewView];
    
    UILabel * taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 1 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 6 / 27)];
    taskNameLabel.text = @"新建工单交流内容";
    taskNameLabel.textAlignment = NSTextAlignmentCenter;
    [_orderCommunicationNewView addSubview:taskNameLabel];
    _oneOrderCommunicationMessageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, iphoneWidth * 4 / 9 * 8 / 27, iphoneWidth * 2 / 3 -20, iphoneWidth * 4 / 9 * 12 / 27)];
    _oneOrderCommunicationMessageTextView.font = [UIFont systemFontOfSize:21];
    //    _oneOrderCommunicationMessageTextView.backgroundColor = [UIColor greenColor];
    _oneOrderCommunicationMessageTextView.layer.borderWidth = 1;
    _oneOrderCommunicationMessageTextView.layer.cornerRadius = 5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _oneOrderCommunicationMessageTextView.attributedText = [[NSAttributedString alloc] initWithString:@"请输入工单交流内容。不超过200个字符。" attributes:attributes];
    //    _oneOrderCommunicationMessageTextView.text = @"请输入任务名称。不超过30个字符。";
    _oneOrderCommunicationMessageTextView.delegate = self;
    [_orderCommunicationNewView addSubview:_oneOrderCommunicationMessageTextView];
    UIButton * agreeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    agreeButton.frame = CGRectMake(0 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [agreeButton setTitle:@"取消" forState:(UIControlStateNormal)];
    agreeButton.layer.borderWidth = 0.5;
    agreeButton.tag = 1211001;
    [agreeButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_orderCommunicationNewView addSubview:agreeButton];
    UIButton * refuseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    refuseButton.frame = CGRectMake(iphoneWidth / 3 , iphoneWidth * 4 / 9 * 21 / 27, iphoneWidth / 3, iphoneWidth * 4 / 9 * 6 / 27);
    [refuseButton setTitle:@"确定" forState:(UIControlStateNormal)];
    refuseButton.layer.borderWidth = 0.5;
    refuseButton.tag = 1211002;
    [refuseButton addTarget:self action:@selector(sendNewTaskToServer:) forControlEvents:UIControlEventTouchUpInside];
    [_orderCommunicationNewView addSubview:refuseButton];
}
-(void)sendNewTaskToServer:(UIButton*)sender{
    if (sender.tag == 1211002) {
        if ([_oneOrderCommunicationMessageTextView.text isEqualToString:@"请输入工单交流内容。不超过200个字符。"] || _oneOrderCommunicationMessageTextView.text == nil) {
            [self alert:@"请输入工单交流的内容"];
        }else{
            
            if (_oneOrderCommunicationMessageTextView.text.length >= 200){
                [self alert:@"最多输入200字符"];
                _oneOrderCommunicationMessageTextView.text = [_oneOrderCommunicationMessageTextView.text substringToIndex:200];
            }
            [self SendNewCommunicationToServer];
            [self removeNewTaskView];
            [self undisplayReminderOrNewCommunicationView];
        }
    }else if (sender.tag == 1211001) {
        [self alert:@"取消交流内容的创建"];
        [self removeNewTaskView];
        [self undisplayReminderOrNewCommunicationView];
        [self removeNewTaskView];
    }
}
-(void)SendNewCommunicationToServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetailComment/create", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_oneOrderCommunicationMessageTextView.text forKey:@"content"];
    [mdict setObject:_workListIdSTR forKey:@"workListId"];
    [mdict setObject:_workListDetailIdSTR forKey:@"workListDetailId"];
    NSLog(@"OK70019:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSLog(@"OK70019error:%@", error);
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"OK70019:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70019) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self getOneOrderdetailCommunicationListFromServer];
                                                            [self alert:@"创建工单交流内容成功!"];
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

-(void)removeNewTaskView{
    _orderCommunicationNewView.frame = CGRectMake(iphoneWidth / 6  + 8 * iphoneWidth, 20, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
    _oneOrderCommunicationMessageTextView.text = nil;
}
-(void)displayNewCommunicationView{
    _orderCommunicationNewView.frame = CGRectMake(iphoneWidth / 6 , 20, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
}
-(void)undisplayReminderOrNewCommunicationView{
    _orderCommunicationNewView.frame = CGRectMake(iphoneWidth / 6 + 8 * iphoneWidth , 20, iphoneWidth * 2 / 3, iphoneWidth * 4 / 9);
}


#pragma mark  tableview data source
-(void)getOneOrderdetailCommunicationListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/workListDetailComment/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_workListIdSTR forKey:@"workListId"];
    [mdict setObject:_workListDetailIdSTR forKey:@"workListDetailId"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                NSLog(@"8888888888888888888:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 70020) {
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneOrderCommunication * oneOrderCommunication = [OneOrderCommunication new];
                                                            [oneOrderCommunication setValuesForKeysWithDictionary:dict];
                                                            [self.datasource addObject:oneOrderCommunication];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OneOrderCommunicationTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OneOrderCommunication * oneOrderCommunication = self.datasource[indexPath.row];
    cell.oneOrderCommunication = oneOrderCommunication;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneOrderCommunication * oneOrderCommunication = self.datasource[indexPath.row];
    UILabel * label = [UILabel new];
    label.text = oneOrderCommunication.content;
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
#pragma datasource end

#pragma UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入工单交流内容。不超过200个字符。"]) {
        textView.text = nil;
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {//判断按的是不是return
        [_oneOrderCommunicationMessageTextView resignFirstResponder];
        return NO;
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        _oneOrderCommunicationMessageTextView.text = [_oneOrderCommunicationMessageTextView.text substringToIndex:200];
        return NO;
    }
    return YES;
}

- (void)reKeyBoard{
    [_oneOrderCommunicationMessageTextView resignFirstResponder];
}

#pragma UITextViewDelegate end

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"titletitle:%@", title);
        if ([title isEqualToString:@"创建工单交流内容成功!"]||[title isEqualToString:@"最多输入200字符"]||[title isEqualToString:@"请输入工单交流内容。不超过200个字符。"]) {
            [self reKeyBoard];
        }
        
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self reKeyBoard];
    [self undisplayReminderOrNewCommunicationView];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self reKeyBoard];
    [self undisplayReminderOrNewCommunicationView];
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
