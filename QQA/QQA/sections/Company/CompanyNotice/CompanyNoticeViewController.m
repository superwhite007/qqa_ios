//
//  CompanyNoticeViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyNoticeViewController.h"
#import "ReadunreadVC.h"
@interface CompanyNoticeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * datasource;
@property (nonatomic, strong) NSMutableArray * allDatasourceMArray;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) BOOL isEmpty;

@end

@implementation CompanyNoticeViewController

static NSString *identifier = @"Cell";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
-(NSMutableArray *)allDatasourceMArray{
    if (!_allDatasourceMArray) {
        _allDatasourceMArray = [NSMutableArray array];
    }
    return _allDatasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadNewData];
}
-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self gitCompanyNoticeMessage:--self.pageNum];
    } else{
        [self gitCompanyNoticeMessage:1];
    }
    [self.tableView.mj_header endRefreshing];
}
-(void)loadMoreData
{
    self.isDownRefresh = NO;
    [self gitCompanyNoticeMessage:++self.pageNum];
    [self.tableView.mj_footer endRefreshing];
}

-(void)gitCompanyNoticeMessage:(int)page{
    
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
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
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
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 5005 ) {
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        self.isEmpty = NO;
                                                        [array1 removeObjectAtIndex:0];
                                                        _allDatasourceMArray = array1;
                                                        [_datasource removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            [_datasource addObject:[NSString stringWithFormat:@"%@ %@\n\n        %@",[dict objectForKey:@"sender"],[dict objectForKey:@"createdAt"], [dict objectForKey:@"content"]]];//sender
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                        });
                                                    }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                            if ( [[dict objectForKey:@"message"] intValue] == 5006 ){
                                                                self.isEmpty = YES;
                                                                [self.datasource addObject:@"暂时没有相关内容"];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView  reloadData];
                                                                });
                                                            }
                                                        }
                                                    }
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                                self.isEmpty = YES;
                                                [self.datasource addObject:@"暂时没有相关内容"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.tableView  reloadData];
                                                });
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isEmpty){
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    _tableView.separatorColor = [UIColor blackColor];
    cell.textLabel.text = self.datasource[indexPath.row];
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
        
    cell.textLabel.numberOfLines = 0;//表示label可以多行显示
    cell.textLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [cell.textLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : cell.textLabel.font} context:nil];
    cell.textLabel.frame = CGRectMake(30, 340, iphoneWidth - 40, CGRectGetHeight(targetRect));
    return cell;
    } else{
        UITableViewCell * acell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!acell) {
            acell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        acell.textLabel.text = self.datasource[indexPath.row];
        acell.textLabel.textAlignment = NSTextAlignmentCenter;
        return acell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadunreadVC * readunreadVC = [ReadunreadVC new];
    readunreadVC.uniqueStr = [_allDatasourceMArray[indexPath.row] objectForKey:@"unique"];
    [self.navigationController pushViewController:readunreadVC animated:YES];
    
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
