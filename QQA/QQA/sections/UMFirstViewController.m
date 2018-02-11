//
//  UMFirstViewController.m
//  QQA
//
//  Created by wang huiming on 2017/12/22.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "UMFirstViewController.h"

@interface UMFirstViewController ()

@end

@implementation UMFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * plantIDKeyExplianLable = [[UILabel alloc] initWithFrame:CGRectZero];
//    plantIDKeyExplianLable.backgroundColor = [UIColor redColor];
    plantIDKeyExplianLable.text = _notcieString;
    plantIDKeyExplianLable.font = [UIFont systemFontOfSize:18];
    plantIDKeyExplianLable.numberOfLines = 0;//表示label可以多行显示
    plantIDKeyExplianLable.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(self.view.bounds.size.width - 100, 2000);
    CGRect targetRect = [plantIDKeyExplianLable.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : plantIDKeyExplianLable.font} context:nil];
    plantIDKeyExplianLable.frame = CGRectMake(20, 84, iphoneWidth - 40, CGRectGetHeight(targetRect));
    [self.view addSubview:plantIDKeyExplianLable];
    
    
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
