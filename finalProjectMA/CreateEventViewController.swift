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



class CreateEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let ref = FIRDatabase.database().reference(withPath: "events")
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "AIzaSyDEw43MvKypSnZOmxMiTzXs4nJ0ZsTjyJo"
    
    var eventLocation: String = ""
    var formattedAddress: String = ""
    var locationLatitude: String = ""
    var locationLongitude: String = ""
    var user: User!
    var invitees: [[String:Any]] = []

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
// MARK: Find the address + API
    
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
    
// MARK: Adding invitees to list
    
    @IBAction func addInvitees(_ sender: UIButton) {
        let alert = UIAlertController(title: "Invitees",
                                      message: "Add people to invite them to the event",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default) { action in
                                        let inviteeEmailField = alert.textFields![0]
                                        let inviteeNameField = alert.textFields![1]
                                        let newInvitee : [String:Any]
                                        newInvitee = ["name" : inviteeNameField.text ?? "Default Name", "email" : inviteeEmailField.text!, "confirmed" : false]
                                        self.invitees.append(newInvitee as! Dictionary<String, Any>)
                                        self.tableView.reloadData()
                                        
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Email"
        }
        
        alert.addTextField { textFirstName in
            textFirstName.placeholder = "First Name"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }

// MARK: Submit data and store in Firebase
    
    @IBAction func submitDetails(_ sender: Any) {
        
        let eventName = name.text
        let eventTime = time.text
        eventLocation = location.text!
       
        let eventInstance = Event(addedByUser: self.user.email, name: eventName!, time: eventTime!, address: self.formattedAddress, latitude: self.locationLatitude, longitude: self.locationLongitude, invitees: invitees)
        let eventInstanceRef = self.ref.child(eventName!)
        eventInstanceRef.setValue(eventInstance.toAnyObject())
        performSegue(withIdentifier: "submitNewEvent", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitNewEvent" {
            if let destination = segue.destination as? DetailOutputViewController {
                destination.passedEventTitle = name.text
                destination.passedEventTime = time.text
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading current user")
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            print("current users email: \(self.user.email)")
        }
        

    }
    
// MARK: Invitee TableView
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            invitees.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteeCell") as! InviteeTableViewCell
        cell.inviteeName.text = invitees[indexPath.row]["name"] as! String?
        cell.inviteeEmail.text = invitees[indexPath.row]["email"] as! String?
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitees.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
