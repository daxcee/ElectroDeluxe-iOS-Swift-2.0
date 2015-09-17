//
//  FacebookLoginViewController.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 14/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class FacebookLoginViewController: UIViewController {
    
    private var facebookLoginManager:FacebookLoginManager!
    private var user:User!
    var delegate:RegisteredUserDelegate?
    
    @IBAction func fbLoginBtn(sender: UIButton) {
        self.pressed(sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.facebookLoginManager = FacebookLoginManager.sharedInstance
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressed(sender: UIButton!) {
    
        self.facebookLoginManager.doLogin({(user) in
            
            guard user != nil  else {
                print("login failed..")
                return
            }
            
            
            //move to main menu
            self.delegate!.registeredUser(user!)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    
    }
    
      

    
}

