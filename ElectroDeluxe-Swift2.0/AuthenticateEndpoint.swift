//
//  AuthenticateEndpoint.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 14/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation
import CoreData

class AuthenticateEndpoint {
    
    private var endpoint:String!
    private let persistenceManager: PersistenceManager!
    private var mainContextInstance:NSManagedObjectContext!
    
    init() {
        self.endpoint = APIEndpoint.Authenticate.rawValue
        self.persistenceManager = PersistenceManager.sharedInstance
        self.mainContextInstance = persistenceManager.getMainContextInstance()
    }
    
    func getPath() -> String {
        return self.endpoint
    }
    
    // MARK: Create
    
    func saveCredentials(response:AnyObject!, callback:(User)->Void){
        print("save credentials")
        
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance

        let item = NSEntityDescription.insertNewObjectForEntityForName("User",
            inManagedObjectContext: minionManagedObjectContextWorker) as! User
        
        var jsonData = response["user"] as! Dictionary<String,AnyObject>
        let fbId = jsonData["fbId"] as! String
        let name = jsonData["name"]as! String
        let email = jsonData["email"]as! String
        
        item.setValue(name, forKey: "name")
        item.setValue(fbId,forKey:"fbId")
        item.setValue(email,forKey:"email")
        
        print("SAVE fbId: \(item.fbId) name: \(item.name) email:\(item.email)")
        
        persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)
        persistenceManager.mergeWithMainContext()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "registeredWithBackend")
        
        callback(item)
    }
    
    // MARK: Read
    
    func getCredentials(fbId: String) -> User? {
        let minionManagedObjectContextWorker:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        minionManagedObjectContextWorker.parentContext = mainContextInstance

        
        // Create request on User entity
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.returnsObjectsAsFaults = false;
        
        //Add a predicate to filter by userId
        let findByIdPredicate = NSPredicate(format: "fbId = %@", fbId)
        fetchRequest.predicate = findByIdPredicate

        var fetchedResult:[User]
        var user:User? = nil
        do {
            try fetchedResult = minionManagedObjectContextWorker.executeFetchRequest(fetchRequest) as! [User]
            
            if(fetchedResult.count == 1){
                user = fetchedResult[0] as User
            }
        } catch let fetchError as NSError {
            print("getCredentials error: \(fetchError.localizedDescription)")
            return nil
        }
        
        return user
    }
    
    // MARK: Update
    
    func updateCredentials(fbId:String, details: Dictionary<String,AnyObject>) {
        let user:User? = self.getCredentials(fbId)
        
        if user != nil {
            for (key,value )in details{
                for item in UserAttributes.getAll{
                    if key != UserAttributes.fbId.rawValue {
                        if key == item {
                            print("update:\(user!.valueForKey(key)) to: \(value)")
                            user!.setValue(value, forKey:key)
                        }
                    }
                }
            }
        }
        
        persistenceManager.mergeWithMainContext()
    }
    
    
    // MARK: Delete
    
    func deleteCredentials(fbId: String){
        let user:User? = self.getCredentials(fbId)
        if user != nil {
            mainContextInstance.delete(user)
        }
        
        persistenceManager.mergeWithMainContext()
    }
}