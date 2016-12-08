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


struct Event {
    let name: String
    let time: String
    let location: String
    let ref: FIRDatabaseReference?
    
    init(name:String, time:String, location:String){
        self.name = name
        self.time = time
        self.location = location
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        time = snapshotValue["time"] as! String
        location = snapshotValue["location"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "time": time,
            "location": location
        ]
    }
}
