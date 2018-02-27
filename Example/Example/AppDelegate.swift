//
//  AppDelegate.swift
//  Example
//
//  Created by Steewe MacBook Pro on 26/02/18.
//  Copyright © 2018 Steewe MacBook Pro. All rights reserved.
//

import UIKit
import STWTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller1 = ViewController()
        controller1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 1)
        controller1.title = "Favorites"
        controller1.view.backgroundColor = .cyan
        
        let controller2 = ViewController()
        controller2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.history, tag: 2)
        controller2.title = "History"
        controller2.view.backgroundColor = .orange
        
        let controller3 = TableViewController()
        controller3.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.featured, tag: 3)
        controller3.title = "Featured"
        controller3.view.backgroundColor = .white
        
        let controller4 = ViewController()
        controller4.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 4)
        controller4.title = "Bookmarks"
        controller4.view.backgroundColor = .green
        
        let tabController = STWTabBarController()
        
        tabController.setViewControllers([controller1,controller2,controller3,controller4], animated: false)
        
        tabController.title = "STWTabBarController"
        self.window?.rootViewController = UINavigationController(rootViewController:tabController)
        self.window?.makeKeyAndVisible()

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

