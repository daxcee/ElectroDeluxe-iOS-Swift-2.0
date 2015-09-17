//
//  User.swift
//  
//
//  Created by c0d3r on 14/09/15.
//
//

import Foundation
import CoreData

@objc(User)

class User: NSManagedObject {
    @NSManaged var fbId: String?
    @NSManaged var name: String?
    @NSManaged var email: String?
}

enum UserAttributes: String {
    
    case fbId = "fbId"
    case name = "title"
    case email = "images"
    case profilePicture = "profilePicture"
    
    static let getAll = [
        fbId.rawValue,
        name.rawValue,
        email.rawValue,
        profilePicture.rawValue
    ]
}