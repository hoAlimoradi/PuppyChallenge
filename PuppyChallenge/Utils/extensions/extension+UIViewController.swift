//
//  extension+UIViewController.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//
 

import UIKit
extension UIViewController{
    func LoadingStart(){
        ProgressDialog.alert = UIAlertController(title: nil, message: "لطفا صبر کنید", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        ProgressDialog.alert.view.addSubview(loadingIndicator)
        present(ProgressDialog.alert, animated: true, completion: nil)
    }
    
    func LoadingStop() {
        DispatchQueue.main.async(execute: {
            ProgressDialog.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    
    func showTextAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            let titFont = [NSAttributedString.Key.foregroundColor: UIColor.red,
                           NSAttributedString.Key.font: UIFont(name: "IRANYekanMobileFN", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
            let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANYekanMobileFN", size: 15) ?? UIFont.systemFont(ofSize: 15.0)]
            
            let titAttrString = NSMutableAttributedString(string: title, attributes: titFont)
            let msgAttrString = NSMutableAttributedString(string: message, attributes: msgFont)
            
            alert.setValue(titAttrString, forKey: "attributedTitle")
            alert.setValue(msgAttrString, forKey: "attributedMessage")
            
            let okAction = UIAlertAction(title: "متوجه شدم", style: .default) { (action) in
                
            }
            
            alert.addAction(okAction)
            
            alert.view.tintColor = UIColor.blue
            alert.view.layer.cornerRadius = 40
            
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
       
    }
    
 
  
}

struct ProgressDialog {
    static var alert = UIAlertController()
    static var progressView = UIProgressView()
    static var progressPoint : Float = 0{
        didSet{
            if(progressPoint == 1){
                ProgressDialog.alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Actions
extension UIViewController {
    @objc func close() {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func presentModal(_ vc: UIViewController, completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            present(vc, animated: true, completion: completion)
        } else {
            //presentAsStork(vc, height: nil, showIndicator: false, showCloseButton: false, complection: completion)
        }
    }
}


// MARK: - Alert
struct Alert {
    static func present(title: String?, message: String, actions: Alert.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension Alert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case retry(handler: (() -> Void)?)
        case close

        // Returns the title of our action button
        private var title: String {
            switch self {
            case .ok:
                return "OK"
            case .retry:
                return "Retry"
            case .close:
                return "Close"
            }
        }

        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            case .retry(let handler):
                return handler
            case .close:
                return nil
            }
        }

        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}

