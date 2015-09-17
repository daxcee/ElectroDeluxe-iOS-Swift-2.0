//
//  FacebookLogin.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 14/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginManager {
    
    private var loginManager:FBSDKLoginManager!
    private var flowAuthenticator:FlowAuthenticator!
    private var facebookGraph:FacebookGraph!
    private var flowAPI:FlowAPI!
    
    //Utilize Singleton pattern by instanciating PersistenceManager only once.
    class var sharedInstance: FacebookLoginManager {
        struct Singleton {
            static let instance = FacebookLoginManager()
        }
        
        return Singleton.instance
    }
    
    init(){
        self.loginManager = FBSDKLoginManager()
        self.flowAuthenticator = FlowAuthenticator()
        self.facebookGraph = FacebookGraph()
        self.flowAPI = FlowAPI.sharedInstance
    }
    
    func getLoginManagerInstance() -> FBSDKLoginManager {
        return self.loginManager
    }
    
    func getUser() -> User? {
        var user:User? = nil
        
        if(FBSDKAccessToken.currentAccessToken()) != nil{
            user = self.flowAPI.authenticateEndpoint.getCredentials(FBSDKAccessToken.currentAccessToken().userID)
        }
        
        if user != nil {
            return user!
        }
       
        return nil
    }
    func doLogin(loginCallback: (User?) -> ()) {
        
        loginManager .logInWithReadPermissions(FacebookReadPermissions.getAll, handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if error != nil {
                print("login error: \(error!.localizedDescription)")
            } else if result.isCancelled {
                print("login cancelled")
            } else {
                if result.grantedPermissions .contains(FacebookReadPermissions.email.rawValue) && result.grantedPermissions .contains(FacebookReadPermissions.friends.rawValue){
                    
                    print("login success: \(result.token.userID)")
                    
                    self.flowAuthenticator.registerWithBackend(result.token.userID, callback: {(user:User?) in
                        loginCallback(user)
                    })
                }
            }
        })
    
    }

    func doLogout(){
        loginManager.logOut()
    }
}