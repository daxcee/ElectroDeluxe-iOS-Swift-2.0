//
//  News.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(News)



class News: NSManagedObject {
    @NSManaged var date: NSDate?
    @NSManaged var images: NSObject?
    @NSManaged var message: String?
    @NSManaged var title: String?
}

enum NewsAttributes : String {
    case
    date = "date",
    title = "title",
    images = "images",
    message = "message"
    
    static let getAll = [
        title,
        date,
        message
    ]
}