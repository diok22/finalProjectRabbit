//
//  MapViewController.swift
//  finalProjectMA
//
//  Created by Manuela Sabatino on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var passedSelectedEventKey: String = ""
    var inviteesArray : [[String:Any]] = []
    
    @IBOutlet weak var tableView: UITableView!
    var currentEvent:Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentEventRef = FIRDatabase.database().reference(withPath: "events").child(self.passedSelectedEventKey)
        currentEventRef.observe(.value, with: {snapshot in
            let theEvent = snapshot
                let eventInstance = Event(snapshot: theEvent )
                self.currentEvent = eventInstance
            self.title = self.currentEvent.name // changes the title of page to viewing event
            self.inviteesArray = self.currentEvent.invitees
            self.tableView.reloadData()

            })
    }
// MARK: TableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.inviteesArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "InviteeOnMapViewCell") as! InviteeMapViewTableViewCell
            cell.firstName.text = self.inviteesArray[indexPath.row]["name"] as! String?
            let status = self.inviteesArray[indexPath.row] as [String:Any]?
            print(status!)
            if ((status?["confirmed"])as! String == "false") {
                cell.confirmedLabel.textColor = UIColor.red
            } else {
                cell.confirmedLabel.textColor = UIColor.green
            }
            
            return cell
        }
//MARK: Prepare for segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "mapView" {
                
                if let destination = segue.destination as? MapInContainer {
                    let eventKey: String = self.passedSelectedEventKey
                    destination.passedSelectedEventKey = eventKey

                }
            }
        }

        
    }


