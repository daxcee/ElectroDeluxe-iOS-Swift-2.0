//
//  NewsAPI.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class NewsEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
    
    init() {
        self.endpoint = APIEndpoint.News.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()

    }
    // MARK: Create
    func saveNewsList(newsList:Array<AnyObject>){
        
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
                
                if self.persistenceManager.checkIfItemExists(props, entity: EntityType.News, context: minionManagedObjectContextWorker){
                    
                    let item = NSEntityDescription.insertNewObjectForEntityForName("News",
                        inManagedObjectContext: minionManagedObjectContextWorker) as! News
                    
                    item.setValue(date, forKey: "date")
                    item.setValue(message, forKey: "message")
                    item.setValue(title, forKey: "title")
                    //item.setValue(images, forKey: "images")
                    
                    self.persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)
                    
                } else {
                    print("News item already exists: \(date) - \(title)")
                }
                
            }
            
            self.persistenceManager.mergeWithMainContext()
        })
    }
    
    // MARK: Read
    
    // MARK: Update
    
    // MARK: Delete
    
    func getAllNews() -> Array<News> {
        print("getAllNews")
        return [News]()
    }

    func getPath() -> String {
        return self.endpoint
    }
}