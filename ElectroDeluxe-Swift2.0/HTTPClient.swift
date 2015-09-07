//
//  HTTPClient.swift
//  ElectroDeluxe-Swift2.0
//
//  Created by c0d3r on 21/08/15.
//  Copyright © 2015 srmds. All rights reserved.
//

import Foundation

class HTTPClient {

    private var urlSession:NSURLSession!
    private var sessionConfiguration:NSURLSessionConfiguration!
    
    init(){
        sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfiguration)
    }
    
    func setAdditionalHeaders(headers: Dictionary<String, String>){
        sessionConfiguration.HTTPAdditionalHeaders = headers
    }
    
    func queryBuilder(params: Dictionary<String,AnyObject>) -> String {
        
        var queryString:String = ""
        var counter = 0
        
        for (key, value) in params {
            
            if counter != 0 {
                if params.count > 1{
                    queryString.append("&")
                }
            } else {
                queryString.append("?")
            }
            
            if key == APIParameters.fields.rawValue {
                
                queryString.append("\(key)=")
                
                let fields = value as! NSArray
                
                for index in 0..<fields.count {
                    
                    if index > 0 && index != fields.count {
                        queryString.append(",")
                    }
                    
                    queryString.append(fields[index] as! String)
                    
                }
                
            } else {
                queryString.append("\(key)=\(value)")
            }
            
            ++counter
        }
        
        return queryString
    }

    
    func doGet(request: NSURLRequest!, callback:(data: NSData?, error: NSError?, httpStatusCode: HTTPStatusCode?) -> Void) {
        print("headers: \(sessionConfiguration.HTTPAdditionalHeaders)")
        let task = urlSession.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if let responseError = error {
                callback(data: nil, error: responseError,httpStatusCode: nil)
            }
            else if let httpResponse = response as? NSHTTPURLResponse {
                
                let httpStatus = self.getHTTPStatusCode(httpResponse)
                print("HTTP Status Code: \(httpStatus.rawValue) \(httpStatus)")
                
                if httpStatus.rawValue != 200 {
                    let statusError = NSError(domain:"com.electro-deluxe", code:httpStatus.rawValue, userInfo:[NSLocalizedDescriptionKey : "HTTP status code: \(httpStatus.rawValue) - \(httpStatus)"])
                    callback(data: nil, error: statusError, httpStatusCode: httpStatus)
                } else {
                    callback(data: data, error: nil, httpStatusCode: httpStatus)
                }

            }
        }
        
       
        task.resume()
    }
    
    func getHTTPStatusCode(httpURLResponse:NSHTTPURLResponse) -> HTTPStatusCode {
        var httpStatusCode:HTTPStatusCode!
        
        for status in HTTPStatusCode.getAll {
            if httpURLResponse.statusCode == status.rawValue {
                httpStatusCode = status
            }
        }
        
        return httpStatusCode
    }
    
}