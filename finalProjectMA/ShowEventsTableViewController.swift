//
//  ShowEventsTableViewController.swift
//  
//
//  Created by Edward Powderham on 07/12/2016.
//
//
import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ShowEventsTableViewController: UITableViewController {
    
    var selectedEvent: [Event] = []
    var currentUser: User!
    var myEventsKey:[String]=[]
    var selectedEventKey:String=""


       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailMapTap" {
            let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow
            self.selectedEventKey = self.myEventsKey[(indexPath?[1])!]
            print(self.selectedEventKey)
            
            let eventRef = FIRDatabase.database().reference(withPath: "events")
                eventRef.child(self.selectedEventKey).child("invitees").observe(.value, with:{snapshot in
                    var usersArray : [[String:AnyObject]] = []
                    let enumerator = snapshot.children
                    while let invitedUser = enumerator.nextObject() as? FIRDataSnapshot {
                        let userValue = invitedUser.value as! [String:AnyObject]
                        print(userValue)
//                        for i in 0..<inviteesArray.count {
//                            let email = inviteesArray[i]["email"] as! String
//                            let userEmail = userValue["email"] as! String
//                            if userEmail == email {
//                                usersArray.append(userValue)
//                            }
//                        }

                    
             
//                    for i in 0..<invitees.count {
//                        var currentInvitee = invitees[i] as! [String:Any]
//                    if self.currentUser.email == currentInvitee["email"] as! String{
//                        eventRef.child(String(i)).child("confirmed").setValue(true)
//
//                    }
//                }
                    }
            })
            
            
            
            }
            
            if let destination = segue.destination as? MapViewController {
                destination.passedSelectedEventKey = self.selectedEventKey
            }
        
    }
    
    
    let ref = FIRDatabase.database().reference(withPath: "events")
    var events: [Event] = []
    var currentUserEventsRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                print("loading current user")
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.currentUser = User(authData: user)
            print("current users email in events list view: \(self.currentUser.email)")
            self.currentUserEventsRef = FIRDatabase.database().reference(withPath: "users").child(self.currentUser.uid).child("myEvents")
            self.currentUserEventsRef.observe(.value, with: {snapshot in
                var myEvents:[Event] = []
                print(snapshot)
                for myEvent in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    self.myEventsKey.append(myEvent.key)
                    let eventInstance = Event(snapshot: myEvent as! FIRDataSnapshot)
                    myEvents.append(eventInstance)
                }
                self.events = myEvents
                print(self.events)
                self.tableView.reloadData()
            })

        }

        
        
    
//        ref.observe(.value, with: { snapshot in
//            var newEvents: [Event] = []
//            
//            for event in snapshot.children {
//                let eventInstance = Event(snapshot: event as! FIRDataSnapshot)
//                for i in 0..<eventInstance.invitees.count {
//                if ((eventInstance.invitees[i]["email"] as! String).contains(self.currentUser.email)) || eventInstance.addedByUser == self.currentUser.email {
//                    newEvents.append(eventInstance)
//                    break
//                }
//                }
//                
//            }
//            self.events = newEvents
//            self.tableView.reloadData()
//        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"eventCell") as! EventTableViewCell
        cell.eventTitleInCell.text = events[indexPath.row].name
        let eventDateTimeInterval = events[indexPath.row].time
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        var eventDateTime = NSDate()
        eventDateTime = NSDate(timeIntervalSince1970: eventDateTimeInterval as! TimeInterval)
        cell.eventTimeInCell.text = formatter.string(from: eventDateTime as Date)
        cell.eventLocationInCell.text = events[indexPath.row].address
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        let eventInstance = events[indexPath.row]
        eventInstance.ref?.removeValue()
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
