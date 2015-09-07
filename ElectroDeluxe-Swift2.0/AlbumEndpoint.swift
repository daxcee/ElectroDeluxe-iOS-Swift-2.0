//
//  AlbumEndpoint.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class AlbumEndpoint {

    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Albums.rawValue
    }
    
    func getAllAlbums() -> Array<Album> {
        print("getAllAlbums")
        return [Album]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }

}