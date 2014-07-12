//
//  ViewController.swift
//  Frood
//
//  Created by Maijid Moujaled on 7/12/14.
//  Copyright (c) 2014 Maijid Moujaled. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiKey = "INSERT-API-KEY"
    override func viewDidLoad() {
        super.viewDidLoad()
        //make the call and the reponse contains the callback json
        APICLientSingleton.dataTask("/2/open_events.json?topic=photo&time=,1w&key=\(apiKey)", parameters: nil) { response in
            //response call
            if let response:AnyObject = response  {
             println("repsonse \(response)")
            }
        }
    }
}

