//
//  AppDelegate.swift
//  数据库大作业
//
//  Created by William on 2018/5/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = BasicViewController.init()
        self.window?.rootViewController = UINavigationController.init(rootViewController: vc)
        self.window?.makeKeyAndVisible()
        
        //在后台创建表
        let dataBaseTool = ZWTSQLiteTool.shareInstance
        //没有表新建一张表
        
        if dataBaseTool.createTable(sql: "create table if not exists User_Table(UserName text primary key not null,passWord text not null,identifier text not null)") == false {
            print("新建用户表失败")
        }
        
        if dataBaseTool.createTable(sql: "create table if not exists Book_Table(BookID text primary key not null,BookName text not null,BookNumber integer not null,BookAuthor text not null,BookPublic text not null)") == false {
            print("新建图书表失败")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

