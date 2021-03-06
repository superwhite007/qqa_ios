//
//  CompanyAddressBookViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/5.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "CompanyAddressBookViewController.h"
#import "AddressBook.h"
#import "AddressBooKTableViewCell.h"
#import "AddressBooKListView.h"

#import "DetailOfPeopleINformationViewController.h"

@interface CompanyAddressBookViewController ()

@property (nonatomic, strong) AddressBooKListView * addressBooKListView;
@property (nonatomic, strong) NSMutableArray * datasouceArray;
@property (nonatomic, assign) BOOL isEmpty;

@end

@implementation CompanyAddressBookViewController

static NSString * identifier = @"cell";

-(NSMutableArray *)datasouceArray{
    if (!_datasouceArray) {
        self.datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

-(void)loadView{
    self.addressBooKListView = [[AddressBooKListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.addressBooKListView.tableView.frame = [UIScreen mainScreen].bounds;
    self.addressBooKListView.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self.view = _addressBooKListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.addressBooKListView.tableView.delegate = self;
    self.addressBooKListView.tableView.dataSource = self;
    [self.addressBooKListView.tableView registerClass:[AddressBooKTableViewCell class] forCellReuseIdentifier:identifier];
}


-(void)viewWillAppear:(BOOL)animated{
    [self loadNewData];
}

-(void)loadNewData{
    [self loadDataAndShowWithPageNum:1];
}

-(void)loadDataAndShowWithPageNum:(int)page{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/company/department/users", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:_departmentId forKey:@"departmentId"];
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
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 7006 ) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                        [self.datasouceArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            AddressBook * addressBook = [AddressBook new];
                                                            [addressBook setValuesForKeysWithDictionary:dict];
                                                            [self.datasouceArray addObject:addressBook];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.addressBooKListView.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 7005 ){
                                                        self.isEmpty = YES;
                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.addressBooKListView.tableView  reloadData];
                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                NSLog(@"获取数据失败");
                                                [self.datasouceArray addObject:@"获取数据失败"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                [self.addressBooKListView.tableView  reloadData];
                                                });
                                            }
                                        }];
    [task resume];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.datasouceArray.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_isEmpty){
        AddressBooKTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[AddressBooKTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
        }
        AddressBook * addressBook = self.datasouceArray[indexPath.row];
        cell.addressBook = addressBook;
        switch (indexPath.row % 10) {
            case 0:
                cell.shortName.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                break;
            case 1:
                cell.shortName.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                break;
            case 2:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                break;
            case 3:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                break;
            case 4:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                break;
            case 5:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 37/ 255.0 green:155 / 255.0 blue: 35 / 255.0 alpha:1];
                break;
                
            case 6:
                cell.shortName.backgroundColor = [UIColor colorWithRed:0 green:151 / 255.0 blue: 136 / 255.0 alpha:0.8];
                break;
            case 7:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 238/ 255.0 green:23 / 255.0 blue: 39 / 255.0 alpha:1];
                break;
                
            case 8:
                cell.shortName.backgroundColor = [UIColor colorWithRed: 254/ 255.0 green:65 / 255.0 blue: 129 / 255.0 alpha:1];
                break;
                
            case 9:
                cell.shortName.backgroundColor = [UIColor colorWithRed:62/ 255.0 green:80 / 255.0 blue: 182 / 255.0 alpha:1];
                break;
            default:
                break;
        }
        return cell;
        
    } else {
        UITableViewCell * acell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!acell) {
            acell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        acell.textLabel.text = self.datasouceArray[0];
        acell.textLabel.textAlignment = NSTextAlignmentCenter;
        return acell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isEmpty) {
        return;
    }else{
        DetailOfPeopleINformationViewController * addressBookVC = [[DetailOfPeopleINformationViewController alloc] init];
        AddressBook * addressBook = self.datasouceArray[indexPath.row];
        addressBookVC.userId = addressBook.userId;
//        addressBookVC.departmentName = organizationalStructure.name;
//        addressBookVC.departmentId = organizationalStructure.departmentId;
        [self.navigationController pushViewController:addressBookVC animated:YES];
    }
    
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
