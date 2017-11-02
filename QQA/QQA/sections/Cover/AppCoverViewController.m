//
//  AppCoverViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/2.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppCoverViewController.h"

#define  iphoneWidth    [[UIScreen mainScreen] bounds].size.width
#define  iphoneHeight   [[UIScreen mainScreen] bounds].size.height


@interface AppCoverViewController ()

@end

@implementation AppCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAppCoverImageName:@"app_face.png"  title:@"V00.00.01"];
    
}


-(void)setAppCoverImageName:(NSString *)imageName   title:(NSString *)title{
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, iphoneWidth, iphoneHeight);
    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:imageName];
    [imgView setImage:image];
    
    [self.view addSubview:imgView];
    
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    UIButton  * welcomeButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [welcomeButton setFrame:CGRectMake( (iphoneWidth - 200) / 2,  (iphoneHeight - 30) - 200, 200, 30)];
    [welcomeButton setTitle:title forState:UIControlStateNormal];
    welcomeButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [welcomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [welcomeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];

    [imgView addSubview:welcomeButton];
    imgView.userInteractionEnabled=YES;

    
}


- (void)clicked:(id)sender{
    
    [self setFirstLoginAppCoverImageName:@"首次登陆"  title:@"下一步"];
    
}

-(void)setFirstLoginAppCoverImageName:(NSString *)imageName   title:(NSString *)title{
    
    UIView * firstAPPLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    firstAPPLoginView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:firstAPPLoginView];
    
    
    
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
