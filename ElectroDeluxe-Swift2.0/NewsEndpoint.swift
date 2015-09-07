//
//  NewsAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class NewsEndpoint {
    
    private var endpoint:String!

    init() {
        self.endpoint = APIEndpoint.News.rawValue
    }
    
    func getAllNews() -> Array<News> {
        print("getAllNews")
        return [News]()
    }

    func getPath() -> String {
        return self.endpoint
    }
}