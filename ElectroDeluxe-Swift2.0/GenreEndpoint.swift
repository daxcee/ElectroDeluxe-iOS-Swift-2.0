//
//  GenreAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class GenreEndpoint {
    
    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Genres.rawValue
    }
    
    func getAllGenres() -> Array<Genre> {
        print("getAllGenres")
        return [Genre]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}