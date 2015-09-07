//
//  PersistenceManager.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager: NSObject {
    
    private var appDelegate:AppDelegate
    private var mainContextInstance:NSManagedObjectContext

    override init(){
        appDelegate = AppDelegate().sharedInstance()
        mainContextInstance = ContextManager.init().mainManagedObjectContextInstance
        super.init()
    }
    
    func saveItems(response:Array<AnyObject>, entity:EntityType) {
       
        switch entity {
        case .News:
            print("save items for NEWS entity")
            self.saveNewsList(response)
            break
        case .Artist:
            self.saveArtistsList(response)
            break
        case .Track:
            self.saveTracksList(response)
            break
        case .Album:
            self.saveAlbumsList(response)
            break
        case .Event:
            print("save items for EVENT entity")
            self.saveEventsList(response)
            break
        case .Video:
            self.saveVideosList(response)
            break
        case .Genre:
            self.saveGenresList(response)
            break
        }

    }
    
    private func checkIfItemExists(itemDetails:Dictionary<String,AnyObject>,
        entity:EntityType, context:NSManagedObjectContext) -> Bool{
        
        let fetchRequest = NSFetchRequest(entityName: entity.rawValue)
        fetchRequest.returnsObjectsAsFaults = false;
        
        var predicates:Array<NSPredicate> = [NSPredicate]()
        
        for(key,value) in itemDetails {
            if key == "date" {
                let predicate = NSPredicate(format: "\(key) == %@", value as! NSDate)
                predicates.append(predicate)
            } else {
                let predicate = NSPredicate(format: "\(key) = %@", value as! String)
                predicates.append(predicate)
            }
        }
        
       let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        
        var error: NSError? = nil
        let count =  context.countForFetchRequest(fetchRequest, error: &error)
        
        if (error != nil) {
            print("\(error?.localizedDescription)")
        }
        
        return (count == 0)
    }
    
    private func saveNewsList(newsList:Array<AnyObject>){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            
            let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            minionManagedObjectContextWorker.parentContext = self.mainContextInstance
            
            for index in 0...newsList.count-1 {
                var newsItem:Dictionary<String, NSObject> = newsList[index] as! Dictionary<String, NSObject>
                var dateStr = newsItem["date"] as! String
                let date = dateStr.toNSDate()
                let message:String = newsItem["message"] as! String
                let title:String = newsItem["title"] as! String
                
                let props:Dictionary<String,AnyObject> = [ "title":title, "message":message, "date":date]
                
                if self.checkIfItemExists(props, entity: EntityType.News, context: minionManagedObjectContextWorker){
                    
                    let item = NSEntityDescription.insertNewObjectForEntityForName("News",
                    inManagedObjectContext: minionManagedObjectContextWorker) as! News
                    
                    item.setValue(date, forKey: "date")
                    item.setValue(message, forKey: "message")
                    item.setValue(title, forKey: "title")
                    //item.setValue(images, forKey: "images")
                    
                    self.saveWorkerContext(minionManagedObjectContextWorker)

                } else {
                    print("News item already exists: \(date) - \(title)")
                }
                
            }
        
            //if minionManagedObjectContextWorker.hasChanges {
                self.mergeWithMainContext()
            //}
        })
    }
    
    private func saveEventsList(eventsList:Array<AnyObject>){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            
            let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
            minionManagedObjectContextWorker.parentContext = self.mainContextInstance
            
            for index in 0...eventsList.count-1 {
                var eventItem:Dictionary<String, NSObject> = eventsList[index] as! Dictionary<String, NSObject>
                
                if eventItem["date"] != "" && eventItem["title"] != ""  && eventItem["city"] != ""  {
                    
                    var dateStr = eventItem["date"] as! String
                    let date = dateStr.toNSDate()
                    let title = eventItem["title"] as! String
                    let city = eventItem["city"] as! String
                    let venue = eventItem["venue"] as! String
                    let country = eventItem["country"] as! String

                    let props:Dictionary<String,AnyObject> = [ "title":title, "city":city, "date":date]
                    
                    if self.checkIfItemExists(props, entity: EntityType.Event, context: minionManagedObjectContextWorker){
                        
                        let item = NSEntityDescription.insertNewObjectForEntityForName("Event",
                            inManagedObjectContext: minionManagedObjectContextWorker) as! Event
                        
                        item.setValue(date, forKey: "date")
                        item.setValue(title, forKey: "title")
                        item.setValue(city, forKey: "city")
                        item.setValue(venue, forKey: "venue")
                        item.setValue(country, forKey: "country")
                        // item.setValue(images, forKey:"images")
                        
                        self.saveWorkerContext(minionManagedObjectContextWorker)

                        
                    } else {
                        print("Event item already exists: \(date) - \(title)")
                    }
                }
            }
            //if minionManagedObjectContextWorker.hasChanges {
                self.mergeWithMainContext()
            //}
        })

    }

    private func saveArtistsList(artistsList:Array<AnyObject>){
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
                
                if self.checkIfItemExists(props, entity: EntityType.Artist, context: minionManagedObjectContextWorker){
                    
                    let item = NSEntityDescription.insertNewObjectForEntityForName("Artist",
                        inManagedObjectContext: minionManagedObjectContextWorker) as! Artist
                    
                    item.setValue(name, forKeyPath: "name")
                    item.setValue(bio, forKeyPath: "bio")
                    item.setValue(website, forKeyPath: "website")
                    item.setValue(facebookURL, forKeyPath: "facebookURL")
                    item.setValue(soundcloudID, forKeyPath: "soundcloudID")
                    item.setValue(soundcloudTrackListURL, forKeyPath: "soundcloudTrackListURL")
                    item.setValue(soundcloudURL, forKeyPath: "soundcloudURL")

                    self.saveWorkerContext(minionManagedObjectContextWorker)
                    
                    
                } else {
                    print("Artist item already exists: \(name)")
                }
            }
            
            //if minionManagedObjectContextWorker.hasChanges {
                self.mergeWithMainContext()
           // }
        })

    }
    
    private func saveAlbumsList(albumsList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }
    
    private func saveGenresList(genresList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }
    
    private func saveVideosList(videosList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }
    
    private func saveTracksList(tracksList:Array<AnyObject>){
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance
    }
    
    private func saveWorkerContext(workerContext: NSManagedObjectContext){
        //Persist new Event to datastore (via Managed Object Context Layer).
        do {
            print("saving event item - minion")
            try workerContext.save()
        } catch let saveError as NSError {
            print("saveEventItem error: \(saveError.localizedDescription)")
        }
        
    }
    
    private func mergeWithMainContext(){
        do {
            print("merging context worker with main")
            try self.mainContextInstance.save()
        } catch let saveError as NSError {
            print("synWithMainContext error: \(saveError.localizedDescription)")
        }
    }
    
}