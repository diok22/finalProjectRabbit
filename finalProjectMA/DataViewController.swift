//
//  DataViewController.swift
//  finalProjectMA
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase
import FirebaseAuth


class DataViewController: UIViewController, CLLocationManagerDelegate {

    
    let ref = FIRDatabase.database().reference(withPath: "users")
    
    let locationM = CLLocationManager()
    
    var userLocationGPS : [String:Double] = [:]
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.ref.child("Manuela").setValue(["latitude": location.coordinate.latitude, "longitude":  location.coordinate.longitude, "name": "Manuela"])
        locationM.stopUpdatingLocation()
    }

    @IBAction func ShowEventsListTable(_ sender: UIButton) {
    }
    
    @IBAction func createEventForm(_ sender: UIButton!) {
    }

    override func viewDidLoad() {
        let user = FIRAuth.auth()?.currentUser
        print(user?.email)
        super.viewDidLoad()
        locationM.delegate = self
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.requestWhenInUseAuthorization()
        locationM.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

