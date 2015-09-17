//
//  ArtistAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class ArtistEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!

    init() {
        self.endpoint = APIEndpoint.Artists.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    // MARK: Create
    
    func saveArtistsList(artistsList:Array<AnyObject>){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            
            let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            minionManagedObjectContextWorker.parentContext = self.mainContextInstance
            
            for index in 0...artistsList.count-1 {
                
                var artistItem:Dictionary<String, NSObject> = artistsList[index] as! Dictionary<String, NSObject>
                
                let name = artistItem["name"] as! String
                let bio = artistItem["bio"] as! String
                let website = artistItem["website"] as! String
                let facebookURL = artistItem["facebookURL"] as! String
                let soundcloudID = artistItem["soundcloudID"] as! String
                let soundcloudTrackListURL = artistItem["soundcloudTrackListURL"] as! String
                let soundcloudURL = artistItem["soundcloudURL"] as! String
                //let tracks = eventItem["venue"] as! String
                
                
                let props:Dictionary<String,AnyObject> = ["name":name, "soundcloudID":soundcloudID]
                
                if self.persistenceManager.checkIfItemExists(props, entity: EntityType.Artist, context: minionManagedObjectContextWorker){
                    
                    let item = NSEntityDescription.insertNewObjectForEntityForName("Artist",
                        inManagedObjectContext: minionManagedObjectContextWorker) as! Artist
                    
                    item.setValue(name, forKeyPath: "name")
                    item.setValue(bio, forKeyPath: "bio")
                    item.setValue(website, forKeyPath: "website")
                    item.setValue(facebookURL, forKeyPath: "facebookURL")
                    item.setValue(soundcloudID, forKeyPath: "soundcloudID")
                    item.setValue(soundcloudTrackListURL, forKeyPath: "soundcloudTrackListURL")
                    item.setValue(soundcloudURL, forKeyPath: "soundcloudURL")
                    
                    self.persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)
                    
                    
                } else {
                    print("Artist item already exists: \(name)")
                }
            }
            
            self.persistenceManager.mergeWithMainContext()
        })
    }

    // MARK: Read
    
    // MARK: Update
    
    // MARK: Delete
    
    func getAllArtists() -> Array<Artist> {
        print("getAllArtists")
        return [Artist]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}