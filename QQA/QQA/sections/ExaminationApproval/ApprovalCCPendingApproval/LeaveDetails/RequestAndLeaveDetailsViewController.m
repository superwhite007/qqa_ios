//
//  RequestAndLeaveDetailsViewController.m
//  QQA
//
//  Created by wang huiming on 2017/11/28.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "RequestAndLeaveDetailsViewController.h"

@interface RequestAndLeaveDetailsViewController ()
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * created_atTimeLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * statusReasonLabel;
@property (nonatomic, strong) UILabel * startTimeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * longTimeLabel;
@property (nonatomic, strong) UILabel * reasonLabel;
@property (nonatomic, strong) NSMutableArray * cCMarray;
@property (nonatomic, strong) NSMutableArray * approvalMarray;
@property (nonatomic, strong) NSMutableArray * datasourceMArray;
@property (nonatomic, assign) BOOL isDownRefresh;
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) BOOL buttonAgree;
@property (nonatomic, strong) UIView * moveView;


//@property (nonatomic, strong) UIButton * buttonAgree;

@end

@implementation RequestAndLeaveDetailsViewController

-(NSMutableArray *)datasourceMArray{
    if (!_datasourceMArray) {
        self.datasourceMArray = [[NSMutableArray alloc] init];
    }
    return _datasourceMArray;
}
-(NSMutableArray *)approvalMarray{
    if (!_approvalMarray) {
        self.approvalMarray = [[NSMutableArray alloc] init];
    }
    return  _approvalMarray;
}
-(NSMutableArray *)cCMarray{
    if (!_cCMarray) {
        self.cCMarray = [[NSMutableArray alloc] init];
    }
    return _cCMarray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:_titleIdentStr];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发  送" style:(UIBarButtonItemStyleDone) target:self action:@selector(sendApprovalMessagesToServer)];
    _moveView = [UIView new];
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
         _moveView.frame = CGRectMake(0, 0, iphoneWidth, 125 + iphoneWidth * 2 / 3);
    }else{
         _moveView.frame = CGRectMake(0, 0, iphoneWidth, 115 + iphoneWidth * 2 / 3);
    }
//    _moveView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_moveView];
    [self loadNewData];
    [self setTextView];
   
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //键盘高度
    _moveView.frame = CGRectMake(0, -104, iphoneWidth, iphoneWidth);
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    _moveView.frame = CGRectMake(0, 0, iphoneWidth, iphoneWidth);
}




-(void)setTextView{
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 165 + iphoneWidth * 1 / 3, iphoneWidth - 40, iphoneWidth / 3 - 50)];
//        _messageTextView.backgroundColor = [UIColor blueColor];
    _messageTextView.font = [UIFont systemFontOfSize:24];
    _messageTextView.layer.borderColor = [UIColor blackColor].CGColor;
    _messageTextView.layer.borderWidth = 1;
    _messageTextView.layer.cornerRadius = 10;
    _messageTextView.returnKeyType = UIReturnKeySend;
    _messageTextView.delegate = self;
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        self.messageTextView.frame = CGRectMake(20, 165 + iphoneWidth * 1 / 3, iphoneWidth - 40, iphoneWidth / 3 - 50);
    }else{
        self.messageTextView.frame = CGRectMake(20, 165 + iphoneWidth * 1 / 3, iphoneWidth - 40, iphoneWidth / 3 - 70);
    }
    
    _buttonReject = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _buttonAgreement = [UIButton buttonWithType:(UIButtonTypeSystem)];
     if ([[UIScreen mainScreen] bounds].size.width > 321) {
         _buttonReject.frame = CGRectMake(iphoneWidth - 230 , 125 + iphoneWidth * 2 / 3  , 100, 30);
         _buttonAgreement.frame = CGRectMake(iphoneWidth - 230 +  110, 125 + iphoneWidth * 2 / 3  , 100, 30);
         
     } else {
         _buttonReject.frame = CGRectMake(iphoneWidth - 150 , 125 + iphoneWidth * 2 / 3 - 28  , 60, 25);
         _buttonAgreement.frame = CGRectMake(iphoneWidth - 230 +  150, 125 + iphoneWidth * 2 / 3 - 28 , 60, 25);
     }
    
    
    _buttonReject.layer.cornerRadius = 5;
    _buttonReject.layer.borderColor = [UIColor blackColor].CGColor;
    _buttonReject.layer.borderWidth = 1;
    [_buttonReject setTitle:@"拒绝" forState:(UIControlStateNormal)];
    [_buttonReject addTarget:self action:@selector(changeButtonAgree:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_buttonReject];
    
   
    _buttonAgreement.layer.cornerRadius = 5;
    _buttonAgreement.layer.borderColor = [UIColor blackColor].CGColor;
    _buttonAgreement.layer.borderWidth = 1;
    [_buttonAgreement setTitle:@"同意" forState:(UIControlStateNormal)];
    [_buttonAgreement addTarget:self action:@selector(changeButtonAgrees:) forControlEvents:(UIControlEventTouchUpInside)];
    _buttonAgreement.backgroundColor = [UIColor redColor];
    _buttonAgree = YES;
    
    [self.view addSubview:_buttonAgreement];
    
//    }
    [_moveView addSubview:_messageTextView];
}
-(void)changeButtonAgree:(UIButton *)sender{
    NSLog(@"000000000000000000");
    _buttonAgree = NO;
    _buttonReject.backgroundColor = [UIColor redColor];
    _buttonAgreement.backgroundColor = [UIColor whiteColor];
}

-(void)changeButtonAgrees:(UIButton *)sender{
    NSLog(@"1111111111111111111");
    _buttonAgree = YES;
    _buttonReject.backgroundColor = [UIColor whiteColor];
    _buttonAgreement.backgroundColor = [UIColor redColor];
}
-(void)ApproverAndCC{
    if ([[UIScreen mainScreen] bounds].size.width > 321) {
        [self ApproverAndCCAfteriPhone6];
    }else{
        [self ApproverAndCCSEAnd5S];
    }
}

-(void)ApproverAndCCSEAnd5S{
    for (int i = 0; i < [_datasourceMArray count]; i++) {
        NSString * str = [_datasourceMArray[i] objectForKey:@"type"] ;
        if ([str isEqualToString:@"approver"]) {
            NSDictionary * dict = _datasourceMArray[i];
            [self.approvalMarray addObject:dict];
        } else if ([str isEqualToString:@"reader"]){
            [self.cCMarray addObject:_datasourceMArray[i]];
        }
    }
    if ([self.approvalMarray count] == 0 || self.cCMarray.count == 0) {
        return;
    }
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, iphoneWidth + 35 + (iphoneWidth * 1 / 5  + 10 )  * i ,  60, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
        //                        reasonTitleLabel.backgroundColor = [UIColor redColor];
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 25  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5)];
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
            titleLabe.text = [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            titleLabe.textColor = [UIColor whiteColor];
            if (i == 0) {
                NSString * str = [NSString stringWithFormat:@"%@", [mArrayOFApproverAndCC[i][j] objectForKey:@"type"]];
                if ([str isEqualToString:@"Agreed"]) {
                    titleLabe.backgroundColor = [UIColor greenColor];
                } else if ([str isEqualToString:@"Denyed"]) {
                    //                    titleLabe.backgroundColor = [UIColor redColor];
                }
            }
            
            switch (j % 5) {
                case 0:
                    titleLabe.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                    break;
                case 1:
                    titleLabe.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                    break;
                case 2:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                    break;
                case 3:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                    break;
                case 4:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                    break;
                    
                default:
                    break;
            }
            
            if ( i == 1 ) {
                [self.view addSubview:titleLabe];
            }else if( i == 0 ){
                UIButton * titleLabe = [UIButton buttonWithType:UIButtonTypeSystem];
                titleLabe.frame = CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 30  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5);
                titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
                NSString * str = [NSString stringWithFormat:@"%@", [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1]];
                [titleLabe setTitle:str forState:(UIControlStateNormal)];
                [titleLabe setTintColor:[UIColor blackColor]];
                titleLabe.layer.masksToBounds = YES;
                titleLabe.titleLabel.textColor = [UIColor whiteColor];
                titleLabe.titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabe.titleLabel.font = [UIFont systemFontOfSize:30];
                [titleLabe setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                [self.view addSubview:titleLabe];
                
                switch (j % 5) {
                    case 0:
                        titleLabe.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                        break;
                    case 1:
                        titleLabe.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                        break;
                    case 2:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                        break;
                    case 3:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                        break;
                    case 4:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                        break;
                        
                    default:
                        break;
                }
                
                
                
                UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5) + (iphoneWidth - 110 ) / 5 -15, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 30 , 15, 15)];
                pointLabel.backgroundColor = [UIColor redColor];
                pointLabel.layer.cornerRadius = 7.5;
                //    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
                //    _nameShorthandLabel.layer.borderWidth = 1;
                pointLabel.layer.masksToBounds = YES;
                
                if ([[self.approvalMarray[j] objectForKey:@"comment"] isEqualToString:@"暂无"]) {
                    NSLog(@"暂时无评论");
                }else{
                    [self.view addSubview:pointLabel];
                    [titleLabe addTarget:self action:@selector(displayComment:) forControlEvents:UIControlEventTouchUpInside];
                    titleLabe.tag = 100 + j;
                }
                
                
                
            }
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 25  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
            nameLabel.text = [mArrayOFApproverAndCC[i][j] objectForKey:@"name"];
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            //            nameLabel.backgroundColor = [UIColor redColor];
            [self.view addSubview:nameLabel];
            
        }
    }
}



-(void)ApproverAndCCAfteriPhone6{
    for (int i = 0; i < [_datasourceMArray count]; i++) {
        NSString * str = [_datasourceMArray[i] objectForKey:@"type"] ;
        if ([str isEqualToString:@"approver"]) {
            NSDictionary * dict = _datasourceMArray[i];
            [self.approvalMarray addObject:dict];
        } else if ([str isEqualToString:@"reader"]){
            [self.cCMarray addObject:_datasourceMArray[i]];
        }
    }
    if ([self.approvalMarray count] == 0 || self.cCMarray.count == 0) {
        return;
    }
    NSArray * titleArray =@[@"审批人", @"抄送人"];
    NSArray * peopleOfApprover = [NSArray arrayWithArray:self.approvalMarray];
    NSArray * peopleOfCC = [NSArray arrayWithArray:self.cCMarray];
    NSMutableArray * mArrayOFApproverAndCC = [NSMutableArray arrayWithObjects:peopleOfApprover, peopleOfCC, nil];
    for (int i = 0 ; i < 2 ; i++ ) {
        UILabel * reasonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, iphoneWidth  + (iphoneWidth / 5  + 20 )  * i + 55,  60, 30)];
        reasonTitleLabel.text = titleArray[i];
        reasonTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:reasonTitleLabel];
        for (int j = 0; j < [mArrayOFApproverAndCC[i] count] ; j++) {
            UILabel * titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5)];
            titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
            titleLabe.text = [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1];
            titleLabe.layer.masksToBounds = YES;
            titleLabe.textAlignment = NSTextAlignmentCenter;
            titleLabe.font = [UIFont systemFontOfSize:30];
            titleLabe.textColor = [UIColor whiteColor];
            switch (j % 5) {
                case 0:
                    titleLabe.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                    break;
                case 1:
                    titleLabe.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                    break;
                case 2:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                    break;
                case 3:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                    break;
                case 4:
                    titleLabe.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                    break;
                    
                default:
                    break;
            }
            
            if ( i == 1 ) {
                [self.view addSubview:titleLabe];
            }else if( i == 0 ){
                UIButton * titleLabe = [UIButton buttonWithType:UIButtonTypeSystem];
                titleLabe.frame = CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  , (iphoneWidth - 110 ) / 5 , (iphoneWidth - 110 ) / 5);
//                titleLabe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                titleLabe.layer.cornerRadius = (iphoneWidth - 110 ) / 5 / 2;
                NSString * str = [NSString stringWithFormat:@"%@", [[mArrayOFApproverAndCC[i][j] objectForKey:@"name"] substringToIndex:1]];
                [titleLabe setTitle:str forState:(UIControlStateNormal)];
                [titleLabe setTintColor:[UIColor blackColor]];
                titleLabe.layer.masksToBounds = YES;
                titleLabe.titleLabel.textColor = [UIColor whiteColor];
                titleLabe.titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabe.titleLabel.font = [UIFont systemFontOfSize:30];
                [titleLabe setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                [self.view addSubview:titleLabe];
                
                switch (j % 5) {
                    case 0:
                        titleLabe.backgroundColor = [UIColor colorWithRed:57/ 255.0 green:172 / 255.0 blue:253 / 255.0 alpha:1];
                        break;
                    case 1:
                        titleLabe.backgroundColor = [UIColor colorWithRed:252/ 255.0 green:131 / 255.0 blue: 52 / 255.0 alpha:1];
                        break;
                    case 2:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 48/ 255.0 green:185 / 255.0 blue: 103 / 255.0 alpha:1];
                        break;
                    case 3:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 245/ 255.0 green:93 / 255.0 blue: 82 / 255.0 alpha:1];
                        break;
                    case 4:
                        titleLabe.backgroundColor = [UIColor colorWithRed: 139/ 255.0 green:194 / 255.0 blue: 75 / 255.0 alpha:1];
                        break;
                    
                    default:
                        break;
                }
                
//                [titleLabe addTarget:self action:@selector(displayComment:) forControlEvents:UIControlEventTouchUpInside];
//                titleLabe.tag = 100 + j;
                
                UILabel * pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5  + 8) + (iphoneWidth - 110 ) / 5 - 20, 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80 , 15, 15)];
                pointLabel.backgroundColor = [UIColor redColor];
                pointLabel.layer.cornerRadius = 7.5;
                //    _nameShorthandLabel.layer.borderColor = [UIColor blackColor].CGColor;
                //    _nameShorthandLabel.layer.borderWidth = 1;
                pointLabel.layer.masksToBounds = YES;
                if ([[self.approvalMarray[j] objectForKey:@"comment"] isEqualToString:@"暂无"]) {
                    NSLog(@"暂时无评论");
                }else{
                    [self.view addSubview:pointLabel];
                    [titleLabe addTarget:self action:@selector(displayComment:) forControlEvents:UIControlEventTouchUpInside];
                    titleLabe.tag = 100 + j;
                }
            }
            
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + j * ((iphoneWidth - 110 ) / 5 + 5), 216 + iphoneWidth * 1 / 3 + i * ( 35 + (iphoneWidth - 110 ) / 5 ) + 80  +  (iphoneWidth - 110 ) / 5 + 5, (iphoneWidth - 110 ) / 5, (iphoneWidth - 110 ) / 5 / 3)];
            nameLabel.text = [mArrayOFApproverAndCC[i][j] objectForKey:@"name"];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:nameLabel];
        }
    }
}


-(NSString *)tepyOfLeave:(NSString *)str{
    if ([str isEqualToString:@"100"]) {
        return  @"调休";
    } else if ([str isEqualToString:@"101"]){
        return  @"年假";
    } else if ([str isEqualToString:@"102"]){
        return @"婚假";
    } else if ([str isEqualToString:@"103"]){
        return  @"产假";
    } else if ([str isEqualToString:@"104"]){
        return  @"病假";
    } else if ([str isEqualToString:@"105"]){
        return @"事假";
    } else if ([str isEqualToString:@"106"]){
        return @"丧假";
    } else if ([str isEqualToString:@"107"]){
        return  @"工伤假";
    } else if ([str isEqualToString:@"108"]){
        return @"外出";
    } else if ([str isEqualToString:@"109"]){
        return @"其他";
    }
    return @"其他";
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_messageTextView isExclusiveTouch]) {
        [_messageTextView resignFirstResponder];
    }else{
//        [self removeKeyNotice];
    }
}

-(void)loadNewData
{
    //记录是下拉刷新
    self.isDownRefresh = YES;
    [self loadDataAndShowWithPageNum:1];
    //    [self.foodListView.tableView.header endRefreshing];
}

#pragma mark - loadDataAndShow
-(void)loadDataAndShowWithPageNum:(int)page
{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, _urlStr]];
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
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveIdStr forKey:@"leaveId"];
    } else if ([_titleIdentStr isEqualToString:@"请示件"]) {
        [mdict setObject:_leaveIdStr forKey:@"askId"];
    }
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6008 || [[dictArray[0] objectForKey:@"message"] intValue] == 6019) {
                                                        self.isEmpty = NO;
                                                        NSMutableArray * array1 = [NSMutableArray arrayWithArray:dictArray];
                                                        NSDictionary * dict = array1[0];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                             [self setvaleKeyAndValue:dict];
                                                         });
                                                        [array1 removeObjectAtIndex:0];
                                                        self.datasourceMArray = array1;
                                                        NSLog(@"array1array1array1array1:%@", array1);
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self ApproverAndCC];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6007 ){
                                                        self.isEmpty = YES;
//                                                        [self.datasouceArray addObject:@"暂时没有相关内容"];
//                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            [self.aCPApprovalListView.tableView  reloadData];
//                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                                //NSLog(@"获取数据失败，问");
//                                                [self.datasouceArray addObject:@"获取数据失败"];
//                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    [self.aCPApprovalListView.tableView  reloadData];
//                                                });
                                            }
                                        }];
    [task resume];
    
}

-(void)setvaleKeyAndValue:(NSDictionary *)dict{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, iphoneWidth - 40, 25)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_moveView addSubview:_nameLabel];
    _created_atTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, iphoneWidth - 40, 25)];
    _created_atTimeLabel.textAlignment = NSTextAlignmentCenter;
    [_moveView addSubview:_created_atTimeLabel];
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  70, (iphoneWidth  - 50) / 2 , 25)];
    _statusReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  134, (iphoneWidth  - 50) / 2 , 25)];
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, iphoneWidth / 2 - 25, 25)];
    _startTimeLabel.adjustsFontSizeToFitWidth = YES;
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + (iphoneWidth  - 50) / 2 ,  100, (iphoneWidth  - 50) / 2, 25)];
    _endTimeLabel.adjustsFontSizeToFitWidth = YES;
    _longTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, iphoneWidth - 40, 25)];
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [_moveView addSubview:_startTimeLabel];
        [_moveView addSubview:_statusLabel];
        [_moveView addSubview:_statusReasonLabel];
        [_moveView addSubview:_endTimeLabel];
        [_moveView addSubview:_longTimeLabel];
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 170 , iphoneWidth - 40, iphoneWidth / 3 - 20)];
    } else{
        _reasonLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 70 , iphoneWidth - 40, iphoneWidth / 3 + 80)];
    }
//    _reasonLabel.backgroundColor = [UIColor redColor];
    _reasonLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _reasonLabel.layer.borderWidth = 1;
    _reasonLabel.layer.cornerRadius = 10;
    _reasonLabel.layer.masksToBounds = YES;
    [_moveView addSubview:_reasonLabel];
    _nameLabel.text = [dict objectForKey:@"username"];
    _created_atTimeLabel.text = [dict objectForKey:@"createdAt"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起始:%@", [dict objectForKey:@"starttime"]];
    if ([_titleIdentStr isEqualToString:@"请假"]) {
       _reasonLabel.text = [dict objectForKey:@"reason"];
    } else{
       _reasonLabel.text = [dict objectForKey:@"content"];
    }
    _statusLabel.text =[NSString stringWithFormat:@"类型:%@", [self tepyOfLeave:[NSString stringWithFormat:@"%@", [dict objectForKey:@"type"]]]];
    _endTimeLabel.text = [NSString stringWithFormat:@"结束:%@", [dict objectForKey:@"endtime"]];
    _longTimeLabel.text =[NSString stringWithFormat:@"请假天数:%@",  [dict objectForKey:@"betweentime"]];
    [self.navigationItem setTitle:[dict objectForKey:@"username"]];
}

-(void)chageColor{
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendNoticeToServer];
        return NO;
    }else if (range.location >= 200){
        [self alert:@"最多输入200字符"];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    [self removeKeyNotice];
}

-(void)sendNoticeToServer{
    if (_messageTextView.text.length == 0){
        [self alert:@"请输入通知内容"];
        [self sendToServerTOBack];
    }
}

-(void)sendApprovalMessagesToServer{
    NSString  * uMStr =  [NSMutableString new];
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        uMStr = @"/v1/api/leave/update";
    } else{
        uMStr = @"/v1/api/ask/update";
    }
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CONST_SERVER_ADDRESS, uMStr]];
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
    if ([_titleIdentStr isEqualToString:@"请假"]) {
        [mdict setObject:_leaveIdStr forKey:@"leaveId"];
    } else{
        [mdict setObject:_leaveIdStr forKey:@"askId"];
    }
    if (_buttonAgree) {
        [mdict setObject:@"Agreed" forKey:@"status"];
    } else{
         [mdict setObject:@"Denyed" forKey:@"status"];
    }
    if (_messageTextView.text.length == 0) {
        [mdict setObject:@"NULL" forKey:@"comment"];
    }else{
        [mdict setObject:_messageTextView.text forKey:@"comment"];
    }
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            if (data != nil) {
                                                id  dataBack = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                if ([dataBack isKindOfClass:[NSArray class]]) {
                                                    NSArray * dictArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dictArray[0] objectForKey:@"message"] intValue] == 6010 ) {
                                                        self.isEmpty = NO;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"审批完成"];
                                                        });
                                                    }
                                                }else if ([dataBack isKindOfClass:[NSDictionary class]]){
                                                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    if ( [[dict objectForKey:@"message"] intValue] == 6010 || [[dict objectForKey:@"message"] intValue] == 6022) {
                                                        self.isEmpty = NO;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self alert:@"审批完成"];
                                                        });
                                                    }
                                                }
                                            } else{
                                                self.isEmpty = YES;
                                            }
                                        }];
    [task resume];
}

-(void)sendToServerTOBack{
    [self alert:@"发送服务器：success"];
}

-(void)displayComment:(UIButton *)sender{
    [self alert:[self.approvalMarray[(long)sender.tag - 100] objectForKey:@"comment"]];
}

-(void)alert:(NSString *)str{
    NSString *title = str;
    NSString *message = @" ";
    NSString *okButtonTitle = @"OK";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Nothing to do.
        if ([title isEqualToString:@"审批完成"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertDialog addAction:okAction];
    [self.navigationController presentViewController:alertDialog animated:YES completion:nil];
}

-(void)removeKeyNotice{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.view.frame = CGRectMake(0, 64, iphoneWidth, iphoneWidth);
//    _buttonReject.frame = CGRectMake(iphoneWidth - 230 , 125 + iphoneWidth * 2 / 3  , 100, 30);
//    _buttonAgreement.frame = CGRectMake(iphoneWidth - 230 +  110, 125 + iphoneWidth * 2 / 3  , 100, 30);
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
