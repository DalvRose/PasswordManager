//
//  PasswordCell.swift
//  1XPass
//
//  Created by Vlad on 03.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var passwordButton: UIButton!
    @IBOutlet weak private var masterPasswordView: RoundUIView!
    @IBOutlet weak private var passwordOptionsView: RoundUIView!
    @IBOutlet weak private var passwordButtonBackground: UIButton!
    @IBOutlet weak private var masterKeyTextField: UITextField!
    @IBOutlet weak private var passwordLabel: UILabel!
    
    // MARK: - Properties
    
    private var unlockView = UnlockView.fromNib()
    private var cellSettings: CellSettings!
    private var callback: (()->Void)!
    
    // MARK: - Methods
    
    func configure(cellSettings: CellSettings, callback: @escaping (() -> Void)) {
        
        self.callback = callback
        self.cellSettings = cellSettings
        
        passwordButton.setTitle(cellSettings.password.name, for: .normal)
        masterKeyTextField.text = cellSettings.masterKey
        passwordLabel.text = cellSettings.password.value
        expandedBy(cellSettings.expandedState)
        
        masterKeyTextField.autocorrectionType = .no
        masterKeyTextField.inputAccessoryView = unlockView
        
        unlockView?.callback = { [weak self] in
            
            guard let self = self else { return }
            
            if self.masterKeyTextField.text == UserDefaults.standard.string(forKey: "masterPassword") {
                self.expandedBy(.options)
                callback()
            } else {
                self.unlockView?.setupError()
            }
        }
    }
    
    private func expandedBy(_ cellExpandedState: CellExpandedState)  {
        
        switch cellExpandedState {
        case .normal:
            cellSettings.expandedState =  .normal
            cellSettings.masterKey = nil
            masterKeyTextField.text = nil
            masterPasswordView.isHidden = true
            passwordOptionsView.isHidden = true
            passwordButtonBackground.isHidden = false
            
        case .masterPassword:
            cellSettings.expandedState =  .masterPassword
            masterPasswordView.isHidden = false
            passwordOptionsView.isHidden = true
            passwordButtonBackground.isHidden = true
        case .options:
            cellSettings.expandedState =  .options
            masterPasswordView.isHidden = true
            passwordOptionsView.isHidden = false
            passwordButtonBackground.isHidden = true
        }
        masterKeyTextField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapPasswordButton(_ sender: UIButton) {
        if cellSettings.expandedState == .normal {
            expandedBy(.masterPassword)
        } else {
            expandedBy(.normal)
        }
        callback()
    }
    
    @IBAction private func didEditingTextField(_ sender: UITextField) {
        

        if let text = sender.text, text != "" {
            unlockView?.isEnable(state: true)
        } else {
            unlockView?.isEnable(state: false)
        }
        
        cellSettings.masterKey = sender.text
    }
    
    @IBAction private func didTapCopyButton(_ sender: UIButton) {
        UIPasteboard.general.string = cellSettings.password.value
    }
    
    @IBAction private func didTapClosebutton(_ sender: UIButton) {
        expandedBy(.normal)
        callback()
    }
}
