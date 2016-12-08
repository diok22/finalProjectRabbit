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



class CreateEventViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference(withPath: "events") 

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var invitees: UITextField!
    var eventLocation: String = ""
    
    @IBAction func submitDetails(_ sender: Any) {
        
//        Store event form data in firebase
        let eventName = name.text!
        let eventTime = time?.text
        eventLocation = (location?.text)!
        
        
        
//        getGeoCodeLocation(address: "50 Commercial Street, London E1 6LT")
      
        
        let eventInstance = Event(name: eventName, time: eventTime!, location: eventLocation)
                                          
        let eventInstanceRef = self.ref.child(eventName)
        eventInstanceRef.setValue(eventInstance.toAnyObject())
        performSegue(withIdentifier: "submitNewEvent", sender: self)
        
    }
    
   
    

    
    func getGeoCodeLocation(address: String){
        
    }
    
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
//        let data = "50 Commercial Street, London E1 6LT"
//        
//        
//        let url = String("\(baseUrl)address=\(data)&key=\(apikey)")
//        let data = NSData(contentsOf: url! as URL)
//        let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//        if let result = json["results"] as? NSArray {
//            if let geometry = result[0].geometry as? NSDictionary {
//                if let location = geometry.location as? NSDictionary {
//                    let latitude = location["lat"] as! Float
//                    let longitude = location["lng"] as! Float
//                    print("\n\(latitude), \(longitude)")
//                }
//            }
//        }
//        

        
//        Alamofire.request(url!).responseJson
//            { response in
//            switch response.result {
//            case .success(let value):
//                
//            case .faliure(let error):
//                print(error)
//            }
//            
//        }
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
