//
//  TestmanyChoicesViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/16.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "TestmanyChoicesViewController.h"

@interface TestmanyChoicesViewController ()

@property (nonatomic, strong) NSMutableArray * mutableArray;

@end

@implementation TestmanyChoicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mutableArray = [NSMutableArray new];
    
    [self.navigationItem setTitle:@"发送范围"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * array = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",nil];
    
    for (int i = 0 ; i  < [array count]; i++) {
        UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        clickBtn.backgroundColor = [UIColor clearColor];
        
       
        clickBtn.selected = NO;
        clickBtn.frame = CGRectMake(self.view.bounds.size.width-65,
                               i*50+64, 30, 30);
        [clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn setTag:i];
        [clickBtn setTitle:array[i] forState:(UIControlStateNormal)];
        clickBtn.backgroundColor = [UIColor grayColor];
        
        clickBtn.layer.borderColor = [UIColor yellowColor].CGColor;
        clickBtn.layer.borderWidth = 2;
        clickBtn.layer.cornerRadius = 3;
        
        [self.view addSubview:clickBtn];
        
    }
    
}

- (void)btnClick:(UIButton *)sender{
    
//    NSLog(@"sender::%ld, %@", (long)sender.tag, sender.titleLabel.text);
////    self.mutableArray = [NSMutableArray new];
//    [self.mutableArray addObject:sender.titleLabel.text];
//    NSLog(@" mutableArray%@", _mutableArray);
    
    NSString *str = sender.titleLabel.text;
    BOOL isbool = [_mutableArray containsObject: str];
    if (isbool) {
        [self.mutableArray removeObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor grayColor];
        
    }else{
        [self.mutableArray addObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor purpleColor];
        
    }
    NSLog(@" mutableArray%@", _mutableArray);
    
    
    NSLog(@"%i",isbool);
    
    
    
    
    
//    UIButton *bn = (UIButton *)sender;
//    bn.selected = !bn.selected;
    
//    for (NSInteger j = 0; j<[btnArray count]; j++) {
//        UIButton *btn = btnArray[j] ;
//        if (bn.tag == j){
//            btn.selected = bn.selected;
//        }
//        else{
//            btn.selected = NO;
//        }
//        [btn setBackgroundImage:[UIImage imageNamed:@"圈未选.png"] forState:UIControlStateNormal];
//    }
//
//    UIButton *btn = btnArray[bn.tag];
//    if (btn.selected) {
//        [btn setBackgroundImage:[UIImage imageNamed:@"圈选中.png"] forState:UIControlStateNormal];
//    }else{
//        [btn setBackgroundImage:[UIImage imageNamed:@"圈未选.png"] forState:UIControlStateNormal];
//    }
    
    
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
