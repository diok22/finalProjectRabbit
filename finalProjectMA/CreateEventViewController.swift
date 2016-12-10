//
//  CreateEventViewController.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON
import Alamofire
import FirebaseAuth



class CreateEventViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference(withPath: "events") 

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var invitees: UITextField!
    
    @IBAction func findAddress(_ sender: Any) {
        print("finding address")
        let address: String = location.text!
        let array = address.components(separatedBy: " ")
        let addressSearchString = (array.joined(separator: "+"))
        let url = URL(string:"\(baseUrl)address=\(addressSearchString)&key=\(apikey)")
        
        Alamofire.request(url!).responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["results"][0]
                    let geometry = result["geometry"]
                    let location = geometry["location"]
                    self.formattedAddress = result["formatted_address"].stringValue
                    self.locationLatitude = location["lat"].stringValue
                    self.locationLongitude = location["lng"].stringValue
                    print("address found: \(self.formattedAddress)")

                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    var eventLocation: String = ""
    var formattedAddress: String = ""
    var locationLatitude: String = ""
    var locationLongitude: String = ""
    var user: User!
    
    
    @IBAction func submitDetails(_ sender: Any) {
        
//        Store event form data in firebase
        let eventName = name.text
        let eventTime = time.text
        eventLocation = location.text!
        let invitees = ["test1@gmail.com", "test2@gmail.com", "test3@gmail.com"]
        let eventInstance = Event(addedByUser: self.user.email, name: eventName!, time: eventTime!, address: self.formattedAddress, latitude: self.locationLatitude, longitude: self.locationLongitude, invitees: invitees)
        
        let eventInstanceRef = self.ref.child(eventName!)
        eventInstanceRef.setValue(eventInstance.toAnyObject())
//        eventInstanceRef.child("Invitees").setValue(invitees)
        performSegue(withIdentifier: "submitNewEvent", sender: self)
        
    }
    
//    func getGeoCodeLocation(address: String){
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitNewEvent" {
            if let destination = segue.destination as? DetailOutputViewController {
                destination.passedEventTitle = name.text
                destination.passedEventTime = time.text
                destination.passedInvitees = invitees.text
            }
        }
    }
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading current user")
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            print("current users email: \(self.user.email)")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
