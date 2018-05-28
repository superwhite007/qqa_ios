//
//  HumanVeinLibraryVC.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanVeinLibraryVC.h"

@interface HumanVeinLibraryVC ()

@end

@implementation HumanVeinLibraryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"人脉库"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newContact)];
//    NSLog(@"x,y.width,height  %f,%f,%f,%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    // Do any additional setup after loading the view.
    
    [self addSearchBar];
    
    
    
    
}

-(void)addSearchBar{
    UISearchBar * bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0 , 0, iphoneWidth, 40)];
    bar.backgroundColor = [UIColor yellowColor];
    bar.placeholder = @"搜索联系人";
    [self.view addSubview:bar];
}



-(void)newContact{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256  / 255.0 green:arc4random() % 256  / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
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
