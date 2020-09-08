//
//  SetupPasswordViewController.swift
//  1XPass
//
//  Created by Vlad on 27.08.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit
import CoreData

class SetupPasswordViewController: BaseViewContoller {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Properties
    
    lazy var passwordManager = PasswordManager()
    var cells = SetupPasswordRowType.allCases
    var callback: (()->Void)?
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        offsetForKeyboard(withScrollView: tableView)
    }
    
    // MARK: - Methods
    
    private func registerCells() {
        tableView.register(NumberSymbolCell.nib(nil), forCellReuseIdentifier: NumberSymbolCell.className())
        tableView.register(PasswordAbilityCell.nib(nil), forCellReuseIdentifier: PasswordAbilityCell.className())
        tableView.register(PasswordAbilityCell.nib(nil), forCellReuseIdentifier: PasswordAbilityCell.className())
        tableView.register(GeneratedPasswordCell.nib(nil), forCellReuseIdentifier: GeneratedPasswordCell.className())
        tableView.register(PasswordNameCell.nib(nil), forCellReuseIdentifier: PasswordNameCell.className())
    }
    
    private func updatePassword() {
        updateDoneButton()
        tableView.reloadData()
    }
    
    private func updateDoneButton() {
        if !passwordManager.passwordContents.isEmpty,
            let _ = passwordManager.passwordStyle,
            let passwordName = passwordManager.passwordName,
            passwordName != ""{
            doneButton.isEnabled = true
            doneButton.tintColor = UIColor(named: "Color6")
        } else {
            doneButton.isEnabled = false
            doneButton.tintColor = UIColor(named: "Color8")
        }
    }
    
    func stupNumberSymbolRow(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: NumberSymbolCell.self , indexPath: indexPath)
        cell.configure { [weak self] (symbolCount) in
            
            self?.passwordManager.length = symbolCount
            self?.updatePassword()
        }
        return cell
    }
    
    func setupPasswordContentRow(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: PasswordAbilityCell.self , indexPath: indexPath)
        
        cell.configure(cellType: .passwordContent, menager: passwordManager) { [weak self] tag in
            guard let passwordContent = PasswordContent(rawValue: tag) else { return }
            
            if (self?.passwordManager.passwordContents.contains(passwordContent))! {
                self?.passwordManager.passwordContents.remove(passwordContent)
            } else {
                self?.passwordManager.passwordContents.insert(passwordContent)
            }
            self?.updatePassword()
        }
        return cell
    }
    
    func setupPasswordStyleRow(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: PasswordAbilityCell.self , indexPath: indexPath)
        
        cell.configure(cellType: .passwordStyle, menager: passwordManager) { [weak self] tag in
            guard let passwordStyle = PasswordStyle(rawValue: tag) else { return }
            self?.passwordManager.passwordStyle = passwordStyle
            self?.updatePassword()
        }
        return cell
    }
    
    func setupGeneratedPasswordRow(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: GeneratedPasswordCell.self , indexPath: indexPath)
        
        let password = passwordManager.generatePassword()
        cell.configure(password: password)
        return cell
    }
    
    func setupPasswordNameRow(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: PasswordNameCell.self , indexPath: indexPath)
        cell.configure { [weak self] (passwordName) in
            self?.passwordManager.passwordName = passwordName
            self?.updateDoneButton()
        }
        return cell
    }
    
    func showNewPasswordAlert() {
        let alert = UIAlertController(title: "New Password", message: "Please, set new master password:", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "New password"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            UserDefaults.standard.set(textField?.text, forKey: "masterPassword")
            self.savePassword()
            self.back(isUpdate: true) 
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func savePassword() {
        CoreDataManager.shared.savePassword(name: passwordManager.passwordName!,
                                            value: passwordManager.generatePassword())
    }
    
    func back(isUpdate: Bool) {
        guard let callback = callback else { return }
        
        if isUpdate {
             callback()
            self.dismiss(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        back(isUpdate: false)
    }
    
    @IBAction func didTapDoneButton(_ sender: UIButton) {
        
        if let _ = UserDefaults.standard.string(forKey: "masterPassword") {
            savePassword()
            back(isUpdate: true)
        } else {
            showNewPasswordAlert()
        }
    }
}







