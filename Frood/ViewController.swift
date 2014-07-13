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
//                println("repsonse \(response['results'])")
                
                var eventsArray:NSArray! = response["results"] as NSArray
                self.allEvents.removeAll(keepCapacity: false)
                
                
                for i in 0..<eventsArray.count {
                    let event: NSDictionary! = eventsArray[i] as NSDictionary
//                    let venue: NSDictionary! = event["venue"] as NSDictionary
//                    
//                    if var label = cell.labelTitle{
//                        label.text = "This is a title"
//                    }
                    
                   
                    
                    /*
                    if let statusesArray = jsonObject as? NSArray{
                        if let aStatus = statusesArray[0] as? NSDictionary{
                            if let user = aStatus["user"] as? NSDictionary{
                                if let userName = user["name"] as? NSDictionary{
                                    //Finally We Got The Name
                                    
                                }
                            }
                        }
                    }
                    */
                    
//                    let group: NSDictionary! = event["group"] as NSDictionary
                    
                    
                    
//                    var location = venue["address_1"] as String
                    var name = event["name"] as String
                    
//                    let time = event["time"] as time_t;
//                    let dateFormatter = NSDateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd h:mm a" // superset of OP's format
//                    println("Date: ", dateFormatter.stringFromDate(NSDate()))

                    var e = Event(name: name, location: "My house", time: NSDate.date() )
                    self.allEvents += e
                    self.theTableView.reloadData()

                    
                }
                
    
//                for e in eventsArray {
//                    let venue: NSDictionary! = e["venue"] as NSDictionary
//                    var address = venue["address_1"]
//                    var name = e["venue"] as String
//                    var event = Event(name: name, location: venue, time: NSDate.date() )
//                    self.allEvents += event
//                    self.theTableView.reloadData()
//                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)  {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as EventCell
        
        var event = self.allEvents[indexPath.row]
        cell.eventTitleLabel.text = event.eventName
        cell.eventAddressLabel.text = event.eventLocation
        cell.typeLabel.text  = event.eventType

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allEvents.count

    }
    
}



class Event {
    var eventName = "My Event"
    var eventLocation = "821 Folsom"
    var eventTime = NSDate.date()
    var eventType = "Lunch!"
    
    init(name:String, location:String, time:NSDate) {
        eventName = name
        eventLocation = location
        eventTime = time
    }
}


