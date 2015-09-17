//
//  VideoAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class VideoEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
    
    init() {
        self.endpoint = APIEndpoint.Videos.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    // MARK: Create
    
    func saveVideosList(videosList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }
    
    // MARK: Read
    
    // MARK: Update
    
    // MARK: Delete
    
    func getAllVideos() -> Array<Video> {
        print("getAllVideos")
        return [Video]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}