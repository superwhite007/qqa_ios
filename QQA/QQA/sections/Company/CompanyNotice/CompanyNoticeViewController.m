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
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
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
    [request setValue:resultDicAccess[@"accessToken"] forHTTPHeaderField:@"Authorization"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    [mdict setObject:@"1" forKey:@"pageNum"];
//    NSLog(@"mdict:%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5005 ) {
                                                    NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                    [array1 removeObjectAtIndex:0];
                                                    [_datasource removeAllObjects];
                                                    for (NSDictionary * dict in array1) {
                                                        [_datasource addObject:[NSString stringWithFormat:@"%@\n\n        %@",[dict objectForKey:@"createdAt"], [dict objectForKey:@"content"]]];
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.tableView  reloadData];
                                                     });
                                                }
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return  [self gitHightForCell:indexPath] + 20;
}



//8 取消注释
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    _tableView.separatorColor = [UIColor blackColor];
    cell.textLabel.text = self.datasource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.numberOfLines = 0;//表示label可以多行显示
    cell.textLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [cell.textLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : cell.textLabel.font} context:nil];
    cell.textLabel.frame = CGRectMake(30, 340, iphoneWidth - 40, CGRectGetHeight(targetRect));
    return cell;
}


-(long)gitHightForCell:(NSIndexPath *)indexPathRow{
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(30 , 340, iphoneWidth - 60 , 120)];
    mattersNeedAttentionExplianLable.text = self.datasource[indexPathRow.row];
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [mattersNeedAttentionExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : mattersNeedAttentionExplianLable.font} context:nil];
    mattersNeedAttentionExplianLable.frame = CGRectMake(30, 340, iphoneWidth - 40, CGRectGetHeight(targetRect));
    return  targetRect.size.height;
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
