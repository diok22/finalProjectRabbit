//
//  DataViewController.swift
//  finalProjectMA
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps
import FBSDKLoginKit

class DataViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    @IBAction func EventsonMap(_ sender: UIButton) {
                performSegue(withIdentifier: "showEventsOnMap", sender: self)
    }
    
    @IBAction func createEventForm(_ sender: UIButton) {
        performSegue(withIdentifier: "CreateNewEvent", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
    }
    

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
            if error != nil {
                print(error)
                return
            }
            print("Successfully logged in with facebook...")
        }
}

