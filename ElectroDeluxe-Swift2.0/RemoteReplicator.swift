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
        
        //TOKEN PASSED AS ENVIRONMENT VAR 
        //set via Edit Scheme -> Environment variables, add Key=FLOW_API_TOKEN Value=token_value
        let env = NSProcessInfo.processInfo().environment
        self.token = env["FLOW_API_TOKEN"]
        
        self.persistenceManager = PersistenceManager()
    }
    
    func pull(endpoint:APIEndpoint){
        
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
                doRequest(createRequestURL(flowAPI.artistsEndpoint.getPath()), entityType: EntityType.Artist)
                break
            case .Tracks:
                doRequest(createRequestURL(flowAPI.tracksEndpoint.getPath()), entityType: EntityType.Track)
                break
            case .Albums:
                doRequest(createRequestURL(flowAPI.albumsEndpoint.getPath()), entityType: EntityType.Album)
                break
            case .Events:
                doRequest(createRequestURL(flowAPI.eventsEndpoint.getPath()), entityType: EntityType.Event)
                break
            case .Videos:
                doRequest(createRequestURL(flowAPI.videosEndpoint.getPath()), entityType: EntityType.Video)
                break
            case .Genres:
                doRequest(createRequestURL(flowAPI.genresEndpoint.getPath()), entityType: EntityType.Genre)
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
}