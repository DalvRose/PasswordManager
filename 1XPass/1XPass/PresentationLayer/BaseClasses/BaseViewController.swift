//
//  BaseViewController.swift
//  1XPass
//
//  Created by Vlad on 02.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class BaseViewContoller: UIViewController {

    
    // MARK: - Properties
    
    private var scrollView: UIScrollView?
    
    
    // MARK: - Life Cycle methods
    
    deinit {
        removeNotifications()
    }
    
    // Keyboard offset settings
    
    func offsetForKeyboard(withScrollView: UIScrollView) {
        
        self.scrollView = withScrollView
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView?.contentInset.bottom = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            scrollView?.contentInset.bottom = keyboardRectangle.height
        }
    }
}
