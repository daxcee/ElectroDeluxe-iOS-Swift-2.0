//
//  AppDelegate.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Debug - location of sqlite db file
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths[0])

        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
    
    
    func sharedInstance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    lazy var datastoreCoordinator: DatastoreCoordinator = {
        return DatastoreCoordinator()
    }()
    
    lazy var contextManager: ContextManager = {
        return ContextManager()
    }()
}

