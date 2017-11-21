//
//  SendTheScopeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/21.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "SendTheScopeViewController.h"

@interface SendTheScopeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * datasoureSendScopeArray;
@property (nonatomic, strong) NSMutableArray * datasourSendToServerScopeArray;

@end

@implementation SendTheScopeViewController




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
    
    //NSLog(@"_sendMessag_sendMessag:%@", _sendMessage);
    
    [self gitMessageAboutGiveNotices];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.separatorColor = [UIColor orangeColor];
//    _tableView.separatorInset = UIEdgeInsetsMake(0, 40, 0, 0 );
    _tableView.rowHeight = 60;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    
    
    
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //6
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //7表视图应该以其对应的数组为导向，数组元素个数决定了表视图的行数，不再是固定的行数
    return self.datasoureSendScopeArray.count;
}

//8 取消注释
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        
//        //if语句中可以为单元格中一些通用的属性赋值，例如可以在其辅助视图类型赋值,标示所有单元格都一直
//        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
//    cell.textLabel.text = self.datasoureSendScopeArray[indexPath.row] ;
    return cell;
    
}








-(void)gitMessageAboutGiveNotices{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/message/scope"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    
    //NSLog(@"resultDic, resultDicAccess:%@, %@", resultDic, resultDicAccess);
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            //                                            //NSLog(@"response, error :%@, %@", response, error);
                                            //                                            //NSLog(@"data:%@", data);
                                            
                                            if (data != nil) {
                                                
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"MessageViewControllerdict: %@", dictArray);
//                                                NSString * str =[NSString stringWithFormat:@"%@", [dictArray[0] objectForKey:@"message"]];
//                                                
                                                
                                                if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5002 ) {
                                                    NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                    [array1 removeObjectAtIndex:0];
                                                    
                                                    [self setDataToDatasoureSendScopeArray:array1];
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self setDatasoureSendScopeArray:array1];
                                                         [self.tableView  reloadData];
                                                    
                                                    });
                                                   
                                                }
                                              
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}


-(void)setDataToDatasoureSendScopeArray:(NSMutableArray *)mArray{
    self.datasoureSendScopeArray = mArray ;
    NSLog(@"mArray:&%@", mArray);
   
    
}

-(void)setDataToDatasourSendToServerScopeArray:(NSMutableArray *)mToServerArray{
    
    
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
