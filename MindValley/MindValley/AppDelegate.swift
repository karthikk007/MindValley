//
//  AppDelegate.swift
//  MindValley
//
//  Created by Kumar, Karthik on 29/05/20.
//  Copyright © 2020 Kumar, Karthik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        
        let coordinator = RootCoordinator(navigationController: navigationController)
        coordinator.start()
        
        window?.rootViewController = navigationController
        
        
        let diskCacheSize = 500*1024*1024 // 500MB
        URLCache.configSharedCache(disk: diskCacheSize)
        imageCache.countLimit = 100
        
        return true
    }


}

