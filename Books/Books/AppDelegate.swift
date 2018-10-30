//
//  AppDelegate.swift
//  Books
//
//  Created by Sean Hendrix on 10/29/18.
//  Copyright © 2018 Sean Hendrix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = ViewController()
//        self.window?.makeKeyAndVisible()
        Manager.navigation.loadRoot(viewController: SplashScreenViewController())
        
        return true
    }




}

