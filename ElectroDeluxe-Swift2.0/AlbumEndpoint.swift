//
//  AlbumEndpoint.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 06/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class AlbumEndpoint {

    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
    
    init() {
        self.endpoint = APIEndpoint.Albums.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    
    // MARK: Create
    func saveAlbumsList(albumsList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }

    // MARK: Read
    func getAllAlbums() -> Array<Album> {
        print("getAllAlbums")
        return [Album]()
    }
    
    // MARK: Update
    
    // Mark: Delete
    
    func getPath() -> String {
        return self.endpoint
    }

}