//
//  CircleView.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-12.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width/2
    }

}
