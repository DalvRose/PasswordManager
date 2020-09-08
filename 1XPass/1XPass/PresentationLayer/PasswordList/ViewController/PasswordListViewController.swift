//
//  PasswordListViewController.swift
//  1XPass
//
//  Created by Vlad on 03.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class PasswordListViewController: BaseViewContoller {
    
    // MARK: - Outlets
    
    @IBOutlet weak var messegeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var dataSource = SearchProductsDataSource()
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupMessege()
        registerCell()
        offsetForKeyboard(withScrollView: tableView)
    }
    
    // MARK: - Methods
    
    private func setupMessege() {
        messegeLabel.text = "Password that you \ncreate with PasswordPro will \nbe stored here."
    }
    
    private func setupDataSource() {
        dataSource.addListener(self)
        dataSource.reloadData()
    }
    
    private func registerCell() {
        tableView.register(PasswordCell.nib(nil), forCellReuseIdentifier: PasswordCell.className())
    }
    
    private func showSetupPasswordVC() {
        let storyboard = UIStoryboard(name: SetupPasswordViewController.className(),
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SetupPasswordViewController.className()) as! SetupPasswordViewController
        
        vc.callback = { [weak self] in
            self?.dataSource.reloadData()
        }
        
        self.present(vc, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapAddPasswordButton(_ sender: UIButton) {
        showSetupPasswordVC()
    }
}


