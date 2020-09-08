//
//  PasswordAbilityCell.swift
//  1XPass
//
//  Created by Vlad on 30.08.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class PasswordAbilityCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var button1: UIButton!
    @IBOutlet weak private var button2: UIButton!
    @IBOutlet weak private var button3: UIButton!
    @IBOutlet weak var optionsTextLabel: UILabel!
    
    // MARK: - Properties
    
    private var callback: ((Int)-> Void)?
    private var buttons: [UIButton] { [button1, button2, button3] }
    
    // MARK: - Methods
    
    func configure(cellType: SetupPasswordRowType, menager: PasswordManager, callback: @escaping ((Int) -> Void)) {
        
        if cellType == .passwordContent {
            button1.tag = PasswordContent.literal.rawValue
            button2.tag = PasswordContent.specialSymbol.rawValue
            button3.tag = PasswordContent.number.rawValue
            
            button1.setTitle("Literal", for: .normal)
            button2.setTitle("Special Symbol", for: .normal)
            button3.setTitle("Number", for: .normal)
            
            optionsTextLabel.text = "Password content (tap to select)"
            
            buttons.forEach { (button) in
                if let passwordContent =  PasswordContent(rawValue: button.tag),
                    (menager.passwordContents.contains(passwordContent)) {
                    button.setTitleColor(UIColor(named: "Color6"), for: .normal)
                } else {
                    button.setTitleColor(UIColor(named: "Color8"), for: .normal)
                }
            }
        } else {
            button1.tag = PasswordStyle.apple.rawValue
            button2.tag = PasswordStyle.pinUp.rawValue
            button3.tag = PasswordStyle.token.rawValue
            
            button1.setTitle("Apple", for: .normal)
            button2.setTitle("1XPass", for: .normal)
            button3.setTitle("Token", for: .normal)
            
            optionsTextLabel.text = "Password style (tap to select)"
            
            buttons.forEach { (button) in
                if let passwordStyle =  PasswordStyle(rawValue: button.tag),
                    menager.passwordStyle == passwordStyle {
                    button.setTitleColor(UIColor(named: "Color6"), for: .normal)
                } else {
                    button.setTitleColor(UIColor(named: "Color8"), for: .normal)
                }
            }
        }
        
        self.callback = callback
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapOptionsButton(_ sender: UIButton) {
        if let callback = callback {
            callback(sender.tag)
        }
    }
}
