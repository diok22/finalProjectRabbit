//
//  MapInContainer.swift
//  finalProjectMA
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import FirebaseDatabase
import FirebaseAuth

class MapInContainer: UIViewController, CLLocationManagerDelegate  {
    
    var passedSelectedEventKey: String = ""
    var currentEvent:Event!
    var inviteesArray : [[String:Any]] = []
    let ref = FIRDatabase.database().reference(withPath: "users")
    var meetingTime:String = ""
    var fullAddress:String = ""
    var lat:Double = 0
    var lng:Double = 0
    var latString:String = "0"
    var lonString:String = "0"
    var currentUserIndex:Int!
    
    let currentUser = FIRAuth.auth()?.currentUser
    
    
    var userFromFirebase : [String:Any] = [:]
    

    override func viewDidLoad() {
        
        // after eta request
        let currentEventRef = FIRDatabase.database().reference(withPath: "events").child(self.passedSelectedEventKey)
        currentEventRef.observe(.value, with: {snapshot in
            let theEvent = snapshot
            let eventInstance = Event(snapshot: theEvent )
            self.currentEvent = eventInstance
            self.title = self.currentEvent.name // changes the title of page to viewing event
            self.inviteesArray = self.currentEvent.invitees
            
            for i in 0..<self.inviteesArray.count {
                if self.currentUser?.email == self.inviteesArray[i]["email"] as! String {
                    print(["confirmed" : "true", "lat" : self.latString, "lng" : self.lonString])
                    print("THE BATTLE")
                    print(["confirmed" : "true", "lat" : Double(self.latString), "lng" : Double(self.lonString)])
                    print("Hans Zimmer")
                    currentEventRef.child("invitees").child(String(i)).updateChildValues(["confirmed" : "true", "lat" : Double(self.latString), "lng" : Double(self.lonString)])
                    self.currentUserIndex = i
                }
            }
            
            let meetingTimeInterval = self.currentEvent.time as Double
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            let meetingTimeDateObject = Date(timeIntervalSince1970: meetingTimeInterval)
            self.meetingTime = formatter.string(from: meetingTimeDateObject)
            
            self.fullAddress = self.currentEvent.address
            self.lat = NSString(string: self.currentEvent.latitude).doubleValue
            self.lng = NSString(string: self.currentEvent.longitude).doubleValue

            
            
        }) // ref to events


       
// create url for eta of current logged in user
        ref.child((currentUser?.uid)!).child("userData").observe(.value, with: { (userSnapshot) in
            let currentUserData = userSnapshot.value as! [String:AnyObject]
            let urlAPI = "https://maps.googleapis.com/maps/api/directions/json?"
            let urlKey = "key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJoX"  // X to break key
            self.latString = String(describing: currentUserData["latitude"]!)
            self.lonString = String(describing: currentUserData["longitude"]!)
            let eventLatString = self.currentEvent.latitude
            let eventLonString = self.currentEvent.longitude
            let urlLocation = "origin=" + self.latString + "," + self.lonString + "&"
            let urlDestination = "destination=" + eventLatString! + "," + eventLonString! + "&"
            let urlTransit = "mode=transit&"
            let url = urlAPI + urlLocation + urlTransit + urlDestination + urlKey
            
            

            
            Alamofire.request(url).responseJSON  //eta request
                { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let eta = json["routes"][0]["legs"][0]["duration"]["text"]
                        print("hhhhahahahahaahha")
                        print(eta)
                        let etaString = String(describing: eta)
                        
                        
                        
                        print("RUNNING FASTER THAN BOLT")
                        currentEventRef.child("invitees").child(String(self.currentUserIndex)).updateChildValues(["confirmed" : "true", "lat" : Double(self.latString), "lng" : Double(self.lonString), "eta" : etaString])
                        
                        
                            let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.lng, zoom: 10.0)
                            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                            mapView.isMyLocationEnabled = true
                            self.view = mapView
                            
                            // event marker
                        
                            let markerEvent = GMSMarker()
                            markerEvent.position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
                            markerEvent.title = self.fullAddress
                            markerEvent.snippet = self.meetingTime
                            markerEvent.icon = GMSMarker.markerImage(with: .blue)
                            mapView.isMyLocationEnabled = true
                            markerEvent.map = mapView
                            
                        
                        
                        
                            // markers for users
                            currentEventRef.observe(.value, with: {snapshot in
                                
                                let theEvent = snapshot
                                let eventInstance = Event(snapshot: theEvent )
                                self.currentEvent = eventInstance
                                self.title = self.currentEvent.name // changes the title of page to viewing event
                                self.inviteesArray = self.currentEvent.invitees
                                
                                for i in 0 ..< self.inviteesArray.count {
                                let marker = GMSMarker()
                                marker.position = CLLocationCoordinate2D(latitude: self.inviteesArray[i]["lat"] as! CLLocationDegrees, longitude: self.inviteesArray[i]["lng"] as! CLLocationDegrees)
                                marker.title = self.inviteesArray[i]["email"] as! String?
                                marker.snippet = self.inviteesArray[i]["eta"] as! String?
                                marker.map = mapView
                                }
                                
                            })
                            

                        
                    case .failure(let error):
                        print(error)
                    }
            } // alamofire request
            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        })
    } // viewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
