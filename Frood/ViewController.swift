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

    let apiKey = "761f445110406175175e2272ad16"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create an array of tuples.
        var cord1 = CLLocationCoordinate2D(latitude: 37.7749300, longitude: -122.4194200)
        var cord2 = CLLocationCoordinate2D(latitude: 32, longitude: -100)
        var cord3 = CLLocationCoordinate2D(latitude: 39, longitude: -124)
        
        var locations = [CLLocationCoordinate2D]()
        locations += cord1
        locations += cord2
        locations += cord3
        
        //Pick the random location: 
        userCoordinate = locations[0]
        
        println(userCoordinate!)

//        let parameters = ["lat": userCoordinate!.latitude.description, "long": userCoordinate!.longitude.description]
        //make the call and the reponse contains the callback json
        APICLientSingleton.dataTask("/2/open_events.json?topic=photo&time=,1w&key=\(apiKey)", parameters: nil) { response in
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
        cell.eventTitleTime.text = "9am to 9pm"
        cell.eventAddressLabel.text = "34 Howard"
        cell.eventTitleLabel.text = "Swift Hackday"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
   

