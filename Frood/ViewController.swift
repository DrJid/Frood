//
//  ViewController.swift
//  Frood
//
//  Created by Maijid Moujaled on 7/12/14.
//  Copyright (c) 2014 Maijid Moujaled. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiKey = "3a177152804be44404644338256f78"
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let lat = "37.784296"
        let lon = "-122.414941"
        let distance = "5"
        //make the call and the reponse contains the callback json
        APICLientSingleton.dataTask("/2/open_events.json?lat=\(lat)&lon=\(lon)&distance=\(distance)&key=\(apiKey)", parameters: nil) { response in
            //response call
            if let response:AnyObject = response  {
             println("repsonse \(response)")
            }
        }
    }
}

