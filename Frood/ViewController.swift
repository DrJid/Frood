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
    }
    
    override func viewDidAppear(animated: Bool)  {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "Event Data"// object.description
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    // Location Manager Delegates Callbacks
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)  {
        println("Locations:  \(locations)" )
        println("locations called")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)  {
        println("Error: \(error)")
    }
}

