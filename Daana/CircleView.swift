//
//  CircleView.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-12.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.width/2
        
        let icon = viewWithTag(2) as? UIImageView
        icon?.image = icon?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    }

}
