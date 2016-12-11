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

class MapInContainer: UIViewController, CLLocationManagerDelegate  {
    
    var passedSelectedEventFromList: [Event] = []
    
    let ref = FIRDatabase.database().reference(withPath: "users")

    
    var userFromFirebase : [String:Any] = [:]
    
    override func viewDidLoad() {
        
        let meetingTime = self.passedSelectedEventFromList[0].time
        let fullAddress = self.passedSelectedEventFromList[0].address
        let lat = NSString(string: self.passedSelectedEventFromList[0].latitude).doubleValue
        let lng = NSString(string: self.passedSelectedEventFromList[0].longitude).doubleValue
        
        
        ref.child("Manuela").observeSingleEvent(of: .value, with: { (userSnapshot) in
            let currentUserValue = userSnapshot.value as! [String:AnyObject]
            let urlAPI = "https://maps.googleapis.com/maps/api/directions/json?"
            let urlKey = "key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo22"
            let latString = String(describing: currentUserValue["latitude"]!)
            let lonString = String(describing: currentUserValue["longitude"]!)
            let eventLatString = self.passedSelectedEventFromList[0].latitude
            let eventLonString = self.passedSelectedEventFromList[0].longitude
            let urlLocation = "origin=" + latString + "," + lonString + "&"
            let urlDestination = "destination=" + eventLatString! + "," + eventLonString! + "&"
            let urlTransit = "mode=transit&"
            let url = urlAPI + urlLocation + urlTransit + urlDestination + urlKey
            
            Alamofire.request(url).responseJSON
                { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let eta = json["routes"][0]["legs"][0]["duration"]["text"]
                        self.ref.child("Manuela").updateChildValues(["eta": String(describing: eta)])
                    case .failure(let error):
                        print(error)
                    }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        var usersArray : [[String:Any]] = []

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
          while let user = enumerator.nextObject() as? FIRDataSnapshot {
              var userValue = user.value as! [String:AnyObject]
                usersArray.append(userValue)
            
            }
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 9.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            mapView.isMyLocationEnabled = true
            self.view = mapView
            
            let markerEvent = GMSMarker()
            markerEvent.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            markerEvent.title = fullAddress
            markerEvent.snippet = meetingTime
            markerEvent.icon = GMSMarker.markerImage(with: .blue)
            mapView.isMyLocationEnabled = true
            markerEvent.map = mapView
            
            for i in 0 ..< usersArray.count {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: usersArray[0]["latitude"] as! CLLocationDegrees, longitude: usersArray[0]["longitude"] as! CLLocationDegrees)
                marker.title = usersArray[i]["name"] as! String?
                marker.snippet = usersArray[i]["eta"] as! String?
                marker.map = mapView
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
            

        
        
    } // viewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
