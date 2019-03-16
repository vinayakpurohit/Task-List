//
//  AppDelegate.swift
//  Task List
//
//  Created by Vinayak Purohit on 04/03/19.
//  Copyright © 2019 Vinayak Purohit. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            _ = try Realm()
        } catch  {
            print("Error initializing Realm,\(error)")
        }
        
        
        
        return true
    }



}

