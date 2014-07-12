//
//  APIClient.swift
//  Frood
//
//  Created by Francisco Magdaleno on 7/12/14.
//  Copyright (c) 2014 Maijid Moujaled. All rights reserved.
//

import Foundation
import UIKit

class APIClient:NSObject {
    class var sharedInstance:
        APIClient {
    struct Singleton {
        
        static let instance = APIClient(baseURL: "https://api.meetup.com")
        }
        return Singleton.instance
    }
    
    let baseURL: String
    let session: NSURLSession
    
    let successBlock = {()}
    
    init(baseURL:String) {
        self.baseURL = baseURL
        
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let configOptions = ["Accept":"application/json"]

        self.session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }
    
    
    func dataTask(url:NSString) -> (task:NSURLSessionDataTask) {

        var finalURL = NSURL.URLWithString(url, relativeToURL: NSURL.URLWithString(baseURL))
        var request: NSURLRequest = NSURLRequest(URL:finalURL)
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if let json: AnyObject = self.parseDateToJSON(data) {
                println("response: \(json) response: \(response) error:\(error)")
            }
            else {
                println("response: \(response) error\(error)")
                
            }
            
            });

        
        task.resume()
        return task

    }
    
    func parseDateToJSON(data: NSData) -> AnyObject? {
        var json: AnyObject?
        var jsonError: NSError?
        json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError)
        if jsonError {
            println("error parsing data \(jsonError)")
        }
        else {
            return  json
        }
        return nil
    }


}

let APICLientSingleton = APIClient(baseURL: "https://api.meetup.com")