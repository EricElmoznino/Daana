//
//  Charity.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-11-13.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit
import CoreLocation

class Charity: NSObject {
    let id: Int
    let name: String
    let location: CLLocation
    let address: String
    let blurb: String?
    let image: UIImage?
    let type: CharityType
    
    init(id: Int, name: String, location: CLLocation, address: String,
         blurb: String?, image: UIImage?, type: CharityType) {
        self.id = id
        self.name = name
        self.location = location
        self.address = address
        self.blurb = blurb
        self.image = image
        self.type = type
    }
    
    
    enum CharityType {
        case Food
        case Shelter
        case Health
        case Education
        case Environmental
        case InternationalNGO
    }
}

extension Charity {
    static func ==(lhs: Charity, rhs: Charity) -> Bool {
        return lhs.id == rhs.id
    }
}
