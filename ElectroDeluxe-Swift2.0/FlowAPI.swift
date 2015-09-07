//
//  FlowAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

enum APIParameters : String {
    case
    fields = "fields",
    sort = "sort",
    order = "order",
    token = "token",
    result = "result",
    limit = "limit",
    offset = "offset",
    asc = "asc",
    desc = "desc"
    
    static let getAll = [fields,sort,order,token,result,limit,offset,asc,desc]
}

class FlowAPI {
    
    private var news:NewsEndpoint!
    private var artists:ArtistEndpoint!
    private var tracks:TrackEndpoint!
    private var videos:VideoEndpoint!
    private var genres:GenreEndpoint!
    private var events:EventEndpoint!
    private var albums:AlbumEndpoint!
    private var basePath:String = "https://flow-api.herokuapp.com/api/v1/"
    private var resultLimit = 4000
    
    class var sharedInstance: FlowAPI {
        struct Singleton {
            static let instance = FlowAPI()
        }
        
        return Singleton.instance
    }
    
    init(){
        self.artists = ArtistEndpoint()
        self.news = NewsEndpoint()
        self.tracks = TrackEndpoint()
        self.videos = VideoEndpoint()
        self.genres = GenreEndpoint()
        self.events = EventEndpoint()
        self.albums = AlbumEndpoint()
    }
    
    lazy var defaultBasePath:String = {
       return self.basePath
    }()
    
    lazy var defaultResultLimit: Int = {
        return self.resultLimit
    }()
    
    lazy var newsEndpoint: NewsEndpoint = {
        return self.news
    }()

    lazy var artistsEndpoint: ArtistEndpoint = {
        return self.artists
    }()
    
    lazy var tracksEndpoint: TrackEndpoint = {
        return self.tracks
    }()
    
    lazy var videosEndpoint: VideoEndpoint = {
        return self.videos
    }()
    
    lazy var genresEndpoint: GenreEndpoint = {
        return self.genres
    }()
    
    lazy var eventsEndpoint: EventEndpoint = {
        return self.events
    }()
    
    lazy var albumsEndpoint: AlbumEndpoint = {
        return self.albums
    }()

}