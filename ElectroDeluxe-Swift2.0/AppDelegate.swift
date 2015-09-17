//
//  AppDelegate.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //TOKEN PASSED AS ENVIRONMENT VAR
    //set via Edit Scheme -> Environment variables, add Key=FLOW_API_TOKEN Value=token_value
    private var tokenNamespace = "FLOW_API_TOKEN"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Debug - location of sqlite db file
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print("Debug - location of sqlite db file:\n\(paths[0])\n")

        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
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
    
    func getAPIToken() throws -> String? {
        
        let env = NSProcessInfo.processInfo().environment
        
        guard let token:String = env[tokenNamespace] where token.characters.count > 0 else {
            throw AuthError.TokenIsMissing
        }
        
        return env[tokenNamespace]!
    }
}

