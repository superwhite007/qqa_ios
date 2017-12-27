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

@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSMutableArray * datasouceArray;
@property (nonatomic, strong) ACPApprovalListView * aCPApprovalListView;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) BOOL isEmpty;

@end

@implementation ACPApprovelViewController

static NSString *identifier = @"Cell";
static NSString *identifierOne = @"Cell";

-(void)loadView{
    self.aCPApprovalListView = [[ACPApprovalListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.aCPApprovalListView.tableView.frame = [UIScreen mainScreen].bounds;
    self.view = _aCPApprovalListView;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadNewData];
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
    NSLog(@"_titleSt:%@", _titleStr);
    if ([_titleStr isEqualToString:@"待审批的"]) {
        NSLog(@"_titleSt111:%@", _titleStr);
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"ToBeApprovedOfOthers" forKey:@"status"];
        [mdict setObject:@"1" forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"已审批的"]) {
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"HaveBeenApprovedOfAll" forKey:@"status"];
        [mdict setObject:@"1" forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"未审批的"]) {
        [mdict setObject:@"1" forKey:@"type"];
        [mdict setObject:@"HaveBeenApprovedOfAll" forKey:@"status"];
        [mdict setObject:@"1" forKey:@"pageNum"];
    } else if ([_titleStr isEqualToString:@"抄送我的"]) {
        [mdict setObject:@"2" forKey:@"type"];
        [mdict setObject:@"HaveBeenApprovedOfAll" forKey:@"status"];
        [mdict setObject:@"1" forKey:@"pageNum"];
    }
    
//    NSLog(@"55555555%@%@", CONST_SERVER_ADDRESS, _urlStr);
//    NSLog( @"66666666%@", mdict);
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
//                                                    NSLog(@"1234567dictArray: %@,\n ", dictArray);
                                                    
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6005 ) {
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
                                                    }else if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6017 ) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
//                                                        NSLog(@"\n\narray1: %@,\n ", array1);
                                                        [self.datasouceArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            Request * request = [Request new];
                                                            [request setValuesForKeysWithDictionary:dict];
                                                            [self.datasouceArray addObject:request];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.aCPApprovalListView.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                    NSLog(@"1234567dict: %@,\n ", dict);
                                                    
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6006 ){
                                                        self.isEmpty = YES;
                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.aCPApprovalListView.tableView  reloadData];
                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                //NSLog(@"获取数据失败，问");
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
    self.pageNumber = 1;
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
        
    }else if([_titleStr isEqualToString:@"已审批的"] && [_urlStr isEqualToString:@"/v1/api/leave/index"]){
        
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.leaveId;
        detailVC.titleStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/index";
        [self.navigationController pushViewController:detailVC animated:NO];
        
    }else if([_titleStr isEqualToString:@"已审批的"] && [_urlStr isEqualToString:@"/v1/api/ask/index"]){
        
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        Request * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.askId;
        detailVC.titleStr = @"请示件";
        detailVC.urlStr = @"/v1/api/ask/show";
        [self.navigationController pushViewController:detailVC animated:NO];
        
    }else if([_titleStr isEqualToString:@"未审批的"]  && [_urlStr isEqualToString:@"/v1/api/leave/index"] ){
        
        RequestLeaveDetailViewController * detailVC = [[RequestLeaveDetailViewController alloc] init];
        ACPApproval * approval = self.datasouceArray[indexPath.row];
        detailVC.leaveOrAskId =  approval.leaveId;
        detailVC.titleStr = @"请假";
        detailVC.urlStr = @"/v1/api/leave/index";
        [self.navigationController pushViewController:detailVC animated:NO];
        
    }else if([_titleStr isEqualToString:@"未审批的"]  && [_urlStr isEqualToString:@"/v1/api/ask/index"] ){
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
