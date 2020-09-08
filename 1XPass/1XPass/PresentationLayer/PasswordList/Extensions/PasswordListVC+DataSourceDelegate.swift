//
//  PasswordListVC+DataSourceDelegate.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation

// MARK: - DataSourceDelegate

extension PasswordListViewController: DataSourceDelegate {
    
    func dataSourceDidLoadItems(_ items: AnyObject) {
        if let sections = items as? [NSArray], sections.count > 0 {
            if sections[0].count > 0 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        }
        tableView.reloadData()
    }
    
    func dataSourceDidRemoveItems(_ items: AnyObject) {
        if let sections = items as? [NSArray], sections.count > 0 {
            if sections[0].count > 0 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        }
    }
}

