//
//  WorkOrderNameListVC.m
//  QQA
//
//  Created by wang huiming on 2018/8/2.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "WorkOrderNameListVC.h"
#import "OneOrderVC.h"

#define kWORKORDERWIDTH  iphoneWidth - 20 //WORKORDERWIDTH
#define kWORKORDERORGINh  (iphoneHeight - iphoneWidth)/2   //iphoneHeight
#define kWORKORDERORGINHSPACE  (iphoneWidth - 20) / 20   //workOrderSpace

@interface WorkOrderNameListVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView * addOrEditWorkOrderView;
@property (nonatomic, strong) UILabel * workOrderTitle;
@property (nonatomic, strong) UITextField * workOrderTextField;

@end
@implementation WorkOrderNameListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _addOrEditWorkOrderView = [UIView new];
    _workOrderTitle = [UILabel new];
    _workOrderTextField = [[UITextField alloc] init];
    _workOrderTextField.delegate = self;
    
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"工单列表"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(gotoOneOrderVC)];
    [self addNewOREditWorkOrderView];
}

-(void)addNewOREditWorkOrderView{
    _addOrEditWorkOrderView.frame = CGRectMake(10, kWORKORDERORGINh, kWORKORDERWIDTH, kWORKORDERWIDTH);
    _addOrEditWorkOrderView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_addOrEditWorkOrderView];
    
    _workOrderTitle.frame = CGRectMake(10, kWORKORDERORGINHSPACE, kWORKORDERWIDTH, kWORKORDERORGINHSPACE);
    _workOrderTitle.textAlignment = NSTextAlignmentCenter;
    _workOrderTitle.text = @"新建/编辑工单";
    [_addOrEditWorkOrderView addSubview:_workOrderTitle];
    
    NSArray * labelNameAboutTitleANDContent = @[@"工单标题",@"工单内容"];
    for (int i = 0; i < labelNameAboutTitleANDContent.count; i++) {
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (3 + i * 2)* kWORKORDERORGINHSPACE,100, kWORKORDERORGINHSPACE)];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.text = labelNameAboutTitleANDContent[i];
        [_addOrEditWorkOrderView addSubview:nameLabel];
    }
    
//    _workOrderTextField.frame = CGRectMake(10 + kWORKORDERWIDTH / 10 + 5 , 3 * kWORKORDERORGINHSPACE, kWORKORDERWIDTH * 9 / 10 - 5, kWORKORDERORGINHSPACE);
    _workOrderTextField.frame = CGRectMake(115 , 3 * kWORKORDERORGINHSPACE - kWORKORDERORGINHSPACE / 2,  kWORKORDERWIDTH  - 120, kWORKORDERORGINHSPACE * 2);
    _workOrderTextField.backgroundColor = [UIColor whiteColor];
    _workOrderTextField.borderStyle = UITextBorderStyleLine;
    _workOrderTextField.adjustsFontSizeToFitWidth = YES;
    [_addOrEditWorkOrderView addSubview:_workOrderTextField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    [_addOrEditWorkOrderView addGestureRecognizer:tap];
    
}

#pragma UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.workOrderTextField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.workOrderTextField.text.length >= 20) {
            [self alert:@"工单标题不能超过20个字符!"];
            self.workOrderTextField.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [textField resignFirstResponder];
    return YES;
}
- (void)reKeyBoard
{
    [_workOrderTextField resignFirstResponder];
}

-(void)gotoOneOrderVC{
    OneOrderVC * oneOrderVC = [OneOrderVC new];
    [self.navigationController pushViewController:oneOrderVC animated:YES];
}

-(void)alert:(NSString *)str{
    
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
    
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
