//
//  AppDelegate.m
//  记账本
//
//  Created by William on 2018/2/13.
//  Copyright © 2018年 William. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "PlistManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建plist文件保存数据
    NSArray *products = @[
                          @"洗发水",
                          @"发膜",
                          @"精油",
                          @"沐浴露",
                          @"眼霜",
                          @"洗面奶",
                          @"活肤水",
                          @"精华乳",
                          @"素颜霜",
                          @"面膜",
                          @"胶原",
                          @"密罗木面霜",
                          @"眼罩",
                          @"口红",
                          @"洁牙慕斯"
                          ];
    NSArray *units = @[
                       @"支",
                       @"个",
                       @"盒",
                       @"瓶",
                       @"箱"
                       ];
    
    [PlistManager writePlistFileWithData:products andFileName:@"products"];
    [PlistManager writePlistFileWithData:units andFileName:@"units"];
//    //写入账单的Plist
//    [PlistManager writePlistFileWithData:[NSArray array] andFileName:@"bills"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    //显示
    [self.window makeKeyAndVisible];
    
    
    
    
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
