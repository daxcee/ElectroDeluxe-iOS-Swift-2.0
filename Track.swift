//
//  Track.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(Track)

class Track: NSManagedObject {
    @NSManaged var albums: NSObject?
    @NSManaged var artists: NSObject?
    @NSManaged var duration: NSNumber?
    @NSManaged var genres: NSObject?
    @NSManaged var title: String?

}
