//
//  asda.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

extension PasswordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            self.dataSource.delete(indexPath: indexPath)
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
         
        deleteAction.image = UIImage(named: "SF_xmark_seal_fill")
        deleteAction.backgroundColor = UIColor(named: "Color2")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
