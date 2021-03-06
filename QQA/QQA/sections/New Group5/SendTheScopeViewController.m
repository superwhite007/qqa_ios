//
//  SendTheScopeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/21.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "SendTheScopeViewController.h"
#import "AppTBViewController.h"

@interface SendTheScopeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasoureSendScopeArray;
@property (nonatomic, strong) NSMutableArray * datasourSendToServerScopeArray;
@property (nonatomic, strong) NSMutableArray * datasoureKeysSendScopeArray;

//@property(nonatomic, strong) UIButton *selectAllBtn;//选择按钮


@end

@implementation SendTheScopeViewController


-(NSArray *)datasoureKeysSendScopeArrayAtIndexes:(NSIndexSet *)indexes{
    if (!_datasoureKeysSendScopeArray) {
        self.datasoureKeysSendScopeArray = [NSMutableArray array];
    }
    return _datasoureKeysSendScopeArray;
}

-(NSMutableArray *)datasoureSendScopeArray{
    if (!_datasoureSendScopeArray) {
        self.datasoureSendScopeArray = [NSMutableArray array];
    }
    return _datasoureSendScopeArray;
}

-(NSMutableArray *)datasourSendToServerScopeArray{
    if (!_datasourSendToServerScopeArray) {
        self.datasourSendToServerScopeArray = [NSMutableArray array];
    }
    return _datasourSendToServerScopeArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"发送范围"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发  送" style:(UIBarButtonItemStyleDone) target:self action:@selector(chageColor)];
    
    [self gitMessageAboutGiveNotices];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.separatorColor = [UIColor orangeColor];
//    _tableView.separatorInset = UIEdgeInsetsMake(0, 40, 0, 0 );
    _tableView.rowHeight = 60;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;
    [self.view addSubview:_tableView];
    self.tableView.allowsMultipleSelectionDuringEditing=YES;
}

-(void)chageColor{
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    if ([self.datasourSendToServerScopeArray count] > 0) {
        [self sendSendScopeToServer];
    } else{
        [self alert:@"请选择发送范围"];
    }
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.datasourSendToServerScopeArray addObject:self.datasoureKeysSendScopeArray[indexPath.row]];
    
}
//取消选中时 将存放在self.deleteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [self.datasourSendToServerScopeArray removeObject:self.datasoureKeysSendScopeArray[indexPath.row]];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //6
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasoureKeysSendScopeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    cell.textLabel.text = [self.datasoureSendScopeArray[indexPath.row] objectForKey:self.datasoureKeysSendScopeArray[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


-(void)gitMessageAboutGiveNotices{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/message/scope", CONST_SERVER_ADDRESS]];
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
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5002) {
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                        [self setDataToDatasoureSendScopeArray:array1];
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                }
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
}


-(void)setDataToDatasoureSendScopeArray:(NSMutableArray *)mArray{
    self.datasoureSendScopeArray = mArray ;
    NSMutableArray * mutabelAry = [NSMutableArray new];
    for (NSDictionary * dict in mArray) {
        NSMutableString * testStr = [NSMutableString stringWithFormat:@"%@",[dict allKeys]];
        if (testStr.length < 11) {
            NSRange range = NSMakeRange(6, 2) ;
            NSString *subStr3 = [testStr substringWithRange:range];
            [mutabelAry addObject:subStr3];
        }else if (testStr.length > 10) {
            NSRange range = NSMakeRange(6, 3) ;
            NSString *subStr3 = [testStr substringWithRange:range];
            [mutabelAry addObject:subStr3];
        }else if (testStr.length > 11) {
            NSRange range = NSMakeRange(6, 4) ;
            NSString *subStr3 = [testStr substringWithRange:range];
            [mutabelAry addObject:subStr3];
        }
    }
    self.datasoureKeysSendScopeArray = mutabelAry;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView  reloadData];
    });
}


-(void)sendSendScopeToServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/message/store", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:self.datasourSendToServerScopeArray forKey:@"scope"];
    [mdict setObject:self.sendMessage forKey:@"content"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ( [[dict objectForKey:@"message"] intValue] == 5004 ) {
                                                    [self alert:[NSString stringWithFormat:@"发送通知成功"]];
                                                }
                                            } else{
                                                NSLog(@"获取数据失败");
                                            }
                                        }];
    [task resume];
}


-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
        if ([title isEqualToString:@"发送通知成功"]) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                NSLog(@"Class:%@", [controller class]);
                if ([controller isKindOfClass:[AppTBViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"222222222222222222222222");
}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"2111111111111111111111111");
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
