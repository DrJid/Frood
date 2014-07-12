//
//  ViewController.swift
//  Frood
//
//  Created by Maijid Moujaled on 7/12/14.
//  Copyright (c) 2014 Maijid Moujaled. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
                            
    @IBOutlet var theTableView: UITableView
    
    var userCoordinate:CLLocationCoordinate2D?

    let apiKey = "Frood.xcodeproj/project.xcworkspace/contents.xcworkspacedata"

    
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
    
    override func viewDidAppear(animated: Bool)  {
        
    }

    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as EventCell
       
        
        cell.typeLabel.text = "haha"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
   

