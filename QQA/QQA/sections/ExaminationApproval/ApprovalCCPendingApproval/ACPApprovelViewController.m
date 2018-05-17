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
#import "Request.h"
#import "RequestTableViewCell.h"
#import "RequestAndLeaveDetailsViewController.h"
#import "RequestLeaveDetailViewController.h"

@interface ACPApprovelViewController ()
@property (nonatomic, strong) NSMutableArray * datasouceArray;
@property (nonatomic, strong) ACPApprovalListView * aCPApprovalListView;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) int pageNum;
@end

@implementation ACPApprovelViewController

static NSString *identifier = @"Cell";
static NSString *identifierOne = @"Cell";

-(void)loadView{
    
    self.aCPApprovalListView = [[ACPApprovalListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.aCPApprovalListView.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);;
    self.view = _aCPApprovalListView;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadNewData];
}
-(void)loadNewData
{
    self.isDownRefresh = YES;
    if (self.pageNum > 1) {
        [self loadDataAndShowWithPageNum:--self.pageNum];
    } else{
        [self loadDataAndShowWithPageNum:1];
    }
    [self.aCPApprovalListView.tableView.mj_header endRefreshing];
}
-(void)loadMoreData
{
    self.isDownRefresh = NO;
    [self loadDataAndShowWithPageNum:++self.pageNum];
    [self.aCPApprovalListView.tableView.mj_footer endRefreshing];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, _urlStr]];
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
    if ([_titleStr isEqualToString:@"待审批的"]) {
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"ToBeApprovedOfOthers" forKey:@"status"];
        [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"已通过的"]) {
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"HaveBeenApprovedOfAll" forKey:@"status"];
        [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"未通过的"]) {
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"UnapprovedOfOwn" forKey:@"status"];
        [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"抄送我的"]) {
        [mdict setObject:@"2" forKey:@"type"];
        [mdict setObject:@"CopyedOfOthers" forKey:@"status"];
        [mdict setObject:[NSString stringWithFormat:@"%d", page] forKey:@"pageNum"];
    }
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
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6005 || [[dictArray[0] objectForKey:@"message"] intValue] == 6017 ) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                        [self.datasouceArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            ACPApproval * aCPApproval = [ACPApproval new];
                                                            [aCPApproval setValuesForKeysWithDictionary:dict];
                                                            [self.datasouceArray addObject:aCPApproval];
                                                            
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.aCPApprovalListView.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6006 ){
                                                        if (_pageNum > 1) {
                                                            self.isEmpty = NO;
                                                            return ;
                                                        }
                                                        self.isEmpty = YES;
                                                        [self.datasouceArray removeAllObjects];
                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.aCPApprovalListView.tableView  reloadData];
                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                [self.datasouceArray removeAllObjects];
                                                [self.datasouceArray addObject:@"获取数据失败"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.aCPApprovalListView.tableView  reloadData];
                                                });
                                            }
                                        }];
    [task resume];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNum = 1;
    self.isDownRefresh = NO;
    [self.navigationItem setTitle:_titleStr];
    self.datasouceArray = [NSMutableArray arrayWithCapacity:1];
    self.aCPApprovalListView.tableView.delegate = self;
    self.aCPApprovalListView.tableView.dataSource = self;
    if ([_urlStr isEqualToString:@"/v1/api/leave/index"]){
         [self.aCPApprovalListView.tableView registerClass:[ACPApprovalTableViewCell class] forCellReuseIdentifier:identifier];
    } else{
        [self.aCPApprovalListView.tableView registerClass:[RequestTableViewCell class] forCellReuseIdentifier:identifierOne];
    }
    self.aCPApprovalListView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.aCPApprovalListView.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    if ([_urlStr isEqualToString:@"/v1/api/leave/index"] && !_isEmpty){
        ACPApprovalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[ACPApprovalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
        }
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        cell.aCPApproval = approval;
        switch (indexPath.row % 10) {
            case 0:
                cell.userFamily.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                break;
            case 1:
                cell.userFamily.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                break;
            case 2:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                break;
            case 3:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                break;
            case 4:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                break;
            case 5:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 37/ 255.0 green:155 / 255.0 blue: 35 / 255.0 alpha:1];
                break;
                
            case 6:
                cell.userFamily.backgroundColor = [UIColor colorWithRed:0 green:151 / 255.0 blue: 136 / 255.0 alpha:0.8];
                break;
            case 7:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 238/ 255.0 green:23 / 255.0 blue: 39 / 255.0 alpha:1];
                break;
                
            case 8:
                cell.userFamily.backgroundColor = [UIColor colorWithRed: 254/ 255.0 green:65 / 255.0 blue: 129 / 255.0 alpha:1];
                break;
                
            case 9:
                cell.userFamily.backgroundColor = [UIColor colorWithRed:62/ 255.0 green:80 / 255.0 blue: 182 / 255.0 alpha:1];
                break;
            default:
                break;
        }
        return cell;
    }else if ([_urlStr isEqualToString:@"/v1/api/ask/index"] && !_isEmpty ){
        RequestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierOne forIndexPath:indexPath];
        if (!cell) {
            cell = [[RequestTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifierOne] ;
        }
        Request * request = self.datasouceArray[indexPath.row];
        cell.request = request;
        return cell;
    } else {
        UITableViewCell * acell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!acell) {
            acell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        acell.textLabel.text = self.datasouceArray[indexPath.row];
        acell.textLabel.textAlignment = NSTextAlignmentCenter;
        return acell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEmpty) {
        NSLog(@"暂时没有数据");
    }else if([_titleStr isEqualToString:@"待审批的" ]  && [_urlStr isEqualToString:@"/v1/api/leave/index"]){
        RequestAndLeaveDetailsViewController * detailVC = [[RequestAndLeaveDetailsViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveIdStr =  approval.leaveId;
        detailVC.titleIdentStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/show";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"待审批的" ]  && [_urlStr isEqualToString:@"/v1/api/ask/index"]){
        RequestAndLeaveDetailsViewController * detailVC = [[RequestAndLeaveDetailsViewController alloc] init];
        Request * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveIdStr =  approval.askId;
        detailVC.titleIdentStr = @"请示件";
        detailVC.urlStr = @"/v1/api/ask/show";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"已通过的"] && [_urlStr isEqualToString:@"/v1/api/leave/index"]){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.leaveId;
        detailVC.titleStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/index";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"已通过的"] && [_urlStr isEqualToString:@"/v1/api/ask/index"]){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        Request * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.askId;
        detailVC.titleStr = @"请示件";
        detailVC.urlStr = @"/v1/api/ask/show";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"未通过的"]  && [_urlStr isEqualToString:@"/v1/api/leave/index"] ){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.leaveId;
        detailVC.titleStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/index";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"未通过的"]  && [_urlStr isEqualToString:@"/v1/api/ask/index"] ){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        Request * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.askId;
        detailVC.titleStr = @"请示件";
        detailVC.urlStr = @"/v1/api/ask/show";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"抄送我的"]  && [_urlStr isEqualToString:@"/v1/api/ask/index"] ){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        Request * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.askId;
        detailVC.titleStr = @"请示件";
        detailVC.urlStr = @"/v1/api/ask/show";
        [self.navigationController pushViewController:detailVC animated:NO];
    }else if([_titleStr isEqualToString:@"抄送我的"]  && [_urlStr isEqualToString:@"/v1/api/leave/index"] ){
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.leaveId;
        detailVC.titleStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/index";
        [self.navigationController pushViewController:detailVC animated:NO];
    }
}

-(NSString *)tepyOfLeave:(NSString *)str{
    if ([str isEqualToString:@"100"]) {
        return  @"调休";
    } else if ([str isEqualToString:@"101"]){
        return  @"年假";
    } else if ([str isEqualToString:@"102"]){
        return @"婚假";
    } else if ([str isEqualToString:@"103"]){
        return  @"产假";
    } else if ([str isEqualToString:@"104"]){
        return  @"病假";
    } else if ([str isEqualToString:@"105"]){
        return @"事假";
    } else if ([str isEqualToString:@"106"]){
        return @"丧假";
    } else if ([str isEqualToString:@"107"]){
        return  @"工伤假";
    } else if ([str isEqualToString:@"108"]){
        return @"外出";
    } else if ([str isEqualToString:@"108"]){
        return @"其他";
    }
    return @"其他";
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
