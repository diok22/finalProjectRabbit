//
//  CreateEventViewController.swift
//  finalProjectMA
//
//  Created by Laszlo Bogacsi on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventTitle: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var invitees: UITextField!
    
    @IBAction func submitDetails(_ sender: Any) {
        
//        let userInput = eventTitle.text
        performSegue(withIdentifier: "submitNewEvent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submitNewEvent" {
            
            if let destination = segue.destination as? DetailOutputViewController {
                
                destination.passedEventTitle = eventTitle.text
                destination.passedEventTime = time.text
                destination.passedInvitees = invitees.text
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
