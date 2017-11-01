//
//  AppDelegate.m
//  QQA
//
//  Created by wang huiming on 2017/11/1.
//  Copyright © 2017年 youth_huiming. All rights reserved.
//

#import "AppDelegate.h"
#import "MeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MeViewController * meVC = [MeViewController new];
    meVC.tabBarItem.title = @"我";
//    meVC.tabBarItem.image = [[UIImage imageNamed:@"account.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    
    MeViewController * meVCFirst = [MeViewController new];
    meVCFirst.tabBarItem.title = @"公司";
//    meVCFirst.tabBarItem.image = [UIImage imageNamed:@"account.png"];
//    [meVCFirst.tabBarItem setImage:[UIImage imageNamed:@"account.png"]];
    
    
    MeViewController * meVCSecond = [MeViewController new];
    meVCSecond.tabBarItem.title = @"审批";
//    meVCSecond.tabBarItem.image = [UIImage imageNamed:@"styles.png"];
    
    MeViewController * meVCThird = [MeViewController new];
    meVCThird.tabBarItem.title = @"打卡";
//    meVCThird.tabBarItem.image = [UIImage imageNamed:@"me_normal.png"];
    
    
    UITabBarController * tBarcontroller = [UITabBarController new];
    tBarcontroller.viewControllers = [NSArray arrayWithObjects:meVCFirst, meVCSecond, meVCThird, meVC, nil];
    tBarcontroller.tabBar.tintColor = [UIColor purpleColor];
    
   
    
    self.window.rootViewController = tBarcontroller;
    
    
    meVC.tabBarItem.image = [[UIImage imageNamed:@"account.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    [meVCFirst.tabBarItem setImage:[UIImage imageNamed:@"account.png"]];
    meVCSecond.tabBarItem.image = [UIImage imageNamed:@"styles.png"];
    meVCThird.tabBarItem.image = [UIImage imageNamed:@"me_normal.png"];
    
    
    
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
