//
//  extension+UIView.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//
 

import Foundation
import UIKit

public extension UIViewController {
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = color
        overView.tag = tag
        self.view.addSubview(overView)
    }
}
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}

extension UIView {
    
    func isSmallPhone(completion: @escaping (Bool) -> Void){
        
        switch UIDevice().typeModel {
        case .iPod1, .iPod2, .iPod3, .iPod4, .iPod5, .iPod6, .iPod7, .iPad2, .iPad3, .iPad4, .iPadAir, .iPadAir2, .iPadAir3, .iPadAir4, .iPad5, .iPad6, .iPad7, .iPad8, .iPad9,.iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5, .iPadMini6, .iPadPro9_7, .iPadPro10_5, .iPadPro11, .iPadPro2_11, .iPadPro3_11, .iPadPro12_9, .iPadPro2_12_9, .iPadPro3_12_9, .iPadPro4_12_9, .iPadPro5_12_9, .iPhone5, .iPhone5S, .iPhone5C, .iPhone6, .iPhone6S, .iPhone6Plus, .iPhoneSE, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus :
            
            completion(true)
             
        default:
             
            completion(false)
        }
    }
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
}

extension UIView {
    
    
    
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        top + height
    }
    
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}




protocol ErrorPresentable {
    func showErrorDialogView(_ error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    
    func showErrorDialogView(_ error: Error) {
        
        DispatchQueue.main.async {
            //let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            var alert: UIAlertController
            if let localized = error as? LocalizedError {
                print(localized.failureReason)
                print(localized.recoverySuggestion)
                alert = UIAlertController(title: localized.recoverySuggestion, message: nil, preferredStyle: .alert)
            } else {
                alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            }
            
            alert.addAction(.init(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
}

