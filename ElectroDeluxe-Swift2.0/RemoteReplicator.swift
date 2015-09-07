//
//  RemoteReplicator.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 04/09/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class RemoteReplicator: ReplicatorProtocol {

    private var httpClient:HTTPClient!
    private var flowAPI:FlowAPI!
    private var token:String!
    private var persistenceManager:PersistenceManager!
    private var isTokenPresent:Bool!
    
    //Utilize Singleton pattern by instanciating Replicator only once.
    class var sharedInstance: RemoteReplicator {
        struct Singleton {
            static let instance = RemoteReplicator()
        }
        
        return Singleton.instance
    }
    
    init() {
        self.httpClient = HTTPClient()
        self.flowAPI = FlowAPI.sharedInstance
        self.persistenceManager = PersistenceManager()
        isTokenPresent = self.checkIfTokenIsPresent()
    }
    
    func pull(endpoint:APIEndpoint){
        
        guard let _ = isTokenPresent else {
            return
        }
        
        switch endpoint {
            case .News:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.fields.rawValue:[
                        NewsAttributes.title.rawValue,
                        NewsAttributes.date.rawValue,
                        NewsAttributes.message.rawValue
                    ],
                    APIParameters.limit.rawValue:flowAPI.defaultResultLimit,
                    APIParameters.sort.rawValue:NewsAttributes.date.rawValue,
                    APIParameters.order.rawValue:APIParameters.asc.rawValue,
                    APIParameters.token.rawValue:token
                ]
                doRequest(createRequestURL(flowAPI.newsEndpoint.getPath(),params: params), entityType: EntityType.News)
                break
            case .Artists:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                   APIParameters.token.rawValue:token
                ]

                doRequest(createRequestURL(flowAPI.artistsEndpoint.getPath(),params: params), entityType: EntityType.Artist)
                break
            case .Tracks:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.token.rawValue:token
                ]

                doRequest(createRequestURL(flowAPI.tracksEndpoint.getPath(),params: params), entityType: EntityType.Track)
                break
            case .Albums:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.token.rawValue:token
                ]
                doRequest(createRequestURL(flowAPI.albumsEndpoint.getPath(),params: params), entityType: EntityType.Album)
                break
            case .Events:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.token.rawValue:token
                ]
                doRequest(createRequestURL(flowAPI.eventsEndpoint.getPath(),params: params), entityType: EntityType.Event)
                break
            case .Videos:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.token.rawValue:token
                ]
                doRequest(createRequestURL(flowAPI.videosEndpoint.getPath(),params: params), entityType: EntityType.Video)
                break
            case .Genres:
                //set query parameters:
                //fields=title,date,message&limit=4000&sort=date&order=asc&token=foobar
                let params:Dictionary<String,AnyObject> = [
                    APIParameters.token.rawValue:token
                ]
                doRequest(createRequestURL(flowAPI.genresEndpoint.getPath(),params: params), entityType: EntityType.Genre)
                break
        }
    }
        
    private func createRequestURL(endpoint: String, params: Dictionary<String,AnyObject>? = nil) -> NSMutableURLRequest {
        var request: NSMutableURLRequest!

        guard let parameters = params where parameters.count > 0 else {
            request = NSMutableURLRequest(URL: NSURL(string: String(format: "%@%@%@", flowAPI.defaultBasePath, endpoint, token))!)
            
            return request
        }
        
        let url:String = flowAPI.defaultBasePath + endpoint + httpClient.queryBuilder(params!)
        print("requestURL: \(url)")

        request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        return request
    }

    private func doRequest(request: NSMutableURLRequest, entityType:EntityType) {
        httpClient.doGet(request) { (data, error, httpStatusCode) -> Void in
            
            if httpStatusCode!.rawValue != HTTPStatusCode.OK.rawValue {
                print("\(httpStatusCode!.rawValue) \(httpStatusCode)")
                if data == nil {
                    print("data is nil")
                }
            }
             else {
                self.processData(self.parseResponse(data!), entity: entityType)
            }
        }
    }
    
    private func parseResponse(jsonData: NSData) -> Array<AnyObject> {
        var jsonResult:AnyObject!

        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
        } catch let fetchError as NSError {
            print("pull error: \(fetchError.localizedDescription)")
            return [String]()
        }
    
        return jsonResult[APIParameters.result.rawValue] as! Array<AnyObject>
    }
    
    func processData(response:Array<AnyObject>, entity:EntityType){
        switch entity {
            case .News:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Artist:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Track:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Album:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Event:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Video:
                persistenceManager.saveItems(response, entity: entity)
                break
            case .Genre:
                persistenceManager.saveItems(response, entity: entity)
                break
        }
    }
    
    private func checkIfTokenIsPresent() -> Bool {
        let appDelegate : AppDelegate = AppDelegate().sharedInstance()

        do{
            try self.token = appDelegate.getAPIToken()
        } catch AuthError.TokenIsMissing {
            print("token needs to be set: set via Edit Scheme -> Environment variables, add Key=FLOW_API_TOKEN Value=token_value\nA valid token can be requested via: https://flow-api.herokuapp.com/token-request")
            return false
        } catch{
            print("Could not read token, check if Environment var is set properly")
            return false
        }
        
        return true
    }
}