//
//  FacebookAuthenticator.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 14/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FlowAuthenticator {
    
    private var token:String!
    private var flowAPI:FlowAPI

    init(){
        self.flowAPI = FlowAPI.sharedInstance
    }
    
    func registerWithBackend(fbId:String, callback:(user:User?)-> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(defaults.boolForKey("registeredWithBackend")) {
            print("already registered with backend")
            callback(user: self.flowAPI.authenticateEndpoint.getCredentials(FBSDKAccessToken.currentAccessToken().userID))
            return
        } else {
            if (!self.checkIfTokenIsPresent()) {
                print("no token present")
                callback(user:nil)
                return
            }
        }
        
        print("register with backend")
        
        let url:String = self.flowAPI.defaultBasePath +  self.flowAPI.authenticateEndpoint.getPath()
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.setValue(self.token, forHTTPHeaderField: "authorization")
        print("token: \(self.token)")
        
        HTTPClient().doGet(request) { (data, error, httpStatusCode) -> Void in
            
            if (httpStatusCode == nil){
                print("Connection error: \(error!.localizedDescription)")
                callback(user:nil)

                return
            }
            
            if (httpStatusCode != nil) {
                
                if httpStatusCode!.rawValue == HTTPStatusCode.OK.rawValue {
                    
                    print("\(httpStatusCode!.rawValue) \(httpStatusCode)")
                    
                    if(data == nil) {
                        print("No data returned")
                        callback(user:nil)

                        return
                    }
                    
                    do {
                        let jsonResult:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                        self.flowAPI.authenticateEndpoint.saveCredentials(jsonResult, callback: callback)
                    } catch let fetchError as NSError {
                        print("pull error: \(fetchError.localizedDescription)")
                        callback(user:nil)

                    }
                }
                else if httpStatusCode!.rawValue == HTTPStatusCode.Unauthorized.rawValue {
                    print("Unauthorised: \(httpStatusCode!.rawValue) \(httpStatusCode)")
                    callback(user:nil)


                } else {
                    print("register with backend error:\(error?.localizedDescription)")
                    callback(user:nil)

                }
            }
        }
        
    }
    
    private func checkIfTokenIsPresent() -> Bool {
        
        if getToken() != nil {
            self.token = getToken()
            print("Token found, using fbtoken from SDK")
            return true
        }
        
        let appDelegate : AppDelegate = AppDelegate().sharedInstance()
        let errMessage = "token needs to be set: set via Edit Scheme -> Environment variables, add Key=FLOW_API_TOKEN Value=token_value\nA valid token can be requested via: https://flow-api.herokuapp.com/token-request"
        
        do{
            try self.token = appDelegate.getAPIToken()
            print("Token found, using Environment Token variable.")
        } catch AuthError.TokenIsMissing {
            print(errMessage)
            return false
        } catch {
            print(errMessage)
        }

        return false
    }
    
    private func getToken() -> String? {
        var token:String?
        
        if (FBSDKAccessToken.currentAccessToken() != nil){
            token = FBSDKAccessToken.currentAccessToken().tokenString;
            print("current token: \(token)")
        }
        
        return token
    }
}