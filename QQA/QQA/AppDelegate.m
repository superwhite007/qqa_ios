//
//  AppDelegate.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppDelegate.h"
#import "AppTBViewController.h"
#import "AppCoverViewController.h"
#import "AppCoverViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "AFAppDotNetAPIClient.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic, assign) BOOL isOK;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //网络
    [AFAppDotNetAPIClient sharedClient];

    _isOK = NO;
   
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    NSString *sTextPathPermissions = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Permissions.txt"];
    NSDictionary *resultPermissions = [NSDictionary dictionaryWithContentsOfFile:sTextPathPermissions];

    if (resultDic[@"idKey"] == nil || resultDicAccess[@"accessToken"] == NULL ) {
        AppCoverViewController * scanVC = [AppCoverViewController new];
        UINavigationController * scanNC = [[UINavigationController alloc] initWithRootViewController:scanVC];
        self.window.rootViewController = scanNC;
    } else{
        AppTBViewController * appTBVC = [AppTBViewController new];
        UINavigationController * tbNC = [[UINavigationController alloc] initWithRootViewController:appTBVC];
        self.window.rootViewController = tbNC;
    }
    
//    [UMessage startWithAppkey:@"5a3b0340f29d982788000edc" launchOptions:launchOptions httpsenable:YES ];
//    [UMessage registerForRemoteNotifications];
//
//    //iOS10必须加下面这段代码。
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate=self;
//    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
//    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            //点击允许
//            //这里可以添加一些自己的逻辑
//        } else {
//            //点击不允许
//            //这里可以添加一些自己的逻辑
//        }
//    }];
//
//    //打开日志，方便调试
//    [UMessage setLogEnabled:YES];
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        //设置预设好的交互类型，NSSet里面是设置好的UNNotificationCategory
        //    [center setNotificationCategories:[self createNotificationCategoryActions]];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus==UNAuthorizationStatusNotDetermined) {
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                    } else {
                    }
                }];
            }
            else{
                //do other things
            }
        }];
        
    }else if (@available(iOS 8.0, *)) {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
        
    }
    // 必须写代理，不然无法监听通知的接收与点击
    
    [application registerForRemoteNotifications];
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   
    NSLog(@"------token------%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    NSString * tokenStr = [NSString stringWithFormat:@"%@", [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                                                             stringByReplacingOccurrencesOfString: @" " withString: @""]];
//    if (!_isOK) {
        [self sendUMdevicetokenToServer:tokenStr];
//    }
}


-(void)sendUMdevicetokenToServer:(NSString *)UMdevicetoken{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:UMdevicetoken forKey:@"devicetoken"];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentfilePath = paths.firstObject;
    NSString *txtPath = [documentfilePath stringByAppendingPathComponent:@"devicetokentoken.txt"];
    [dict  writeToFile:txtPath atomically:YES];
    
    _isOK = YES;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/api/user/device/store", CONST_SERVER_ADDRESS]];
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
    [mdict setObject:@"IOS_APP" forKey:@"clientType"];//deviceToken
    [mdict setObject:UMdevicetoken forKey:@"deviceToken"];
    NSError * error = nil;
    NSLog(@"mdict:%@", mdict);
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mdict options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            NSLog(@"error%@", error);
                                            if (data != nil) {
                                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                NSLog(@"通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知2：%@", dict);
                                                
//                                                dispatch_async(dispatch_get_main_queue(), ^{
//
//                                                });
                                            } else{
                                                //NSLog(@"获取数据失败，问");
                                            }
                                        }];
    [task resume];
}



//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"以下使用这个方法接收通知didReceiveRemoteNotification");
    //关闭U-Push自带的弹出框
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
//    [UMessage setAutoAlert:NO];
//    [UMessage didReceiveRemoteNotification:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"处理前台收到通知的代理方法userInfo:%@", userInfo);
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
