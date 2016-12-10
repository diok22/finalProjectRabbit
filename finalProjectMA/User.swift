//
//  User.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 10/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
