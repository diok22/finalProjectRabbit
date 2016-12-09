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


struct Event {
    let name: String
    let time: String
    let address: String!
    let latitude: String!
    let longitude: String!
    let ref: FIRDatabaseReference?
    
    init(name:String, time:String, address:String, latitude:String, longitude:String){
        self.name = name
        self.time = time
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        print(snapshotValue)
        name = snapshotValue["name"] as! String
        time = snapshotValue["time"] as! String
        address = snapshotValue["address"] as! String
        latitude = snapshotValue["latitude"] as! String
        longitude = snapshotValue["longitude"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "time": time,
            "address": address,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}
