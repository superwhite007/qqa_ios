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
#import "ACPApprovelViewController.h"

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
    if ([_titleIdentifier isEqualToString:@"发起审批"]) {
        NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"请假 - 事假、病假等",@"peopleImageStr":@"vacation"  };
        NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"请示件 -- 请示领导审批" ,@"peopleImageStr":@"askware"};
        NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"工单 -- 工作任务的描述" ,@"peopleImageStr":@"worksheet"};
        [self.datadource addObject:dict];
        [self.datadource addObject:dict1];
        [self.datadource addObject:dict2];
    } else if ([_titleIdentifier isEqualToString:@"待审批的"]){
        NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"批阅假条" ,@"peopleImageStr":@"vacation"  };
        NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"批阅请示件" ,@"peopleImageStr":@"askware"};
        NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"批阅工单" ,@"peopleImageStr":@"worksheet"};
        [self.datadource addObject:dict];
        [self.datadource addObject:dict1];
        [self.datadource addObject:dict2];
    }else if ([_titleIdentifier isEqualToString:@"已通过的"]){
        NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"已批阅假条" ,@"peopleImageStr":@"vacation"  };
        NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"已批阅请示件" ,@"peopleImageStr":@"askware"};
        NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"已批阅工单" ,@"peopleImageStr":@"worksheet"};
        [self.datadource addObject:dict];
        [self.datadource addObject:dict1];
        [self.datadource addObject:dict2];
    }else if ([_titleIdentifier isEqualToString:@"未通过的"]){
        NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"未批阅假条" ,@"peopleImageStr":@"vacation"  };
        NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"未阅请示件" ,@"peopleImageStr":@"askware"};
        NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"未阅工单" ,@"peopleImageStr":@"worksheet"};
        [self.datadource addObject:dict];
        [self.datadource addObject:dict1];
        [self.datadource addObject:dict2];
    }else if ([_titleIdentifier isEqualToString:@"抄送我的"]){
        NSDictionary * dict = @{@"imageStr":@"forward", @"reasonTitleStr":@"抄送假条" ,@"peopleImageStr":@"vacation"  };
        NSDictionary * dict1 = @{@"imageStr":@"forward", @"reasonTitleStr":@"抄送请示件" ,@"peopleImageStr":@"askware"};
        NSDictionary * dict2 = @{@"imageStr":@"forward", @"reasonTitleStr":@"抄送工单" ,@"peopleImageStr":@"worksheet"};
        [self.datadource addObject:dict];
        [self.datadource addObject:dict1];
        [self.datadource addObject:dict2];
    }
    [self.navigationItem setTitle:_titleIdentifier];
    [self.tableView registerClass:[IInitiatedtheExaminationTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datadource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IInitiatedtheExaminationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[IInitiatedtheExaminationTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    NSString * str = [NSString stringWithFormat:@"%@", [self.datadource[indexPath.row] objectForKey:@"reasonTitleStr"]];
    cell.imgView.image = [UIImage imageNamed:[self.datadource[indexPath.row] objectForKey:@"peopleImageStr"]];
    cell.reasonTitleLabel.text = str;
    cell.imgViewFor.image = [UIImage imageNamed:[self.datadource[indexPath.row] objectForKey:@"imageStr"]];
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
    if ([_titleIdentifier isEqualToString:@"发起审批"]) {
        if (number == 0) {
            LeaveForExaminationAndApprovalViewController * leaveVC = [[LeaveForExaminationAndApprovalViewController alloc] init];
            [self.navigationController pushViewController:leaveVC animated:YES];
        } else if (number == 1){
//            RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
//            [self.navigationController pushViewController:leaveVC animated:YES];
             [self alert:@"期待中、、、"];
        }else if (number == 2){
            //        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
            //        [self.navigationController pushViewController:leaveVC animated:YES];
            [self alert:@"期待中、、、"];
        }
    } else if ([_titleIdentifier isEqualToString:@"待审批的"]){
        if (number == 0) {
            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
            examinationVC.titleStr = @"待审批的";
            examinationVC.urlStr = @"/v1/api/leave/index";
            [self.navigationController pushViewController:examinationVC animated:YES];
        } else if (number == 1){
//            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
//            examinationVC.titleStr = @"待审批的";
//            examinationVC.urlStr = @"/v1/api/ask/index";
//            [self.navigationController pushViewController:examinationVC animated:YES];
            [self alert:@"期待中、、、"];
        }else if (number == 2){
            //        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
            //        [self.navigationController pushViewController:leaveVC animated:YES];
             [self alert:@"期待中、、、"];
        }
    }else if ([_titleIdentifier isEqualToString:@"已通过的"]){
        if (number == 0) {
            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
            examinationVC.titleStr = @"已通过的";
            examinationVC.urlStr = @"/v1/api/leave/index";
            [self.navigationController pushViewController:examinationVC animated:YES];
        } else if (number == 1){
//            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
//            examinationVC.titleStr = @"已通过的";
//            examinationVC.urlStr = @"/v1/api/ask/index";
//            [self.navigationController pushViewController:examinationVC animated:YES];
            [self alert:@"期待中、、、"];
        }else if (number == 2){
            //        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
            //        [self.navigationController pushViewController:leaveVC animated:YES];
             [self alert:@"期待中、、、"];
        }
    }else if ([_titleIdentifier isEqualToString:@"未通过的"]){
        if (number == 0) {
            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
            examinationVC.titleStr = @"未通过的";
            examinationVC.urlStr = @"/v1/api/leave/index";
            [self.navigationController pushViewController:examinationVC animated:YES];
        } else if (number == 1){
//            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
//            examinationVC.titleStr = @"未通过的";
//            examinationVC.urlStr = @"/v1/api/ask/index";
//            [self.navigationController pushViewController:examinationVC animated:YES];
             [self alert:@"期待中、、、"];
        }else if (number == 2){
            //        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
            //        [self.navigationController pushViewController:leaveVC animated:YES];
             [self alert:@"期待中、、、"];
        }
    }else if ([_titleIdentifier isEqualToString:@"抄送我的"]){
        if (number == 0) {
            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
            examinationVC.titleStr = @"抄送我的";
            examinationVC.urlStr = @"/v1/api/leave/index";
            [self.navigationController pushViewController:examinationVC animated:YES];
        } else if (number == 1){
//            ACPApprovelViewController * examinationVC = [[ACPApprovelViewController alloc] init];
//            examinationVC.titleStr = @"抄送我的";
//            examinationVC.urlStr = @"/v1/api/ask/index";
//            [self.navigationController pushViewController:examinationVC animated:YES];
            [self alert:@"期待中、、、"];
        }else if (number == 2){
            //        RequestForInstructionViewController * leaveVC = [[RequestForInstructionViewController alloc] init];
            //        [self.navigationController pushViewController:leaveVC animated:YES];
             [self alert:@"期待中、、、"];
        }
    }
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"请注意";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
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
