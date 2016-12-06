//
//  DataViewController.swift
//  finalProjectMA
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    let users : [[String:Any]] =
    [
        ["name": "Ed", "latitude": 55.50, "longitude": -0.073259],
        ["name": "Dio", "latitude": 51.50, "longitude": -0.070],
        ["name": "Manu", "latitude": 51.51, "longitude": -0.071]
    ]
    
    
        
    override func viewDidLoad() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 52.86, longitude: 0.0, zoom: 6.0)
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
    
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

}

