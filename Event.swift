//
//  Event.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)

class Event: NSManagedObject {
    @NSManaged var date: NSDate?
    @NSManaged var title: String?
    @NSManaged var venue: String?
    @NSManaged var city: String?
    @NSManaged var country: String?
    @NSManaged var images: NSObject?
    @NSManaged var artists: NSObject?
}

enum EventAttributes : String {
    case
    title      = "title",
    date       = "date",
    venue      = "venue",
    city       = "city",
    country    = "country",
    artists      = "artists",
    images = "images"
    
    static let getAll = [
        title,
        date,
        venue,
        city,
        country,
        artists,
        images
    ]
}

