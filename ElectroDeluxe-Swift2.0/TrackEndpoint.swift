//
//  TrackAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class TrackEndpoint {
    
    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Tracks.rawValue
    }
    
    func getAllTracks() -> Array<Track> {
        print("getAllTracks")
        return [Track]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}