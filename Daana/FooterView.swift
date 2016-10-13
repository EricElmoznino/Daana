//
//  FooterView.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-12.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

@IBDesignable
class FooterView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 4
    }

}
