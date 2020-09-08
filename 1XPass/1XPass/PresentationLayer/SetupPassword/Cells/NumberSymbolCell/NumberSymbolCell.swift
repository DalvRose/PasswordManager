//
//  NumberSymbolCell.swift
//  1XPass
//
//  Created by Vlad on 30.08.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class NumberSymbolCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var callback: ((Int)->Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak private var symbolCountLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(callback: @escaping ((Int) -> Void)) {
        self.callback = callback
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapMinusButton(_ sender: UIButton) {
        
        guard let symbolCount = symbolCountLabel.text?.toInt(), symbolCount > 1
            else { return }
        
        symbolCountLabel.text = "\(symbolCount - 1)"
        
        if let callback = callback {
            callback(symbolCount - 1)
        }
        
    }
    
    @IBAction private func didTapPlusButton(_ sender: UIButton) {
        
        guard let symbolCount = symbolCountLabel.text?.toInt()
            else { return }
        
        symbolCountLabel.text = "\(symbolCount + 1)"
        
        if let callback = callback {
            callback(symbolCount + 1)
        }
        
    }
}


