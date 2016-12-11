//
//  Events.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 07/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftyJSON
import FirebaseAuth


struct Event {
    let addedByUser: String
    let name: String
    let time: NSNumber!
    let address: String!
    let latitude: String!
    let longitude: String!
    let invitees: [[String:Any]]
    let ref: FIRDatabaseReference?
    
    init(addedByUser: String, name:String, time:NSNumber, address:String, latitude:String, longitude:String, invitees:[[String:Any]]){
        self.addedByUser = addedByUser
        self.name = name
        self.time = time
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.invitees = invitees
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        addedByUser = snapshotValue["addedByUser"] as! String
        name = snapshotValue["name"] as! String
        time = snapshotValue["time"] as! NSNumber
        address = snapshotValue["address"] as! String
        latitude = snapshotValue["latitude"] as! String
        longitude = snapshotValue["longitude"] as! String
        invitees = snapshotValue["invitees"] as! [[String:Any]]
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "addedByUser": addedByUser,
            "name": name,
            "time": time,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "invitees": invitees
        ]
    }
}
