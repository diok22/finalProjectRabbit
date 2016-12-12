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
import APScheduledLocationManager




class DataViewController: UIViewController, CLLocationManagerDelegate, APScheduledLocationManagerDelegate {

    
    let ref = FIRDatabase.database().reference(withPath: "users")
    let currentUser = FIRAuth.auth()?.currentUser
    private var manager: APScheduledLocationManager!

    @IBAction func ShowEventsListTable(_ sender: UIButton) {
    }
    
    @IBAction func createEventForm(_ sender: UIButton!) {
    }

    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
             print("\(self.currentUser?.email) is signing out")
            try firebaseAuth?.signOut()
           
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    override func viewDidLoad() {
       
       
        print("signed in as: \(self.currentUser?.email)")
        super.viewDidLoad()
        manager = APScheduledLocationManager(delegate: self)
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation(interval: 300, acceptableLocationAccuracy: 100)

    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didUpdateLocations locations: [CLLocation]) {
        let l = locations.first!
        
        self.ref.child((currentUser?.uid)!).setValue(["latitude": l.coordinate.latitude, "longitude":  l.coordinate.longitude, "email": currentUser?.email])
        
        
        
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didFailWithError error: Error) {
        
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

