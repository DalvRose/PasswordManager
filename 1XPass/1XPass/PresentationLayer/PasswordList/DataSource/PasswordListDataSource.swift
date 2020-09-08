//
//  PasswordListDataSource.swift
//  1XPass
//
//  Created by Vlad on 03.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import Foundation


class SearchProductsDataSource: DataSource {
    
    //MARK: - Interface
    
    override func reloadData() {
        
        sections.removeAll()
        loadPasswords { [weak self] (response) in
           if let response = response {
                self?.sections.append(response)
                self?.notifyListenersDidLoadItems()
            }
        }
    }
    
    // MARK: - Methods
    
    func delete(indexPath: IndexPath) {
        
        let cellSettings = itemAtIndexPath(indexPath) as! CellSettings
        let password = cellSettings.password
        
        CoreDataManager.shared.delete(person: password)
        
        sections[indexPath.section].remove(at: indexPath.row)
        notifyListenersRemoveItems()
    }
    
    private func loadPasswords(complition: @escaping ([AnyObject]?)->Void) {
        let passwords = CoreDataManager.shared.fetchAllPasswords()
        var cellSettings = [CellSettings]()
        
        passwords?.forEach({ (password) in
            let cellSetting = CellSettings(password: password)
            cellSettings.append(cellSetting)
        })
        complition(cellSettings as [AnyObject]?)
    }
}
