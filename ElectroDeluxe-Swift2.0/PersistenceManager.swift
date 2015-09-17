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
    
    //Utilize Singleton pattern by instanciating PersistenceManager only once.
    class var sharedInstance: PersistenceManager {
        struct Singleton {
            static let instance = PersistenceManager()
        }
        
        return Singleton.instance
    }

    override init(){
        appDelegate = AppDelegate().sharedInstance()
        mainContextInstance = ContextManager.init().mainManagedObjectContextInstance
        super.init()
    }
    
    func getMainContextInstance() -> NSManagedObjectContext {
        return self.mainContextInstance
    }
    
    func checkIfItemExists(itemDetails:Dictionary<String,AnyObject>,
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
    
    
    func saveWorkerContext(workerContext: NSManagedObjectContext){
        //Persist new Event to datastore (via Managed Object Context Layer).
        do {
            print("saving minion worker context")
            try workerContext.save()
        } catch let saveError as NSError {
            print("save minion worker error: \(saveError.localizedDescription)")
        }
    }
    
    func mergeWithMainContext(){
        do {
            print("merging minion workers with main context")
            try self.mainContextInstance.save()
        } catch let saveError as NSError {
            print("synWithMainContext error: \(saveError.localizedDescription)")
        }
    }
    
}