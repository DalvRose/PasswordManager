//
//  PasswordNameCell.swift
//  1XPass
//
//  Created by Vlad on 30.08.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class PasswordNameCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Properties
    
    private var callback: ((String)->Void)?
    
    // MARK: - Methods
    
    func configure(callback: @escaping ((String) -> Void)) {
        self.callback = callback
        textField.autocorrectionType = .no
    }
    
    // MARK: - Actions
    
    @IBAction private func textFieldChanged(_ sender: UITextField) {
        if let callback = callback {
            callback(sender.text ?? "")
        }
    }
}
