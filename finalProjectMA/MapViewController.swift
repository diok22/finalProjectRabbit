//
//  MapViewController.swift
//  finalProjectMA
//
//  Created by Manuela Sabatino on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

    import UIKit
    import GoogleMaps

    class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var passedSelectedEvent: [Event] = []
        var inviteesArray:[[String:Any]] = []
        
        @IBOutlet weak var tableView: UITableView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.inviteesArray = passedSelectedEvent[0].invitees
        }
// MARK: TableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return inviteesArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "InviteeOnMapViewCell") as! InviteeMapViewTableViewCell
            return cell
        }
//MARK: Prepare for segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "mapView" {
                
                if let destination = segue.destination as? MapInContainer {
                    let event: [Event] = self.passedSelectedEvent
                    destination.passedSelectedEventFromList = event

                }
            }
        }

        
    }


