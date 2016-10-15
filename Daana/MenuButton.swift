//
//  MenuButton.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-15.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

class MenuButton: CircleButton {

    var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        icon = UIImageView(image: UIImage(named: "Menu Icon")?.withRenderingMode(.alwaysTemplate))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 6
    }

}
