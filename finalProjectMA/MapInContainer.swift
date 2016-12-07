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

class MapInContainer: UIViewController {
    
    let users : [[String:Any]] =
        [
            ["name": "Ed", "latitude": 51.55, "longitude": -0.073259],
            ["name": "Dio", "latitude": 51.50, "longitude": -0.070],
            ["name": "Manu", "latitude": 51.51, "longitude": -0.071]
    ]

    
    
    override func viewDidLoad() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 51.5, longitude: -0.01, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        for i in 0 ..< users.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: users[i]["latitude"] as! CLLocationDegrees, longitude: users[i]["longitude"] as! CLLocationDegrees)
            marker.title = users[i]["name"] as! String?
            marker.snippet = "User"
            marker.map = mapView
        }
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.5014, longitude: -0.1419)
        marker.title = "Buckingham Palace"
        marker.snippet = "tour"
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView
        
        Alamofire.request("http://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood4&key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo").responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
