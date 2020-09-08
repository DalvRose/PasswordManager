//
//  SetupPasswordVC+UITableViewDataSource.swift
//  1XPass
//
//  Created by Vlad on 02.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension SetupPasswordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case .numberSymbol:
            return stupNumberSymbolRow(indexPath)
        case .passwordStyle:
            return setupPasswordStyleRow(indexPath)
        case .passwordContent:
            return setupPasswordContentRow(indexPath)
        case .generatedPassword:
            return setupGeneratedPasswordRow(indexPath)
        case .passwordName:
            return setupPasswordNameRow(indexPath)
        }
    }
}


