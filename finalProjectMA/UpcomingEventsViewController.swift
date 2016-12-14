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

class UpcomingEventsTableViewController: UITableViewController {
    
    var selectedEvent: [Event] = []
    var currentUser: User!
    var myEventsKey:[String]=[]
    var selectedEventKey:String=""
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailMapTap" {
            let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow
            self.selectedEventKey = self.myEventsKey[(indexPath?[1])!]
            
            
            if let destination = segue.destination as? MapViewController {
                destination.passedSelectedEventKey = self.selectedEventKey
            }
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
                for myEvent in snapshot.children.allObjects as! [FIRDataSnapshot]{
                    self.myEventsKey.append(myEvent.key)
                    let eventInstance = Event(snapshot: myEvent as! FIRDataSnapshot)
                    let eventTime = eventInstance.time
                    let eventTimeObject = NSDate(timeIntervalSince1970: eventTime as! TimeInterval)

                    let calendar = NSCalendar.current

                    
                    let eventTimeObjectComparison = calendar.dateComponents([.year, .month, .day], from: eventTimeObject as Date)
                    let date = NSDate()
                    let dateToday = calendar.dateComponents([.year, .month, .day], from: date as Date)

                    if (dateToday == eventTimeObjectComparison){
                    myEvents.append(eventInstance)
                    }
                }
                self.events = myEvents
                self.tableView.reloadData()
            })
            
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"upcomingEventCell") as! UpcomingEventTableViewCell
        cell.eventTitleInCell.text = events[indexPath.row].name
        let eventDateTimeInterval = events[indexPath.row].time
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        var eventDateTime = NSDate()
        eventDateTime = NSDate(timeIntervalSince1970: eventDateTimeInterval as! TimeInterval)
        cell.eventTimeInCell.text = formatter.string(from: eventDateTime as Date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventInstance = events[indexPath.row]
            eventInstance.ref?.removeValue()
        } else if editingStyle == .insert {
            
        }
    }
    
}
