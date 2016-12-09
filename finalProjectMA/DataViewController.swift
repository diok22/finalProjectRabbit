//
//  DataViewController.swift
//  finalProjectMA
//
//  Created by Dionysis Kastellanis on 06/12/2016.
//  Copyright © 2016 MAfinalProjectGroup. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class DataViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    let locationM = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
      //  print(location.coordinate.latitude)
      //  print(location.coordinate.longitude)
        
    }

 
    @IBAction func ShowEventsListTable(_ sender: UIButton) {
    }
    
    @IBAction func createEventForm(_ sender: UIButton!) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationM.delegate = self
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.requestWhenInUseAuthorization()
        locationM.startUpdatingLocation()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

}

