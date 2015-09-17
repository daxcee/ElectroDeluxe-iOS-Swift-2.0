//
//  EndpointsEnum.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 05/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

enum APIEndpoint:String {
    
    case News = "news"
    case Artists = "artists"
    case Tracks = "tracks"
    case Events = "events"
    case Albums = "albums"
    case Genres = "genres"
    case Videos = "videos"
    case Authenticate = "authenticate"

    static let getAll = [News, Artists, Tracks, Events, Albums, Genres, Videos, Authenticate]
}