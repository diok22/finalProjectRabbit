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
import FirebaseInstanceID
import FirebaseMessaging

class MainViewController: UIViewController, CLLocationManagerDelegate, APScheduledLocationManagerDelegate {
    
    
    let refUsers = FIRDatabase.database().reference(withPath: "users")
    let refEvents = FIRDatabase.database().reference(withPath: "events")
    let currentUser = FIRAuth.auth()?.currentUser
    private var manager: APScheduledLocationManager!
    var myEvents: [Any] = []
    var myEventsCountLocal:NSNumber = 0
    
    
    @IBOutlet weak var myEventsCount: UILabel!
    
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
    
    var myEventsRefs:[String] = []
    
    override func viewDidLoad() {
        print("signed in as: \(self.currentUser?.email)")
        super.viewDidLoad()
        manager = APScheduledLocationManager(delegate: self)
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation(interval: 5, acceptableLocationAccuracy: 100)
        
        self.refEvents.observe(.value, with: { snapshot in
            let events = snapshot.children.allObjects as! [FIRDataSnapshot]
            let userId = self.currentUser?.uid
            let myEventInstanceRef = self.refUsers.child(userId!).child("myEvents")
            var myEventsRefsLocal:[String] = []

            
            for event in events {
                let myEventInstance = Event(snapshot: event )
                for i in 0..<myEventInstance.invitees.count{
                    let currentUserEmail = self.currentUser?.email
                    if ((myEventInstance.invitees[i]["email"] as! String).contains(currentUserEmail!)){
                        myEventsRefsLocal.append("events/\(event.key)/invitees/\(i)")
                        self.myEvents.append(myEventInstance.toAnyObject())
                        myEventInstanceRef.child(event.key).setValue(myEventInstance.toAnyObject())
//                        myEventInstanceRef.child("eventCount").setValue(self.myEvents.count)

                        break
                    }
                }
                
            }
            self.myEventsRefs = myEventsRefsLocal
            print(self.myEventsRefs)
               self.myEventsCountLocal = NSNumber(value: self.myEvents.count)
        self.myEventsCount.text = self.myEventsCountLocal.stringValue
        
       })
        
        
        
        
        
        
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didUpdateLocations locations: [CLLocation]) {
        let l = locations.first!
        self.refUsers.child((currentUser?.uid)!).child("userData").setValue(["latitude": l.coordinate.latitude, "longitude":  l.coordinate.longitude, "email": currentUser?.email])
        for i in 0..<self.myEventsRefs.count {
            var eventInviteesRef = FIRDatabase.database().reference(withPath: self.myEventsRefs[i])
            eventInviteesRef.observeSingleEvent(of: .value, with: {snapshot in
                let userStatus = snapshot.value as! [String:AnyObject]
                if userStatus["confirmed"]as! String == "true"  {
                    print("I'm changing the user coordinates")
                    eventInviteesRef.updateChildValues(["lat" : l.coordinate.latitude, "lng" : l.coordinate.longitude])
                }
            })
           
        }
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

