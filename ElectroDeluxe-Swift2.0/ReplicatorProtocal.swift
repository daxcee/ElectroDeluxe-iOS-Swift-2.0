//
//  ReplicatorProtocol.swift
//  CoreDataCRUD
//  Written by Steven R.
//

import Foundation

protocol ReplicatorProtocol {
    
    // protocol definition goes here
    
    func pull(endpoint:APIEndpoint)
    
    func processData(response: Array<AnyObject>, entity:EntityType)
}