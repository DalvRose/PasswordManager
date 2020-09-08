//
//  UIButton+Extension.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

@IBDesignable
class RoundUIButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}
