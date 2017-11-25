//
//  ACPApprovelViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/24.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "ACPApprovelViewController.h"
#import "ACPApproval.h"
#import "ACPApprovalListView.h"
#import "ACPApprovalTableViewCell.h"


@interface ACPApprovelViewController ()

@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSMutableArray * datasouceArray;
@property (nonatomic, strong) ACPApprovalListView * aCPApprovalListView;
@property (nonatomic, assign) BOOL isDownRefresh;

@end

@implementation ACPApprovelViewController

static NSString *identifier = @"Cell";

-(void)loadView{
    self.aCPApprovalListView = [[ACPApprovalListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _aCPApprovalListView;
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [self loadNewData];
    //获取数据
}
-(void)loadNewData
{
    //记录是下拉刷新
    self.isDownRefresh = YES;
    [self loadDataAndShowWithPageNum:1];
//    [self.foodListView.tableView.header endRefreshing];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.19.12.6/v1/api/message/index"]];
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
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                
                                                NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"companyNOtice: %@,\n %@\n", dictArray, [dictArray[0] objectForKey:@"message"]);
                                                
                                                /*for (NSDictionary * foodDic in dishsArray) {
                                                    Food * foodModel = [Food new]  ;
                                                    [foodModel setValuesForKeysWithDictionary:foodDic];
                                                    [self.dataSourceArray addObject:foodModel];
                                                    [foodModel release];
                                                    
                                                }
                                                [self.foodListView.tableView reloadData]; */
                                                
                        
                                                if ( [[dictArray[0] objectForKey:@"messages"] intValue] == 5005 ) {
                                                    NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                    [array1 removeObjectAtIndex:0];
                                                    
                                                    for (NSDictionary * dict in array1) {
                                                        ACPApproval * aCPApproval = [ACPApproval new];
                                                        [ACPApproval setValuesForKeysWithDictionary:dict];
                                                        [self.datasouceArray addObject:aCPApproval];
                               
//                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.aCPApprovalListView.tableView  reloadData];
//                                                    });
//
                                                    }
                                                }
                                                
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
    
}
    
    
    /*
     
    NSString * str = [_tname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlStr = [NSString stringWithFormat:@"http://api.xiangha.com/so5/getSoData/?type=caipu&s=%@&page=%d",str,page];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            if (self.isDownRefresh) {
                [self.dataSourceArray removeAllObjects];
            }
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dictdictdictdict%@", dict);
            NSDictionary * dataDic = dict[@"data"];
            NSArray * dishsArray = dataDic[@"dishs"];
            for (NSDictionary * foodDic in dishsArray) {
                Food * foodModel = [Food new]  ;
                [foodModel setValuesForKeysWithDictionary:foodDic];
                [self.dataSourceArray addObject:foodModel];
                [foodModel release];
                
            }
            [self.foodListView.tableView reloadData];
        }
        else
        {
            
            [AFAppDotNetAPIClient sharedClient];
            
        }
        
    }];
    
    */
    







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNumber = 1;
    self.isDownRefresh = NO;
    
    self.datasouceArray = [NSMutableArray arrayWithCapacity:1];
    
    [self.datasouceArray addObject:@"1"];
    [self.datasouceArray addObject:@"2"];
    [self.datasouceArray addObject:@"3"];
    [self.datasouceArray addObject:@"4"];
    [self.datasouceArray addObject:@"5"];
    
    self.aCPApprovalListView.tableView.delegate = self;
    self.aCPApprovalListView.tableView.dataSource = self;
    
    
    [self.aCPApprovalListView.tableView registerClass:[ACPApprovalTableViewCell class] forCellReuseIdentifier:identifier];
    
    
    
    
}



#pragma mark - DATASOURCES
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACPApprovalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ACPApprovalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] ;
    }
    
    
//    //添加动画效果
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
    
    
//    Food * food1 = self.dataSourceArray[indexPath.row];
//    cell.food = food1;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FoodDetailViewController * detailVC = [[[FoodDetailViewController alloc] init] autorelease];
//    detailVC.food = self.dataSourceArray[indexPath.row];
//    detailVC.dCode = ((Food *)self.dataSourceArray[indexPath.row]).code;
//
//    [self.navigationController pushViewController:detailVC animated:NO];
    NSLog(@"gotogotos");
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