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
import MapKit
import CoreLocation

class MapInContainer: UIViewController, CLLocationManagerDelegate {
    
    var myUserInfo : [String:Any] = [:]

    
    let ref = FIRDatabase.database().reference(withPath: "users")

    let locationM = CLLocationManager()

    
//    var users : [[String:Any]] =
//        [
//            ["name": "Ed", "latitude": 48.55, "longitude": 2.373259, "eta":""],
//            ["name": "Dio", "latitude": 48.50, "longitude": 2.310, "eta":""],
//            ["name": "Manu", "latitude": 48.51, "longitude": 2.471, "eta":""]
//    ]

    
    override func viewDidLoad() {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[0]
            print(location)
            let myName = "Ed"
            myUserInfo["name"] = myName
            myUserInfo["latitude"] = (location.coordinate.latitude)
            myUserInfo["longitude"] = (location.coordinate.longitude)
        }
        
        
        print("---")
        print(myUserInfo)

        
        locationM.delegate = self
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.requestWhenInUseAuthorization()
        locationM.startUpdatingLocation()
        
        
        
        
//        ref.observe(.value, with:{ snapshot in
//            print(snapshot)
//            
//            let enumerator = snapshot.children
//            while let user = enumerator.nextObject() as? FIRDataSnapshot {
//                let userValue = user.value as! [String:AnyObject]
//                print(userValue["latitude"]!)
//            }
//            
//        })
        
        
       // for i in 0 ..< users.count {

//        let urlAPI = "https://maps.googleapis.com/maps/api/directions/json?"
//        let urlKey = "key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo"
//        let latString = String(describing: self.myUserInfo["latitude"]!)
//        let lonString = String(describing: self.myUserInfo["longitude"]!)
//        let urlLocation = "origin=" + latString + "," + lonString + "&"
//        let url = urlAPI + urlLocation + "mode=transit&destination=51.5014,-0.1419&" + urlKey
//        print("URL = " + url)
//
//        Alamofire.request(url).responseJSON
//            { response in
//                //print(response)
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    print((json["routes"][0].stringValue))
//                    let eta = json["routes"][0]["legs"][0]["duration"]["text"]
//                    self.myUserInfo["eta"] = eta.stringValue
//                    
//                    let camera = GMSCameraPosition.camera(withLatitude: 48.5, longitude: 2.3411, zoom: 9.0)
//                    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//                    mapView.isMyLocationEnabled = true
//                    self.view = mapView
//                
//              //   for i in 0 ..< self.users.count {
//                    let marker = GMSMarker()
//                    marker.position = CLLocationCoordinate2D(latitude: self.myUserInfo["latitude"] as! CLLocationDegrees, longitude: self.myUserInfo["longitude"] as! CLLocationDegrees)
//                    marker.title = self.myUserInfo["name"] as! String?
//                    marker.snippet = self.myUserInfo["eta"] as! String?
//                    marker.map = mapView
//                    // }
//                    
//                    let markerEvent = GMSMarker()
//                    markerEvent.position = CLLocationCoordinate2D(latitude: 51.5014, longitude: -0.1419)
//                    markerEvent.title = "Buckingham Palace"
//                    markerEvent.snippet = "tour"
//                    markerEvent.icon = GMSMarker.markerImage(with: .blue)
//                    markerEvent.map = mapView
//                    
//                case .failure(let error):
//                    print(error)
//                }
//        
//            }
//       // }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
