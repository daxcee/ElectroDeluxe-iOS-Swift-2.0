//
//  Video.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(Video)

class Video: NSManagedObject {
    @NSManaged var title: String?
    @NSManaged var duration: NSNumber?
}
