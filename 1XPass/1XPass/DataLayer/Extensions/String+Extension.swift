//
//  String+Extension.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation

extension String {
    
    func toInt() -> Int? {
        guard let number = Int(self)
            else { return nil }
        return number
    }
}

