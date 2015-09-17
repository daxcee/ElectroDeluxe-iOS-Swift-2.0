//
//  ReadPermissionsEnum.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 15/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

private var fieldsNamespace = "fields"

enum FacebookReadPermissions:String {
    case email = "email"
    case friends = "user_friends"
    
    static let getAll = [email.rawValue,friends.rawValue]
    
    static func getReadPermissions() -> [NSObject:AnyObject] {
        return [fieldsNamespace: FacebookReadPermissions.getAll.joinWithSeparator(", ")]
    }
    
    static func getReadPermissions() -> [NSObject] {
        var readPermissions:[NSObject] = []
        readPermissions.append([fieldsNamespace: FacebookReadPermissions.getAll.joinWithSeparator(", ")])
        
        return readPermissions
    }
}