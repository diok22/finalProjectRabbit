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

class MapInContainer: UIViewController {

    
    override func viewDidLoad() {
        
        
        let users : [[String:Any]] =
            [
                ["name": "Ed", "latitude": 51.55, "longitude": -0.073259],
                ["name": "Dio", "latitude": 51.50, "longitude": -0.070],
                ["name": "Manu", "latitude": 51.51, "longitude": -0.071]
        ]
        
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=51.51,-0.071&mode=transit&destination=51.5014,-0.1419&key=AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo").responseJSON
            { response in
                //print(response)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    let camera = GMSCameraPosition.camera(withLatitude: 51.5, longitude: -0.11, zoom: 11.0)
                    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                    mapView.isMyLocationEnabled = true
                    self.view = mapView
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: users[2]["latitude"] as! CLLocationDegrees, longitude: users[2]["longitude"] as! CLLocationDegrees)
                    marker.title = users[2]["name"] as! String?
                    marker.snippet = (json["routes"][0]["legs"][0]["duration"]["text"]).stringValue
                    marker.map = mapView
                    
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
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
