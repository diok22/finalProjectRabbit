//
//  Events.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 07/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import Foundation

struct Event {
    let name: String
    let time: String
    let location: String
    
    init(name:String, time:String, location:String){
        self.name = name
        self.time = time
        self.location = location
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "time": time,
            "location": location
        ]
    }
    
}
