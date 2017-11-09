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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    
    NSString *sTextPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bada.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:sTextPath];
    
    NSString *sTextPathAccess = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/badaAccessToktn.txt"];
    NSDictionary *resultDicAccess = [NSDictionary dictionaryWithContentsOfFile:sTextPathAccess];
    
    NSLog(@"AppDic:\nid_key:%@,\n access_token:%@\n",  [resultDic objectForKey:@"id_key"] , [resultDicAccess objectForKey:@"access_token"]);
    
    if (resultDic[@"id_key"] == nil || resultDicAccess[@"access_token"] == NULL ) {
        
        AppCoverViewController * scanVC = [AppCoverViewController new];
        UINavigationController * scanNC = [[UINavigationController alloc] initWithRootViewController:scanVC];
        self.window.rootViewController = scanNC;
        
    } else{
        AppTBViewController * appTBVC = [AppTBViewController new];
//        self.window.rootViewController = appTBVC;
        NSLog(@"resultDicresultDicresultDicresultDicresultDicresultDicresultDic:%@", resultDic[@"name"] );
        
        
        UINavigationController * tbNC = [[UINavigationController alloc] initWithRootViewController:appTBVC];
        self.window.rootViewController = tbNC;
        
        
    }

    
//    int  switchs = 3;
//    if (switchs == 0) {
//
//        AppCoverViewController * appCoverVC = [AppCoverViewController new];
//        self.window.rootViewController = appCoverVC;
//
//    } else if (switchs == 1){
//
//        AppTBViewController * appTBVC = [AppTBViewController new];
//        self.window.rootViewController = appTBVC;
//
//    } else if (switchs == 3){
//
//        AppCoverViewController * scanVC = [AppCoverViewController new];
//        UINavigationController * scanNC = [[UINavigationController alloc] initWithRootViewController:scanVC];
//        self.window.rootViewController = scanNC;
//
//    }
    
   

    return YES;
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
