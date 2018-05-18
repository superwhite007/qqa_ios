//
//  PunchRecordViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/6.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "PunchRecordViewController.h"

@interface PunchRecordViewController ()

@property (nonatomic, strong)NSMutableArray *datasource;
//@property (nonnull, strong) UITableView *aTableView;

@property (nonatomic, assign) int pageNum;
@property (nonatomic, assign) BOOL isDownRefresh;


@end

@implementation PunchRecordViewController


static NSString *identifier = @"Cell";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadNewData];
//     [self punchRecoret];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.aTableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.aTableView.separatorColor = [UIColor orangeColor];
    self.aTableView.rowHeight = 60;
    self.aTableView.dataSource =self;
    self.aTableView.delegate = self;
    [self.view addSubview:self.aTableView];
    [self.aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.aTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.aTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}


-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self punchRecoret:--self.pageNum];
    } else{
        [self punchRecoret:1];
    }
    [self.aTableView.mj_header endRefreshing];
}

-(void)loadMoreData
{
    //记录不是下拉刷新
    self.isDownRefresh = NO;
    [self punchRecoret:++self.pageNum];
    [self.aTableView.mj_footer endRefreshing];
}

-(void)punchRecoret:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/attendance/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                NSArray *array1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSMutableArray * array = [[NSMutableArray alloc] initWithArray:array1];
                                                NSDictionary * firDict = array[0];
                                                NSString * str  = [NSString stringWithFormat:@"%@", [firDict objectForKey:@"message"]];
                                                if ([str isEqualToString:@"3004" ]) {
                                                    [array removeObjectAtIndex:0];
                                                    [self.datasource removeAllObjects];
                                                    self.datasource = array;
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                    self.datasource = array;
                                                    [self.aTableView reloadData];
                                                    });
                                                }
                                            } else{
                                                //NSLog(@"获取数据失败，问李鹏");
                                            }
                                        }];
    [task resume];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"打卡时间：%@   成功",[self.datasource[indexPath.row]  objectForKey:@"clockTime"]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //添加动画效果
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
    
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
