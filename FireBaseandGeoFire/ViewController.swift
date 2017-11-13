//
//  ViewController.swift
//  FireBaseandGeoFire
//
//  Created by josna lyju on 13/11/17.
//  Copyright © 2017 josna lyju. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    //to access location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirService.sharedInstance.authenticateWithFirebase { (user) in
            self.setupLocationManager()
        }
    }
}

//MARK - Location extension

extension ViewController : CLLocationManagerDelegate {
    
    
    //MARK: - Location related methods
    
    func setupLocationManager() {
        
        if FirService.sharedInstance.getLocation() == nil {
            self.isAuthorizedtoGetUserLocation()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.startUpdatingLocation() //this will invoke the didUpdateLocations method
            }
        }
        
    }
    
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation() //got the location and now we can stop updating location.
        }
        FirService.sharedInstance.setUserLocation(location: location)
        
        DispatchQueue.main.async {
            self.locationLabel.text = "\(location.coordinate.latitude) : \(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location \(error)")
    }
}
