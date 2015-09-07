//
//  Artist.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

@objc(Artist)

class Artist: NSManagedObject {
    @NSManaged var bio: String?
    @NSManaged var facebookURL: String?
    @NSManaged var name: String?
    @NSManaged var soundcloudID: String?
    @NSManaged var website: String?
    @NSManaged var soundcloudTrackListURL: String?
    @NSManaged var soundcloudURL: String?
    @NSManaged var tracks: NSOrderedSet?
}
