//
//  DonateButton.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-15.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

class DonateButton: CircleButton {
    
    var horizontalAnchor: NSLayoutConstraint? {
        willSet {
            horizontalAnchor?.isActive = false
        }
        didSet {
            horizontalAnchor?.isActive = true
        }
    }
    
    var icon: UIImageView!
    var iconColor: UIColor = .white

    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon = UIImageView(image: UIImage(named: "Heart Icon")?.withRenderingMode(.alwaysTemplate))
        icon.tintColor = iconColor
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.1, constant: 0).isActive = true
        icon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        icon.heightAnchor.constraint(equalTo: icon.widthAnchor, multiplier: 1.0).isActive = true
    }

}
