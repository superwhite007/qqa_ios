//
//  ReadunreadVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/5.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "ReadunreadVC.h"
#import "Readunread.h"
#import "ReadunreadTVCell.h"

@interface ReadunreadVC ()

@property (nonatomic, strong) NSMutableArray * datasourceMArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ReadunreadVC

static NSString *identifier = @"Cell";

-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        _datasourceMArray = [NSMutableArray array];
    }
    return _datasourceMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self getReadUnreadPeoplesFromServer];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];;
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 60;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ReadunreadTVCell class] forCellReuseIdentifier:identifier];
    
}

#pragma delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceMArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadunreadTVCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[ReadunreadTVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    Readunread * readUnread = self.datasourceMArray[indexPath.row];
    NSLog(@"readUnread.username: %@", readUnread.username);
    cell.readUnread = readUnread;
    
    switch (indexPath.row % 10) {
        case 0:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
            break;
        case 1:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
            break;
        case 2:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
            break;
        case 3:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
            break;
        case 4:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
            break;
        case 5:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 37/ 255.0 green:155 / 255.0 blue: 35 / 255.0 alpha:1];
            break;
            
        case 6:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed:0 green:151 / 255.0 blue: 136 / 255.0 alpha:0.8];
            break;
        case 7:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 238/ 255.0 green:23 / 255.0 blue: 39 / 255.0 alpha:1];
            break;
            
        case 8:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed: 254/ 255.0 green:65 / 255.0 blue: 129 / 255.0 alpha:1];
            break;
            
        case 9:
            cell.shortUsernameLabel.backgroundColor = [UIColor colorWithRed:62/ 255.0 green:80 / 255.0 blue: 182 / 255.0 alpha:1];
            break;
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)getReadUnreadPeoplesFromServer{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/v2/message/count", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_uniqueStr forKey:@"unique"];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ([[dataBack objectForKey:@"message"] intValue] == 5007) {
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:[[dataBack objectForKey:@"data"] objectForKey:@"data_list"]];
                                                        NSLog(@"array1:%@", array1);
                                                        [self.datasourceMArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            NSLog(@"%@", dict);
                                                        Readunread * readUnread = [Readunread new];
                                                            [readUnread setValuesForKeysWithDictionary:dict];
                                                            [self.datasourceMArray addObject:readUnread];
                                                        }
                                                        
                                                        NSLog(@"%lu", (unsigned long)[self.datasourceMArray count]);
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
