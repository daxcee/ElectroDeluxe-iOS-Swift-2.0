//
//  EventAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class EventEndpoint {
    
    private var endpoint:String!
    
    init() {
        self.endpoint = APIEndpoint.Events.rawValue
    }
    
    func getAllEvents() -> Array<Event> {
        print("getAllEvents")
        return [Event]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}