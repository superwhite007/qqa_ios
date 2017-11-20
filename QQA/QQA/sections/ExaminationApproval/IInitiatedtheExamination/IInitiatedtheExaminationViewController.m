//
//  IInitiatedtheExaminationViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/17.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "IInitiatedtheExaminationViewController.h"
#import "LeaveForExaminationAndApprovalViewController.h"

#define kIInintedSPACE 5

@interface IInitiatedtheExaminationViewController ()

@property (nonatomic, strong) NSMutableArray * datadource;

@end

@implementation IInitiatedtheExaminationViewController

-(NSMutableArray *)datadource{
    if (!_datadource) {
        self.datadource = [NSMutableArray array];
    }
    return _datadource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary * dict = @{@"imageStr":@"youth_info", @"reasonTitleStr":@"请假", @"reasonStr":@"事假、病假.", @"promptStr":@"点击发起请假" };
    NSDictionary * dict1 = @{@"imageStr":@"youth_info", @"reasonTitleStr":@"请示件", @"reasonStr":@"重要事情不可以需要请示,不可先斩后奏！",@"promptStr":@"点击发起请示件" };
    NSDictionary * dict2 = @{@"imageStr":@"youth_info", @"reasonTitleStr":@"工单", @"reasonStr":@"明确事情的经过.", @"promptStr":@"点击发起工单" };
    [self.datadource addObject:dict];
    [self.datadource addObject:dict1];
    [self.datadource addObject:dict2];
    
    for (int i = 0; i < [self.datadource count]; i++) {
        UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 74 + i * 155, iphoneWidth, 150)];
//        cellView.backgroundColor = [UIColor blueColor];
//        cellView.layer.borderColor = [UIColor blackColor].CGColor;
        cellView.layer.borderWidth = 1;
        cellView.layer.cornerRadius = 5;
        
        [self addAllViews:cellView int:i];
        [self.view addSubview:cellView];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(iphoneWidth - 35, 112.5, 25, 25);
        [button setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [cellView addSubview:button];
        
//        UIImageView  * forwardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 35, 112.5, 25, 25)];
//        UIImage *image = [UIImage imageNamed:@"forward"];
//        [forwardImageView setImage:image];
//        forwardImageView.alpha = 0.6;
//        [cellVIew addSubview:forwardImageView];
        
        
        
    }
    
    
    
    
    
    
    
}

-(void)addAllViews:(UIView *)cellVIew int:(int)count{
    
    NSDictionary * dict = self.datadource[count];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imgView setImage:[UIImage imageNamed:dict[@"imageStr"]]];
    [cellVIew addSubview:_imgView];
    
    
    
    self.reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + kIInintedSPACE, 10, 100, 30)] ;
    _reasonTitleLabel.font = [UIFont systemFontOfSize:21];
    _reasonTitleLabel.text = dict[@"reasonTitleStr"];
    [cellVIew addSubview:_reasonTitleLabel];
    
    self.reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + kIInintedSPACE, 40, 200, 60)] ;
    _reasonLabel.font = [UIFont systemFontOfSize:20];
    _reasonLabel.text = dict[@"reasonStr"];
    _reasonLabel.adjustsFontForContentSizeCategory = YES;
    [cellVIew addSubview:_reasonLabel];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 100  , iphoneWidth, .5)];
    view.alpha = .4;
    view.backgroundColor = [UIColor blackColor];
    [cellVIew addSubview:view];
    
    self.promptLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 110, 200, 30)];
    _promptLabel.font = [UIFont systemFontOfSize:20];
    _promptLabel.text = dict[@"promptStr"];
    [cellVIew addSubview:self.promptLabel];
    
//    UIImageView  * forwardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iphoneWidth - 35, 112.5, 25, 25)];
//    UIImage *image = [UIImage imageNamed:@"forward"];
//    [forwardImageView setImage:image];
//    forwardImageView.alpha = 0.6;
//    [cellVIew addSubview:forwardImageView];
    
    
}

-(void)buttonAction{
    
    LeaveForExaminationAndApprovalViewController * leaveVC = [[LeaveForExaminationAndApprovalViewController alloc] init];
    [self.navigationController pushViewController:leaveVC animated:YES];
    
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
