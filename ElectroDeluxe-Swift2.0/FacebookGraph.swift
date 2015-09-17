//
//  FacebookGraphAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 15/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import FBSDKCoreKit

class FacebookGraph {
  
    func getProfile(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: FacebookReadPermissions.getReadPermissions())
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if error != nil {
                print("Error: \(error.localizedDescription)")
            }
            
            let facebookid = result.valueForKey("id") as! String
            let userName = result.valueForKey("name") as! String
            let userEmail = result.valueForKey("email") as? String
            print("fbId: \(facebookid)\nemail:\(userEmail)\nname:\(userName)")
            
        })
    }
    
    
    func getProfilePicture(userId:String) -> Dictionary<String,AnyObject>?{
        var response:Dictionary<String,AnyObject>?
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/\(userId)/picture", parameters:FacebookReadPermissions.getReadPermissions())
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if error != nil {
                print("login error: \(error!.localizedDescription)")
                return
            }
            
            print("get profile pict res: \(response)")

            response = result as? Dictionary<String,AnyObject>
            
            
        })
        
        return response
    }
}