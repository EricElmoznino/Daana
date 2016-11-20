//
//  CharitiesRepository.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-11-13.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit
import CoreLocation

class CharitiesRepository: NSObject, CLLocationManagerDelegate {
    
    let testLocations: [Charity] = [
        Charity(id: 1, name: "first", location: CLLocation(latitude: 43.6552, longitude: -79.4033), address: "123 first", blurb: "first blurb", image: nil, type: .Food),
        Charity(id: 2, name: "second", location: CLLocation(latitude: 43.6577, longitude: -79.4010), address: "123 second", blurb: "second blurb", image: nil, type: .Shelter),
        Charity(id: 3, name: "third", location: CLLocation(latitude: 43.6660, longitude: -79.4148), address: "123 third", blurb: "third blurb", image: nil, type: .Health),
        Charity(id: 4, name: "fourth", location: CLLocation(latitude: 43.7003, longitude: -79.4403), address: "123 fourth", blurb: "fourth blurb", image: nil, type: .Education),
        Charity(id: 5, name: "fifth", location: CLLocation(latitude: 43.6483, longitude: -79.3773), address: "123 fifth", blurb: "fifth blurb", image: nil, type: .Environmental),
        Charity(id: 6, name: "sixth", location: CLLocation(latitude: 43.6648, longitude: -79.3925), address: "123 sixth", blurb: "sixth blurb", image: nil, type: .InternationalNGO)
    ]
    
    func getCharities(fromIds ids: [Int]) -> [Charity] {
        return testLocations.filter{ ids.contains($0.id) }
    }
    
    func getCharities(inRange range: Int, fromLocation: CLLocation?) -> [Charity] {
        if let from = fromLocation {
            return testLocations.filter{ $0.location.distance(from: from) < Double(range * 1000) }
        }
        else {
            return[]
        }
    }
    
}
