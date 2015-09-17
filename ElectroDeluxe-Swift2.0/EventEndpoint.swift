//
//  EventAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class EventEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
    
    init() {
        self.endpoint = APIEndpoint.Events.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    // MARK: Create
    
    func saveEventsList(eventsList:Array<AnyObject>){
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
                    
                    if self.persistenceManager.checkIfItemExists(props, entity: EntityType.Event, context: minionManagedObjectContextWorker){
                        
                        let item = NSEntityDescription.insertNewObjectForEntityForName("Event",
                            inManagedObjectContext: minionManagedObjectContextWorker) as! Event
                        
                        item.setValue(date, forKey: "date")
                        item.setValue(title, forKey: "title")
                        item.setValue(city, forKey: "city")
                        item.setValue(venue, forKey: "venue")
                        item.setValue(country, forKey: "country")
                        // item.setValue(images, forKey:"images")
                        
                        self.persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)
                        
                        
                    } else {
                        print("Event item already exists: \(date) - \(title)")
                    }
                }
            }

            self.persistenceManager.mergeWithMainContext()
        })
    }

    
    // MARK: Read
    
    // MARK: Update
    
    // MARK: Delete
    func getAllEvents() -> Array<Event> {
        print("getAllEvents")
        return [Event]()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
}