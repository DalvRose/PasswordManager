//
//  CellSettings.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation

enum CellExpandedState {
       case normal
       case masterPassword
       case options
   }
   
class CellSettings {
    
    // MARK: - Properties
    
    var expandedState: CellExpandedState = .normal
    var masterKey: String?
    var password: Password
    
    init(password: Password) {
        self.password = password
    }
}
