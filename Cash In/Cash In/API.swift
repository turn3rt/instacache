//
//  Vendor.swift
//  Cash In
//
//  Created by David Fontenot on 12/1/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//

import Foundation


let params = []
//["api-key": "53eb9541b4374660d6f3c0001d6249ca:19:70900879"]
let resourceUrl = "http://intense-lake-3556.herokuapp.com/api/"
let manager = AFHTTPRequestOperationManager()

class LocalAPI {
    let params = []
    //["api-key": "53eb9541b4374660d6f3c0001d6249ca:19:70900879"]
    let resourceUrl = "http://intense-lake-3556.herokuapp.com/api/"
    let manager = AFHTTPRequestOperationManager()
    
    var customerObject: AnyObject?
    var vendorObject: AnyObject?
    var transactionObject: AnyObject?
    var presetObject: AnyObject?
    
    func updateAllObjects() {
        updateCustomer()
        updateVendor()
        updateTransaction()
        updatePreset()
    }

    func updateCustomer() {
        let fullUrl = resourceUrl + "customer"
        manager.GET(fullUrl, parameters: params, success: { (operation, responseObject) -> Void in
            self.customerObject = responseObject
            print(responseObject)}, failure: nil)
    }
    
    func updateVendor() {
        let fullUrl = resourceUrl + "vendor"
        manager.GET(fullUrl, parameters: params, success: { (operation, responseObject) -> Void in
            self.vendorObject = responseObject
            print(responseObject)}, failure: nil)
    }
    
    //this one is most important to poll
    func updateTransaction() {
        let fullUrl = resourceUrl + "transaction"
        manager.GET(fullUrl, parameters: params, success: { (operation, responseObject) -> Void in
            self.transactionObject = responseObject
            print(responseObject)}, failure: nil)
    }
    
    func updatePreset() {
        let fullUrl = resourceUrl + "preset"
        manager.GET(fullUrl, parameters: params, success: { (operation, responseObject) -> Void in
            self.presetObject = responseObject
            print(responseObject)}, failure: nil)
    }

    
    func checkAFNetworking() {
        manager.GET(resourceUrl, parameters: params, success: { (operation, responseObject) -> Void in
            self.vendorObject = responseObject
            print(responseObject)}, failure: nil)
        
        
        //        manager.GET(resourceUrl, parameters: params, success: { (operation, responseObject) -> Void in
        //            if let results = responseObject["results"] as? NSArray {
        //                print(results)
        //            }, failure: {(operation, requestError) -> Void in
        //                if let errorCallback = error? {
        //                    errorCallback(requestError)
        //                }
        //            }
    }
}

class Customer {
    
}

class Transaction {
    
}

class Preset {
    
}