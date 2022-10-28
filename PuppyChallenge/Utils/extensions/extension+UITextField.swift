//
//  extension+UITextField.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}

extension UITextField {
 
    
        func placeholderColor(_ color: UIColor) {
            var placeholderText = ""
            if self.placeholder != nil{
                placeholderText = self.placeholder!
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributeString = [
                NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6)
                //,NSAttributedString.Key.font: self.font!,
                //.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributeString)
        }
     
}

extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension UITextField {

    func setLeftPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}






