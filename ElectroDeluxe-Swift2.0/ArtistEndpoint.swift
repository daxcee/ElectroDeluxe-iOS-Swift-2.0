//
//  ArtistAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class ArtistEndpoint {
    
    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Artists.rawValue
    }
    
    func getAllArtists() -> Array<Artist> {
        print("getAllArtists")
        return [Artist]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}