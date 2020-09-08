//
//  PasswordListVC+UITableViewDataSource.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension PasswordListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataSource.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.reusableCell(with: PasswordCell.self , indexPath: indexPath)
        let cellSettings = dataSource.itemAtIndexPath(indexPath) as! CellSettings
        
        cell.configure(cellSettings: cellSettings) { [weak self] in
            self?.tableView.performBatchUpdates(nil)
        }
        return cell
    }
}
