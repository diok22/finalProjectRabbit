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

class MapInContainer: UIViewController {
    
    
    let ref = FIRDatabase.database().reference(withPath: "users")
    
    
    var users : [[String:Any]] =
        [
            ["name": "Ed", "latitude": 51.55, "longitude": -0.173, "eta":""],
            ["name": "Dio", "latitude": 51.50, "longitude": -0.070, "eta":""],
            ["name": "Manu", "latitude": 51.51, "longitude": -0.071, "eta":""]
    ]
    
    
    override func viewDidLoad() {
        
        var myUserInfo : [String:Any] = [:]
        
        ref.observe(.value, with:{ snapshot in
            print(snapshot)
            
            let enumerator = snapshot.children
            while let user = enumerator.nextObject() as? FIRDataSnapshot {
                var userValue = user.value as! [String:AnyObject]
                let userLatString = (userValue["latitude"]!)
                let userLonString = (userValue["longitude"]!)
                let userLatDouble = userValue["latitude"] as! Double
                let userLonDouble = userValue["longitude"] as! Double
                print(userLatString)
                print(userLonString)
                print(userLatDouble)
                print(userLonDouble)
                
            }
            
        })
        
        
       //for i in 0 ..< users.count {
            
            let urlAPI = "https://maps.googleapis.com/maps/api/directions/json?"
            let urlKey = "key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo"
            let latString = String(describing: users[1]["latitude"]!)
            let lonString = String(describing: users[1]["longitude"]!)
            let urlLocation = "origin=" + latString + "," + lonString + "&"
            let url = urlAPI + urlLocation + "mode=transit&destination=51.5014,-0.1419&" + urlKey
            print("URL = " + url)
            
            Alamofire.request(url).responseJSON
                { response in
                    //print(response)
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print((json["routes"][0].stringValue))
                        let eta = json["routes"][0]["legs"][0]["duration"]["text"]
                        self.users[1]["eta"] = eta.stringValue
                        
                        let camera = GMSCameraPosition.camera(withLatitude: 51.5014, longitude: -0.1419, zoom: 9.0)
                        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                        mapView.isMyLocationEnabled = true
                        self.view = mapView
                        
                        //for i in 0 ..< self.users.count {
                            let marker = GMSMarker()
                            marker.position = CLLocationCoordinate2D(latitude: self.users[1]["latitude"] as! CLLocationDegrees, longitude: self.users[1]["longitude"] as! CLLocationDegrees)
                            marker.title = self.users[1]["name"] as! String?
                            marker.snippet = self.users[1]["eta"] as! String?
                            marker.map = mapView
                        //}
                        
                        let markerEvent = GMSMarker()
                        markerEvent.position = CLLocationCoordinate2D(latitude: 51.5014, longitude: -0.1419)
                        markerEvent.title = "Buckingham Palace"
                        markerEvent.snippet = "tour"
                        markerEvent.icon = GMSMarker.markerImage(with: .blue)
                        markerEvent.map = mapView
                        
                    case .failure(let error):
                        print(error)
                    }
                    
            }
        //}
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
