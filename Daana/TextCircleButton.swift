//
//  TextCircleButton.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-22.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit

class TextCircleButton: CircleButton {
    
    var horizontalAnchor: NSLayoutConstraint? {
        willSet {
            horizontalAnchor?.isActive = false
        }
        didSet {
            horizontalAnchor?.isActive = true
        }
    }
    
    var label = UILabel()
    var red = true {
        didSet {
            if red {
                backgroundColor = .softRed
                label.textColor = .white
            } else {
                backgroundColor = .white
                label.textColor = .textRed
            }
        }
    }

    init(radius: CGFloat, red: Bool, text: String) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: radius*2, height: radius*2)))
        
        widthAnchor.constraint(equalToConstant: radius*2).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        self.red = red
        if red {
            backgroundColor = .softRed
            label.textColor = .white
        } else {
            backgroundColor = .white
            label.textColor = .textRed
        }
        
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
