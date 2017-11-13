//
//  FirService.swift
//  FND
//
//  Created by josna lyju on 2/7/17.
//  Copyright © 2017 josna lyju. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
import GeoFire

class FirService {
    
    struct FndDatabase {
        static let PROFILE = Database.database().reference().child("Profile")
        static let LOCATION = Database.database().reference().child("userlocation")
        static let GEO_REF = GeoFire(firebaseRef: LOCATION)
    }
    
    static let sharedInstance: FirService = FirService()
    
    private init(){}
    
    func setUserLocation(location: CLLocation) {
        let uid = Auth.auth().currentUser?.uid
        FndDatabase.GEO_REF?.setLocation(location, forKey: uid)
        
    }
    
    func getLocation() -> CLLocation? {
        var loc: CLLocation?
        if let uid = Auth.auth().currentUser?.uid {
            FndDatabase.GEO_REF?.getLocationForKey(uid, withCallback: { (location, err) in
                if err != nil {
                    print( "Error getting Userlocation from Geofire \(err.debugDescription)")
                } else {
                    print( "UserLocation is available \(location.debugDescription)")
                    loc = location
                }
            })
            
        }
        return loc
    }
    
    //login to firebase with FB token
    func authenticateWithFirebase(completion: @escaping (_ uid: String) -> Void) {
        Auth.auth().signIn(withEmail: "test@gmail.com", password: "password") { (user, error) in
            
            print("User logged in as \(user!.uid)")
            completion((user?.uid)!)
        }
    }
    
}
