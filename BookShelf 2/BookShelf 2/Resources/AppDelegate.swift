//
//  AppDelegate.swift
//  BookShelf
//
//  Created by Jerrick Warren on 10/29/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }


}

