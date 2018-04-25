//
//  CompanyOrganizationalStructureViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyOrganizationalStructureViewController.h"
#import "CompanyOrganizationalStructure.h"
#import "CompanyOrganizationalStructureTableViewCell.h"
#import "CompanyOrganizationalStructureListView.h"

#import "CompanyAddressBookViewController.h"

@interface CompanyOrganizationalStructureViewController ()

@property (nonatomic, strong) CompanyOrganizationalStructureListView * organizationalStructureListView;
@property (nonatomic, strong) NSMutableArray * datasouceArray;
@property (nonatomic, assign) BOOL isEmpty;


@end

@implementation CompanyOrganizationalStructureViewController


static NSString *identifier = @"Cell";

-(NSMutableArray *)datasouceArray{
    if (!_datasouceArray) {
        self.datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

-(void)loadView{
    self.organizationalStructureListView = [[CompanyOrganizationalStructureListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.organizationalStructureListView.tableView.frame = [UIScreen mainScreen].bounds;
    self.view = _organizationalStructureListView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationItem setTitle:@"组织架构"];
    [self loadNewData];
    self.organizationalStructureListView.tableView.delegate = self;
    self.organizationalStructureListView.tableView.dataSource = self;
    self.organizationalStructureListView.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [self.organizationalStructureListView.tableView registerClass:[CompanyOrganizationalStructureTableViewCell class] forCellReuseIdentifier:identifier];
}

-(void)viewWillAppear:(BOOL)animated{
//    [self loadNewData];
}

-(void)loadNewData{
    [self loadDataAndShowWithPageNum:1];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/company/departments", CONST_SERVER_ADDRESS]];
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
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 7004 ) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                        [self.datasouceArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            CompanyOrganizationalStructure * organizationalStructure = [CompanyOrganizationalStructure new];
                                                            [organizationalStructure setValuesForKeysWithDictionary:dict];
                                                            [self.datasouceArray addObject:organizationalStructure];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.organizationalStructureListView.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6006 ){
                                                        self.isEmpty = YES;
                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            [self.aCPApprovalListView.tableView  reloadData];
                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                NSLog(@"获取数据失败");
                                                [self.datasouceArray addObject:@"获取数据失败"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    [self.aCPApprovalListView.tableView  reloadData];
                                                });
                                            }
                                        }];
    [task resume];
}

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
    if (!_isEmpty){
        CompanyOrganizationalStructureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[CompanyOrganizationalStructureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
        }
        CompanyOrganizationalStructure * organizationalStructure = self.datasouceArray[indexPath.row];
        cell.companyOrganizationalStructure = organizationalStructure;
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
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (_isEmpty) {
        NSLog(@"暂时没有数据");
    }
    CompanyAddressBookViewController * addressBookVC = [[CompanyAddressBookViewController alloc] init];
    CompanyOrganizationalStructure * organizationalStructure = self.datasouceArray[indexPath.row];
    addressBookVC.departmentName = organizationalStructure.name;
    addressBookVC.departmentId = organizationalStructure.departmentId;
    [self.navigationController pushViewController:addressBookVC animated:YES];
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
