//
//  TrackAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class TrackEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
  
    init() {
        self.endpoint = APIEndpoint.Tracks.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    // MARK: Create
    
    
    func saveTracksList(tracksList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }

    
    // MARK: Read
    
    // MARK: Update
    
    // MARK: Delete
    
    func getAllTracks() -> Array<Track> {
        print("getAllTracks")
        return [Track]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}