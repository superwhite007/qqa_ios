//
//  MineTasksTVC.m
//  QQA
//
//  Created by wang huiming on 2018/6/11.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "MineTasksTVC.h"
#import "TaskVC.h"
#import "WorkOrderNameListVC.h"
#import "WorkOrderNameLIstsViewController.h"
@interface MineTasksTVC ()

@end

@implementation MineTasksTVC

static NSString * reuseIdentifier = @"CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.tableView.rowHeight = 100;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"me_normal"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"自己执行的任务列表";
        [cell.detailTextLabel setText:@"包括自己创建和领导创建的任务"];
        cell.imageView.image = [UIImage imageNamed:@"MineTasks"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"为下属创建的任务列表";
        [cell.detailTextLabel setText:@"可以在此创建和检查这些任务"];
        cell.imageView.image = [UIImage imageNamed:@"OtherPeopleTask1"];
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"创建工作单";
        [cell.detailTextLabel setText:@"创建多部门协助工作单，共同完成任务"];
        cell.imageView.image = [UIImage imageNamed:@"WorkOrder1"];
    }
    [cell layoutSubviews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TaskVC * taskVC = [TaskVC new];
        taskVC.mineOrOthersStr = @"自己的任务";
        [self.navigationController pushViewController:taskVC animated:YES];
    }else if (indexPath.row == 1) {
        [self  gitPersonPermissions];
    }else if (indexPath.row == 2){
        [self gotoWorkOrderVC];
    }
}

-(void)gotoWorkOrderVC{
    WorkOrderNameLIstsViewController * workOrderNameListVC = [WorkOrderNameLIstsViewController new];
    [self.navigationController pushViewController:workOrderNameListVC animated:YES];
}

-(void)gitPersonPermissions{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/user/permissions", CONST_SERVER_ADDRESS]];
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
    NSLog(@"mdict:%@", mdict);
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSLog(@"%@", error);
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"dataBackdataBack:%@", dataBack);
                                                if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    if ( [[dataBack objectForKey:@"message"] intValue] == 8002 ) {
                                                         NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dataBack];
                                                        if ([[dict objectForKey:@"createTaskForSubordinate" ] isEqualToString:@"yes"]) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [self havePermissionsYes];
                                                            });
                                                        }else{
                                                            [self alert:@"没有相关权限"];
                                                        }
                                                    }else {
                                                        [self alert:@"没有相关权限"];
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    [self alert:@"没有相关权限"];
                                                }
                                            }else{
                                               [self alert:@"没有相关权限"];
                                            }
                                        }];
    [task resume];
    
}
-(void)havePermissionsYes{
    
    TaskVC * taskVC = [TaskVC new];
    taskVC.mineOrOthersStr = @"下属任务";
    [self.navigationController pushViewController:taskVC animated:YES];

}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @"  ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
