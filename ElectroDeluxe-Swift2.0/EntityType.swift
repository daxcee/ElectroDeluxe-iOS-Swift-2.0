//
//  Entities.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

enum EntityType:String {
    
    case News = "News"
    case Artist = "Artist"
    case Track = "Track"
    case Album = "Album"
    case Video = "Video"
    case Genre = "Genre"
    case Event = "Event"

    static let getAll = [News,Artist,Track,Album,Video,Genre,Event]
}

