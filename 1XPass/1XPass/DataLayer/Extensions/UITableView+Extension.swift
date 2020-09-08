//
//  UITableView+Extension.swift
//  1XPass
//
//  Created by Vlad on 04.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reusableCell<T>(with type: T.Type, indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: type.className(), for: indexPath) as? T else {
            fatalError("CollectionViewCell's type is not valid")
        }
        return cell
    }
    
}
