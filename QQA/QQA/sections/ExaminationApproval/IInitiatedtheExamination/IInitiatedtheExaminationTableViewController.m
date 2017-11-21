//
//  IInitiatedtheExaminationTableViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiatedtheExaminationTableViewController.h"
#import "IInitiatedtheExaminationTableViewCell.h"
#import "IInitiated.h"

@interface IInitiatedtheExaminationTableViewController ()

@property (nonatomic, strong) NSMutableArray *datadource;
@end

@implementation IInitiatedtheExaminationTableViewController


static NSString * identifier = @"CELL";

-(NSMutableArray *)datadource{
    if (!_datadource) {
        self.datadource = [NSMutableArray array];
    }
    return _datadource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    ring * imageStr;
//    @property (nonatomic, strong) NSString * reasonTitleStr;
//    @property (nonatomic, strong) NSString * reasonStr;
//    @property (nonatomic, strong) NSString * promptStr;
//
    NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"请假", @"reasonStr":@"事假、病假.", @"promptStr":@"点击发起请假" };
    NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"请示件", @"reasonStr":@"重要事情不可以需要请示,不可先斩后奏！", @"prompet":@"点击发起请示件" };
    NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"工单", @"reasonStr":@"明确事情的经过.", @"promptStr":@"点击发起工单" };
    
    IInitiated * iinitated = [IInitiated new];
    [iinitated setValuesForKeysWithDictionary:dict];
    
    IInitiated * iinitated1 = [IInitiated new];
    [iinitated1 setValuesForKeysWithDictionary:dict1];
    
    IInitiated * iinitated2 = [IInitiated new];
    [iinitated2 setValuesForKeysWithDictionary:dict2];
    
    
    [self.datadource addObject:iinitated];
    [self.datadource addObject:iinitated1];
    [self.datadource addObject:iinitated2];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.datadource.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    IInitiatedtheExaminationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[IInitiatedtheExaminationTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:identifier];
    }
    

    NSDictionary * dict = self.datadource[indexPath.row];
    
    //NSLog(@"dictdict::%@", dict);
    
    IInitiated * initiated = self.datadource[indexPath.row];
    cell.iInitiated = initiated;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}


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

@end
