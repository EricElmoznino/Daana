//
//  LocationHandler.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-11-13.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationHandlerDelegate {
    func locationDidUpdate()
}

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var delegate: LocationHandlerDelegate?
    
    override init() {
        super.init()
        
        setupLocationManager()
    }
    
    // MARK: Location manager delegate functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationDidUpdate()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch (status) {
        case CLAuthorizationStatus.notDetermined:
            break
        case CLAuthorizationStatus.authorizedWhenInUse:
            break
        case CLAuthorizationStatus.denied:
            // Do some error handling, like showing a message on the screen
            // that the app cannot work since it doesn't know the location
            break
        case CLAuthorizationStatus.restricted:
            // Do some error handling, like showing a message on the screen
            // that the app cannot work since it doesn't know the location
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let code = (error as NSError).code
        switch code {
        case CLError.denied.rawValue:
            // User changed location settings
            manager.requestWhenInUseAuthorization()
        case CLError.headingFailure.rawValue:
            // Magnetic interference
            print("magnetic interference preventing location services from functioning correctly")
        case CLError.locationUnknown.rawValue:
            // Not able to retrieve location instantaneously
            print("triggered kCLLocationUnknown")
        default:
            // other errors
            print("An error occured - Core Location")
        }
    }
    
    // MARK: Initialization helper functions
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 25.0
        // Required for newer versions of iOS
        if locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }

}
