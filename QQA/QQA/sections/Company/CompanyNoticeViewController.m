//
//  CompanyNoticeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyNoticeViewController.h"

@interface CompanyNoticeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * datasource;

@end



@implementation CompanyNoticeViewController

static NSString *identifier = @"Cell";

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
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
//    _tableView.rowHeight = 60;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    [self.datasource addObject:@"1"];
//    [self.datasource addObject:@"2"];
//    [self.datasource addObject:@"3"];
    
    [self gitCompanyNoticeMessage];
    
    
}





-(void)gitCompanyNoticeMessage{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/message/index", CONST_SERVER_ADDRESS]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    [mdict setObject:@"1" forKey:@"pageNum"];
    
    NSLog(@"mdict:%@", mdict);
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
                                                NSLog(@"companyNOtice: %@,\n %@\n", dictArray, [dictArray[0] objectForKey:@"message"]);
                                                
                                                if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5005 ) {
                                                    NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                    [array1 removeObjectAtIndex:0];
                                                    
                                                    for (NSDictionary * dict in array1) {
                                                        [_datasource addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"createdAt"]]];
                                                        [_datasource addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"content"]]];
                                                    
//                                                        
                                                    }
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        NSLog(@"_datasource_datasource_datasource_datasource%@", _datasource);
                                                        [self.tableView  reloadData];
                                                     });

                                                }
                                                
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}












#pragma mark - Table view data source

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
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2 == 0) {
        return 30;
    } else{
       return  [self gitHightForCell:indexPath.row] + 30;
    }
    
    
}



//8 取消注释
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
    }
    
    if (indexPath.row % 2 == 0) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter ;
        _tableView.separatorColor = [UIColor whiteColor];
    } else if(indexPath.row % 2 == 1){
        _tableView.separatorColor = [UIColor blackColor];
    }
    
    cell.textLabel.text = self.datasource[indexPath.row];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
    
    
    return cell;
}



-(long)gitHightForCell:(int)indexPathRow{
    
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(30 , 340, iphoneWidth - 60 , 120)];
    mattersNeedAttentionExplianLable.text = self.datasource[indexPathRow];
    
    
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [mattersNeedAttentionExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : mattersNeedAttentionExplianLable.font} context:nil];
    mattersNeedAttentionExplianLable.frame = CGRectMake(30, 340, iphoneWidth - 40, CGRectGetHeight(targetRect));
    
    return  CGRectGetHeight(targetRect);
    
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
