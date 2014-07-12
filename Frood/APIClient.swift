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
    
    //creatin a singleton. it is called at the bottom of the file
    class var sharedInstance:
        APIClient {
    struct Singleton {
        //Start the client with the base url
        static let instance = APIClient(baseURL: "https://api.meetup.com")
        }
        return Singleton.instance
    }

    let baseURL: String
    let session: NSURLSession
    
    init(baseURL:String) {
        self.baseURL = baseURL
        //creaget the sesscion configuration and set it to receive json as response
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let configOptions = ["Accept":"application/json"]
        self.session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }
    
    
    //generic call to get a parsed response
    //it has no error handling yet
    func dataTask(url:NSString, parameters: Dictionary<String,String>?, callback: (AnyObject?) -> ()) -> (task:NSURLSessionDataTask) {
        
        var finalURL = NSURL.URLWithString(url, relativeToURL: NSURL.URLWithString(baseURL))
        var request: NSMutableURLRequest = NSMutableURLRequest(URL:finalURL)
        if parameters {
            if let parsedParams = self.parseJSONToData(parameters) {
                request.HTTPBody = parsedParams
            }
        }
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if let json: AnyObject = self.parseDataToJSON(data) {
                println("result: \(json) response: \(response) error:\(error)")
                callback(json) // = AnyObject?
            }
            else {
                println("response: \(response) error\(error)")
                callback(nil)
            }
        });

        
        task.resume()
        return task

    }
    
    func parseDataToJSON(data: NSData) -> AnyObject? {
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

    func parseJSONToData(json: AnyObject?) -> NSData? {

        var data: NSData
        var jsonError: NSError?
        data = NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(), error: &jsonError)
        
        if jsonError {
            println("error parsing data \(jsonError)")
        }
        else {
            return  data
        }
        return nil
    }

}

let APICLientSingleton = APIClient(baseURL: "https://api.meetup.com")