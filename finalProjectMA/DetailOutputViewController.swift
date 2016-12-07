//
//  DetailOutputViewController.swift
//  finalProjectMA
//
//  Created by Akram Rasikh on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit

class DetailOutputViewController: UIViewController {

    @IBAction func homeButton(_ sender: Any) {
         performSegue(withIdentifier: "showHomeView", sender: self)
    }
    
    @IBOutlet weak var title_event: UITextView!
    
    @IBOutlet weak var time: UITextView!
    
    @IBOutlet weak var invitees: UITextView!
    
    var passedEventTitle: String!
    var passedEventTime: String!
    var passedInvitees: String!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title_event.text = passedEventTitle
        time.text = passedEventTime
        invitees.text = passedInvitees
        

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
