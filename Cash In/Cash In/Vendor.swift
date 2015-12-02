//
//  Vendor.swift
//  Cash In
//
//  Created by David Fontenot on 12/1/15.
//  Copyright © 2015 MChackathon. All rights reserved.
//

import Foundation


class Vendor {
    let params = []
    //["api-key": "53eb9541b4374660d6f3c0001d6249ca:19:70900879"]
    let resourceUrl = "http://intense-lake-3556.herokuapp.com/api/vendor"
    
    func checkAFNetworking() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET(resourceUrl, parameters: params, success: { (operation, responseObject) -> Void in
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
