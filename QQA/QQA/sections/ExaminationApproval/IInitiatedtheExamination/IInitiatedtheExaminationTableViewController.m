//
//  IInitiatedtheExaminationTableViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiatedtheExaminationTableViewController.h"
#import "IInitiatedtheExaminationTableViewCell.h"
#import "LeaveForExaminationAndApprovalViewController.h"
#import "RequestForInstructionViewController.h"

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
    
    NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"请假 - 事假、病假等" };
    NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"请示件 -- 请示领导审批" };
    NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"工单 -- 工作任务的描述" };
    
  
    [self.datadource addObject:dict];
    [self.datadource addObject:dict1];
    [self.datadource addObject:dict2];
    
    [self.navigationItem setTitle:@"发起审批"];
    
    [self.tableView registerClass:[IInitiatedtheExaminationTableViewCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    

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
        cell = [[IInitiatedtheExaminationTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    
    NSString * str = [NSString stringWithFormat:@"%@", [self.datadource[indexPath.row] objectForKey:@"reasonTitleStr"]];
                      
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hongjinbao"]];
    cell.reasonTitleLabel.text = str;
    cell.imgViewFor.image = [UIImage imageNamed:[self.datadource[indexPath.row] objectForKey:@"imageStr"]];
    
    //NSLog(@"dictdict::%@", dict);
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger number =  indexPath.row;
    if (number == 0) {
        LeaveForExaminationAndApprovalViewController * leaveVC = [[LeaveForExaminationAndApprovalViewController alloc] init];
        [self.navigationController pushViewController:leaveVC animated:YES];
        
    } else if (number == 1){
        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
        [self.navigationController pushViewController:leaveVC animated:YES];
        
        
    }else if (number == 2){
        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
        [self.navigationController pushViewController:leaveVC animated:YES];
        
    }

    
    
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
