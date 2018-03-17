//
//  AppDelegate.m
//  UIWindow的使用
//
//  Created by William on 2017/12/27.
//  Copyright © 2017年 William. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@property (strong, nonatomic) UIWindow *window2;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建一个UIWindow
    self.window = [[UIWindow alloc] init];
   
    //添加根控制器
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    self.window.rootViewController = vc;
    //显示window
    [self.window makeKeyAndVisible];
    
    self.window2 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 20, 375, 50)];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor blueColor];
    self.window2.rootViewController = vc2;
    [self.window2 makeKeyAndVisible];
    //设置窗口层级
    //UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    self.window2.windowLevel = UIWindowLevelStatusBar;
    
    
    
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
