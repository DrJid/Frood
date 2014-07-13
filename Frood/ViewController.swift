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
    
    var allEvents = [Event]()
    
    
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
        
        let lat = "37.784296"
        let lon = "-122.414941"
        let distance = "5"
        //make the call and the reponse contains the callback json
        APICLientSingleton.dataTask("/2/open_events.json?lat=\(lat)&lon=\(lon)&distance=\(distance)&key=\(apiKey)", parameters: nil) { response in
            //response call
            if let response:AnyObject = response  {
//                println("repsonse \(response)")
                
                var eventsArray:NSArray! = response["results"] as NSArray
                self.allEvents.removeAll(keepCapacity: false)
                
                
                for i in 0..<eventsArray.count {
                    let event: NSDictionary! = eventsArray[i] as Dictionary<String,String>
                    
                    
                    var name = event["name"] as String
                    let  eventLocation = event["how_to_find_us"] as? String
                    var e = Event(name: name, location: eventLocation, time: NSDate.date() )
                    self.allEvents += e
                    self.theTableView.reloadData()

                    
                }
                
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)  {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as EventCell
        
        var event = self.allEvents[indexPath.row]
        cell.eventTitleLabel.text = event.eventName
        if let eventLocationString = event.eventLocation {
            cell.eventAddressLabel.text = event.eventLocation!
        }
        else {
            cell.eventAddressLabel.text = "no address"
        }

        cell.typeLabel.text  = "Type"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allEvents.count

    }
    
}



class Event {
    var eventName: String?
    var eventLocation:String?
    var eventTime = NSDate.date()

    
    init(name:String, location:String?, time:NSDate?) {
        eventName = name
        eventLocation = location
        eventTime = time
    }
}


