//
//  Genre.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(Genre)

class Genre: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var subGenres: NSObject?
}
