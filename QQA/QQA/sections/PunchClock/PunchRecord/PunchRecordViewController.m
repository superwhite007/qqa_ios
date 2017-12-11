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

//全局的静态重用标志符
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
    // Do any additional setup after loading the view.
//    [self.datasource addObject:@"test1"];
//    [self.datasource addObject:@"test2"];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<主页" style:UIBarButtonItemStyleDone target:self action:@selector(returnBack)] ;
    
    
    self.pageNum = 1;
    self.isDownRefresh = NO;
    
    self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.aTableView.separatorColor = [UIColor orangeColor];
    
    //04设置分割线的内边距(上、左，下，右)
    //aTableView.separatorInset = UIEdgeInsetsMake(0, 40, 0, 0 );
    
    //05设置行高
    self.aTableView.rowHeight = 60;
    
    
    //07为tableView 指定数据源代理
    self.aTableView.dataSource =self;
    
    //14为tableView指定代理对象，做外管控制
    self.aTableView.delegate = self;
    
    //02添加对象
    [self.view addSubview:self.aTableView];
    [self.aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.aTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.aTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    
    
    
    
}


//-(void)loadNewData{
//
//    [self punchRecoret];
//
//}

-(void)loadNewData
{
    //记录是下拉刷新
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
    NSLog(@"page%d", page);
    
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
    
    [request setValue:resultDicAccess[@"access_token"] forHTTPHeaderField:@"Authorization"];
    
    [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    [mdict setObject:@"IOS_APP" forKey:@"client_type"];
    
//    NSLog(@"mdict:%@", mdict);
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          
                                            if (data != nil) {
                                                
                                                NSArray *array1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSMutableArray * array = [[NSMutableArray alloc] initWithArray:array1];
                                                
//                                                NSLog(@"PunchRecord111111:%@", array);

                                                
                                                NSDictionary * firDict = array[0];
                                                NSString * str  = [NSString stringWithFormat:@"%@", [firDict objectForKey:@"message"]];
                                                if ([str isEqualToString:@"3004" ]) {
                                                    
                                                    [array removeObjectAtIndex:0];
                                                    
//                                                    NSLog(@"PunchRecord1:%@", array);

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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    return self.datasource.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    
    //NSLog(@"cell:%@",[self.datasource[indexPath.row]  objectForKey:@"clock_time"]);
    cell.textLabel.text = [self.datasource[indexPath.row]  objectForKey:@"clock_time"];
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
