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
    
    @IBOutlet weak var countDown: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailMapTap" {
            let indexPath: IndexPath? = self.tableView.indexPathForSelectedRow
            self.selectedEvent = [events[(indexPath?[1])!]]
            if let destination = segue.destination as? MapViewController {
                destination.passedSelectedEvent = self.selectedEvent
            }
        }
    }
    
    
    let ref = FIRDatabase.database().reference(withPath: "events")
    var events: [Event] = []
    
    let formatter = DateFormatter()
    let userCalendar = Calendar.current;
    let requestedComponent : Set<Calendar.Component> = [
        Calendar.Component.month,
        Calendar.Component.day,
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
    ]
    
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loading current user")
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.currentUser = User(authData: user)
            print("current users email in events list view: \(self.currentUser.email)")
        }
//
        ref.observe(.value, with: { snapshot in
            var newEvents: [Event] = []
            
            for event in snapshot.children {
                let eventInstance = Event(snapshot: event as! FIRDataSnapshot)
                for i in 0..<eventInstance.invitees.count {
                if ((eventInstance.invitees[i]["email"] as! String).contains(self.currentUser.email)) || eventInstance.addedByUser == self.currentUser.email {
                    newEvents.append(eventInstance)
                    break
                }
                }
                
            }
            self.events = newEvents
            self.tableView.reloadData()
        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        /// countdown
        func printTime() {
            formatter.dateFormat = "dd/MM/yy hh:mm:ss a"
            let startTime = NSDate()
            let endTime = formatter.date(from: "25/12/16 12:00 a")
            let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime as Date, to: endTime!)
            
            countDown.text = "\(timeDifference.month!) Months \(timeDifference.day!) Days \(timeDifference.minute!) Minutes \(timeDifference.second!) Seconds"
        }
        
        
        
        
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
