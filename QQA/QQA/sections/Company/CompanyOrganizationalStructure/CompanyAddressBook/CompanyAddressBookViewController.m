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
    self.addressBooKListView.tableView.frame = [UIScreen mainScreen].bounds;
    self.view = _addressBooKListView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"_departmentName:%@,%@", _departmentName, _departmentId);
    
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

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/company/department/users", CONST_SERVER_ADDRESS]];
    NSLog(@"url%@", url);
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];
    [mdict setObject:_departmentId forKey:@"departmentId"];
    
    NSLog( @"66666666%@", mdict);
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    NSLog(@"1234567dictArray: %@,\n ", dictArray);
                                                    
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 7006 ) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        [array1 removeObjectAtIndex:0];
                                                        [self.datasouceArray removeAllObjects];
                                                        for (NSDictionary * dict in array1) {
                                                            NSLog(@"%@\n\n", dict);
                                                            AddressBook * addressBook = [AddressBook new];
                                                            [addressBook setValuesForKeysWithDictionary:dict];
                                                            [self.datasouceArray addObject:addressBook];
                                                            NSLog(@"%@\n\n%@", dict, self.datasouceArray);
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            NSLog(@"self.datasouceArray222%@", self.datasouceArray );
                                                            [self.addressBooKListView.tableView  reloadData];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    NSLog(@"7777777dict: %@,\n ", dict);
                                                    
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
                                                NSLog(@"获取数据失败，问");
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
    return  self.datasouceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_isEmpty){
        
        AddressBooKTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[AddressBooKTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
        }
        AddressBook * addressBook = self.datasouceArray[indexPath.row];
        cell.addressBook = addressBook;
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
