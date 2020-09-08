//
//  SetupPasswordRowType.swift
//  1XPass
//
//  Created by Vlad on 02.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation

enum SetupPasswordRowType: Int, CaseIterable {
    case numberSymbol
    case passwordContent
    case passwordStyle
    case generatedPassword
    case passwordName
}
