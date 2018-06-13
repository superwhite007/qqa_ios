//
//  OneTaskDetailedListVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/6.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneTaskDetailedListVC.h"
#import "OneTasKStep.h"
#import "OneTasKStepTVCell.h"

@interface OneTaskDetailedListVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation OneTaskDetailedListVC

static  NSString  * identifier = @"CELL";

-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getOneTaskStepListFromServer];
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"任务步骤"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addTaskDetailed)];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[OneTasKStepTVCell class] forCellReuseIdentifier:identifier];
    
    
    
    
}
-(void)addTaskDetailed{
     self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.6];
}
-(void)getOneTaskStepListFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@//v1/api/v2/task/detail/index", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_taskIdStr forKey:@"taskId"];
    NSLog(@"7776%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                 NSLog(@"T1276543234565432:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 60003) {
                                                        NSLog(@"TaskList2:%@", dataBack);
                                                        [self.datasource removeAllObjects];
                                                        NSArray * dataListArray = [[dataBack objectForKey:@"data"] objectForKey:@"data_list"];
                                                        NSLog(@"dataListArray:%@", dataListArray);
                                                        for (NSDictionary * dict in dataListArray) {
                                                            OneTasKStep * oneTasKStep = [OneTasKStep new];
                                                            [oneTasKStep setValuesForKeysWithDictionary:dict];
                                                            [self.datasource addObject:oneTasKStep];
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

#pragma mark  tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OneTasKStepTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OneTasKStep * oneTasKStep = self.datasource[indexPath.row];
    cell.oneTasKStep = oneTasKStep;
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
    }    return cell;
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
