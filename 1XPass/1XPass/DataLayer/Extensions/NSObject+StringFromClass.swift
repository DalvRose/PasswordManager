//
//  UITableView+Extension.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

public func instancetype<T>(object: Any?) -> T? {
    return object as? T
}

extension NSObject {
    
    static func className() -> String {
        var className = String(describing: self)
        
        if className.contains("<") {
            let components = className.components(separatedBy: "<")
            
            if components.count > 0 {
                className = components[0]
            }
        }
        return className
    }
    
    static func nib(_ bundle: Bundle?) -> UINib {
        let nib = UINib(nibName: self.className(), bundle: bundle)
        return nib
    }
    
    class func fromNib() -> Self? {
        return instancetype(object: Bundle.main.loadNibNamed(String(describing: self.self), owner: nil, options: nil)!.first)
    }
}



