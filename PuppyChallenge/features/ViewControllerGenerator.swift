//
//  ViewControllerGenerator.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewControllerGenerator: UIViewController,
                               LoadingProtocol,
                               ErrorPresentable {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // MARK: - UI Configuration
    
    open func addUIElements() {
        fatalError("override and impelement \(#function)")
    }
    
    open func configUIElements() {
        fatalError("override and impelement \(#function)")
    }
    
    open func bindViewModel() {
        fatalError("override and impelement \(#function)")
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        addUIElements()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configUIElements()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height)/3
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
        self.LoadingStop()
        switch error._code {
        case 1001:
            self.showErrorAlert(" description 1001")
        case 400:
            self.showErrorAlert(" description 400")
        case 403:
            self.showErrorAlert(" description 403")
        case 404:
            self.showErrorAlert(" description 404")
            
        default:
            self.showErrorAlert(error.localizedDescription)
        }
    }
    
    func showErrorAlert(_ error: String) {
        self.LoadingStop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showTextAlert(title: "error", message: error)
        }
    }
}


