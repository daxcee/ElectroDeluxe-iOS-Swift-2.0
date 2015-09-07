//
//  VideoAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class VideoEndpoint {
    
    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Videos.rawValue
    }
    
    func getAllVideos() -> Array<Video> {
        print("getAllVideos")
        return [Video]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}