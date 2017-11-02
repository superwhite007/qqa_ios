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
    
    [self setFirstLogin:@"首次登陆"  buttonTitle:@"下一步"];
    
}

-(void)setFirstLogin:(NSString *)loginString   buttonTitle:(NSString *)buttonTitle{
    
    UIView * firstAPPLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iphoneWidth, iphoneHeight)];
    firstAPPLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstAPPLoginView];
    
    UILabel * firstLoginTitleLable = [[UILabel alloc] initWithFrame:CGRectMake((iphoneWidth - 100) / 2, 64, 100, 30)];
    firstLoginTitleLable.text = loginString;
//    firstLoginTitleLable.backgroundColor = [UIColor redColor];
    firstLoginTitleLable.textAlignment =  NSTextAlignmentCenter;
    firstLoginTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:firstLoginTitleLable];
    
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake((iphoneWidth - 100) / 2, 110, 100, 100);
//    imgView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"info.png"];
    [imgView setImage:image];
    
    [firstAPPLoginView addSubview:imgView];
    
    UILabel * plantIDKeyLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 200, 30)];
    plantIDKeyLable.text = @"种植IDKey";
//    plantIDKeyLable.backgroundColor = [UIColor redColor];
    plantIDKeyLable.textAlignment =  NSTextAlignmentLeft;
    plantIDKeyLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:plantIDKeyLable];
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, iphoneWidth - 40, 90)];
    plantIDKeyExplianLable.text = @"首次登陆或者丢失IDKey的同事，需要在手机内种植IDKey，该IDKey会授权只有此手机可以登陆青青OA系统。                                                请不要择换其它手机登录，因为只有种植IDKey的手机才可以登录。";
//    plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
    plantIDKeyExplianLable.textAlignment =  NSTextAlignmentLeft;
//    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSize = [plantIDKeyExplianLable.text boundingRectWithSize:CGSizeMake(200, 150) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    plantIDKeyExplianLable.frame = CGRectMake(plantIDKeyExplianLable.frame.origin.x, plantIDKeyExplianLable.frame.origin.y, plantIDKeyExplianLable.frame.size.width, labelSize.height);
    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    
    [firstAPPLoginView addSubview:plantIDKeyExplianLable];
    
    
    
    
    UILabel * mattersNeedAttentionLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, 200, 30)];
    mattersNeedAttentionLable.text = @"注意事项";
//    mattersNeedAttentionLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionLable.textAlignment =  NSTextAlignmentLeft;
    mattersNeedAttentionLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
    [firstAPPLoginView addSubview:mattersNeedAttentionLable];
    
    UILabel * mattersNeedAttentionExplianLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 440, iphoneWidth - 40, 90)];
    mattersNeedAttentionExplianLable.text = @"请不要删除青青OA，也不要清理青青OA中的数据。否则IOKey丢失，导致无法登录。";
//    mattersNeedAttentionExplianLable.backgroundColor = [UIColor redColor];
    mattersNeedAttentionExplianLable.textAlignment =  NSTextAlignmentLeft;
    //    plantIDKeyExplianLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize labelSizemattersNeedAttentionExplian = [mattersNeedAttentionExplianLable.text boundingRectWithSize:CGSizeMake(200, 150) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    mattersNeedAttentionExplianLable.frame = CGRectMake(mattersNeedAttentionExplianLable.frame.origin.x, mattersNeedAttentionExplianLable.frame.origin.y, mattersNeedAttentionExplianLable.frame.size.width, labelSizemattersNeedAttentionExplian.height);
    mattersNeedAttentionExplianLable.numberOfLines = 0;//表示label可以多行显示
    mattersNeedAttentionExplianLable.font = [UIFont systemFontOfSize:18];
    
    [firstAPPLoginView addSubview:mattersNeedAttentionExplianLable];
    
    
    UIButton  * nestStepButton =  [UIButton buttonWithType:UIButtonTypeSystem];
    [nestStepButton setFrame:CGRectMake( 60,  iphoneHeight * 3 / 4 , iphoneWidth -120, 50)];
    [nestStepButton setTitle:buttonTitle forState:UIControlStateNormal];
    nestStepButton.titleLabel.font = [UIFont systemFontOfSize:24];
    nestStepButton.backgroundColor = [UIColor redColor];
    [nestStepButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nestStepButton addTarget:self action:@selector(plantIDKey) forControlEvents:UIControlEventTouchUpInside];
    
    [firstAPPLoginView addSubview:nestStepButton];
    
    
    
}
    
-(void)plantIDKey{
    
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
