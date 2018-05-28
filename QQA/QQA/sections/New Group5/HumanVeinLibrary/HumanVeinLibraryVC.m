//
//  HumanVeinLibraryVC.m
//  QQA
//
//  Created by wang huiming on 2018/5/28.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "HumanVeinLibraryVC.h"

#define searchBarHeigint 60

@interface HumanVeinLibraryVC ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation HumanVeinLibraryVC

- (NSArray *)titles{
    if (!_titles) {
        self.titles = @[@"A", @"B", @"C", @"D", @"E", @"F"];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationItem setTitle:@"人脉库"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(newContact)];
//    NSLog(@"x,y.width,height  %f,%f,%f,%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    // Do any additional setup after loading the view.
    
    [self addSearchBar];
    [self addtableView];
    
}

-(void)addtableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + searchBarHeigint, self.view.bounds.size.width, self.view.bounds.size.height - searchBarHeigint) style:(UITableViewStylePlain)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!aCell) {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    aCell.textLabel.text = [NSString stringWithFormat:@"%@,%ld", aCell.textLabel.text, indexPath.row];
    return  aCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //为每个分区指定分区区头标题
    return self.titles[section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return  self.titles;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    UIView *view = [[UIView alloc ]init];
////    view.backgroundColor = [UIColor yellowColor];
////    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor greenColor];
    return aView;
}









-(void)addSearchBar{
    UISearchBar * bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0 , 0, iphoneWidth, searchBarHeigint)];
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
