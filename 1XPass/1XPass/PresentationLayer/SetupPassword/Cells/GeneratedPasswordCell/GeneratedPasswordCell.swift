//
//  GeneratedPasswordCell.swift
//  1XPass
//
//  Created by Vlad on 30.08.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class GeneratedPasswordCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var passwordLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(password: String) {
        passwordLabel.text = password
    }
}


