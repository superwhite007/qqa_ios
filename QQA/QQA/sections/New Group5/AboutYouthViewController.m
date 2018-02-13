//
//  AboutYouthViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/13.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AboutYouthViewController.h"

@interface AboutYouthViewController ()

@end

@implementation AboutYouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"青春"];
    self.view.backgroundColor = [UIColor redColor];
    [self setAppCoverImageName:@"app_face.png"  title:@"V00.00.01"];
    
}

-(void)setAppCoverImageName:(NSString *)imageName title:(NSString *)title{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, -64, iphoneWidth, iphoneHeight);
    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:imageName];
    [imgView setImage:image];
    [self.view addSubview:imgView];
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    UIButton  * welcomeButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [welcomeButton setFrame:CGRectMake( (iphoneWidth - 200) / 2,  iphoneHeight * 3 / 5 - 60, 200, 30)];
    [welcomeButton setTitle:title forState:UIControlStateNormal];
    welcomeButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [welcomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imgView addSubview:welcomeButton];
    imgView.userInteractionEnabled=YES;
    UILabel * statementLable = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight  - 200, iphoneWidth - 40, 30)];
    statementLable.text = @"版本所有 中国青年网";
    statementLable.textAlignment =  NSTextAlignmentCenter;
    statementLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    [imgView addSubview:statementLable];
    UILabel * statementLable2 = [[UILabel alloc] initWithFrame:CGRectMake( 20 , iphoneHeight   - 170, iphoneWidth - 40, 30)];
    statementLable2.text = @"Copyright © 2017 China Youth Computer information Network. All Right Reserved.";
    statementLable2.textAlignment =  NSTextAlignmentCenter;
    statementLable2.font = [UIFont fontWithName:@"Helvetica-Bold" size:8];
    [imgView addSubview:statementLable2];
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
