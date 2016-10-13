//
//  SliderSymbol.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-12.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

@IBDesignable
class SliderSymbol: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height/2
    }

}
