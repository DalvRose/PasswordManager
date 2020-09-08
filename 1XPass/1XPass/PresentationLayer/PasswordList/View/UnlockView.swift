//
//  UnlockView.swift
//  1XPass
//
//  Created by Vlad on 03.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class UnlockView:  UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var unlockButton: UIButton!
    
    // MARK: - Properties
    
    var callback: (()->Void)?
    
    // MARK: - Methods
    
    func isEnable(state: Bool) {
        if state {
            unlockButton.setTitleColor(UIColor(named: "Color6"), for: .normal)
            unlockButton.backgroundColor = UIColor(named: "Color1")
        } else {
            unlockButton.backgroundColor = UIColor(named: "Color3")
            unlockButton.setTitleColor(UIColor(named: "Color8"), for: .normal)
        }
        unlockButton.setTitle("Unlock", for: .normal)
        unlockButton.isEnabled = state
    }
    
    func setupError() {
        unlockButton.setTitle("Wrong master-password", for: .normal)
        unlockButton.setTitleColor(UIColor(named: "Color6"), for: .normal)
        unlockButton.backgroundColor = UIColor(named: "Color1")
        
    }
    
    // MARK: - Actions
    
    @IBAction func daidTapUnlockButton(_ sender: UIButton) {
        if let callback = callback {
            callback()
        }
    }
}
