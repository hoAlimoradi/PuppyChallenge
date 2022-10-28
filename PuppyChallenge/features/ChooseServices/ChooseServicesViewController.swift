//
//  ChooseServicesViewController.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ChooseServicesViewController: ViewControllerGenerator {
    
    private var coordinator: ProjectCoordinator?
    
    private var viewModel: ChooseServicesViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Choose Service"
        label.textColor = .yellow
        return label
    }()
    
    private let helpLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "please select: "
        label.textColor = .white
        return label
    }()
    
 
    
    let disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageViewHeight = CGFloat(140)
    
    private var groomingSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
        return button
    }()
     
    private let groomingParentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let groomingTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Grooming"
        return label
    }()
    
    private var hotelSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
        return button
    }()
     
    private let hotelParentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let hotelTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Hotel"
        return label
    }()
    
    private let numberTextFieldHintLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "number of nights"
        return label
    }()
    
    var numberTextField : UITextField = {
        let textField = UITextField()
        textField.text = "1"
        textField.maxLength = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment =  .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.doneAccessory = true
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = cyan
        textField.backgroundColor = greyColordcdcdc
        textField.layer.borderWidth = 2
        textField.layer.borderColor = greyColordcdcdc.cgColor
        textField.layer.cornerRadius = 10
        textField.setLeftPadding(10)
        textField.setRightPadding(10)
        return textField
    }()
    
    
  
    private let nextView: UIView = {
        let view = UIView()
        view.backgroundColor = orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let nextTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Next"
        label.textColor = .black
        return label
    }()
    
    init(coordinator: ProjectCoordinator, viewModel: ChooseServicesViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addUIElements() {
        self.view.backgroundColor = cyan
        
        view.addSubview(titleLabel)
        view.addSubview(helpLabel)
        
        view.addSubview(groomingParentView)
        groomingParentView.addSubview(groomingSelectionButton)
        groomingParentView.addSubview(groomingTitleLabel)
        
        view.addSubview(hotelParentView)
        hotelParentView.addSubview(hotelTitleLabel)
        hotelParentView.addSubview(hotelSelectionButton)
        
        hotelSelectionButton.addTarget(self, action: #selector(submitHotel(sender:)), for: .touchUpInside)
        groomingSelectionButton.addTarget(self, action: #selector(submitGrooming(sender:)), for: .touchUpInside)
         
        
        view.addSubview(numberTextFieldHintLabel)
        numberTextFieldHintLabel.isHidden = true
        
        view.addSubview(numberTextField)
        numberTextField.isHidden = true
        numberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(nextView)
        nextView.addSubview(nextTitleLabel)
        
        nextView.setOnClickListener {
            self.viewModel.goNext()
        }
        
        self.nextView.isHidden = true
         
        
    }
    
    override func configUIElements() { 
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        helpLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        helpLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        helpLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        
        groomingParentView.topAnchor.constraint(equalTo: helpLabel.bottomAnchor, constant:  24.0).isActive = true
        groomingParentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        groomingParentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        groomingParentView.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
       
        groomingSelectionButton.centerYAnchor.constraint(equalTo: groomingParentView.centerYAnchor).isActive = true
        groomingSelectionButton.leftAnchor.constraint(equalTo: groomingParentView.leftAnchor, constant: 16.0).isActive = true
        groomingSelectionButton.widthAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        groomingSelectionButton.heightAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
       
        groomingTitleLabel.centerYAnchor.constraint(equalTo: groomingParentView.centerYAnchor).isActive = true
        groomingTitleLabel.leftAnchor.constraint(equalTo: groomingSelectionButton.rightAnchor, constant: 16.0).isActive = true
        groomingTitleLabel.rightAnchor.constraint(equalTo: groomingParentView.rightAnchor, constant: -16.0).isActive = true
       
        hotelParentView.topAnchor.constraint(equalTo: groomingParentView.bottomAnchor, constant:  24.0).isActive = true
        hotelParentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        hotelParentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        hotelParentView.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
       
        hotelSelectionButton.centerYAnchor.constraint(equalTo: hotelParentView.centerYAnchor).isActive = true
        hotelSelectionButton.leftAnchor.constraint(equalTo: hotelParentView.leftAnchor, constant: 16.0).isActive = true
        hotelSelectionButton.widthAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        hotelSelectionButton.heightAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
       
        hotelTitleLabel.centerYAnchor.constraint(equalTo: hotelParentView.centerYAnchor).isActive = true
        hotelTitleLabel.leftAnchor.constraint(equalTo: hotelSelectionButton.rightAnchor, constant: 16.0).isActive = true
        hotelTitleLabel.rightAnchor.constraint(equalTo: hotelParentView.rightAnchor, constant: -16.0).isActive = true
        
        numberTextFieldHintLabel.topAnchor.constraint(equalTo: hotelParentView.bottomAnchor, constant:  8.0).isActive = true
        numberTextFieldHintLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        numberTextFieldHintLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        numberTextField.topAnchor.constraint(equalTo: numberTextFieldHintLabel.bottomAnchor, constant:  8.0).isActive = true
        numberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        numberTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        numberTextField.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
        
        // MARK: -
        nextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:  -24.0).isActive = true
        nextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        nextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        nextView.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
         
        nextTitleLabel.centerXAnchor.constraint(equalTo: nextView.centerXAnchor).isActive = true
        nextTitleLabel.centerYAnchor.constraint(equalTo: nextView.centerYAnchor).isActive = true
    }
    
    override func bindViewModel() {
        viewModel.state.asDriver()
            .drive(onNext: {[weak self] (state) in
                
                switch state {
                case .idle:
                    print("idle") 
                    
                case .next:
                    self?.coordinator?.startFromChoosServiceToCalculateCost()
                    print("done")
                    
                case .error:
                    print("error")
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.nightsObserver.asDriver()
            .drive(onNext: {[weak self] (nights) in
                self?.numberTextField.text = nights
            })
            .disposed(by: disposeBag)
        
        viewModel.error.bind {[weak self] (error) in
            self?.showTextAlert(title: "error", message: error)
        }
        .disposed(by: disposeBag)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = false
    }
    
    
    @objc func submitHotel(sender: UIButton) {
        DispatchQueue.main.async {
            self.hotelParentView.backgroundColor = lightblueColord7e8fa
            self.hotelSelectionButton.setImage(UIImage(named: "done")!.imageWithColor(color: lightblueColor), for: .normal)
            self.hotelTitleLabel.textColor = lightblueColor
            
            self.groomingParentView.backgroundColor = lightGreyColor
            self.groomingSelectionButton.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
            self.groomingTitleLabel.textColor = lightGreyColorcacbcc
            
            self.numberTextField.isHidden = false
            self.numberTextFieldHintLabel.isHidden = false
            self.nextView.isHidden = false
        }
        
        viewModel.setHotel(nights: numberTextField.text)
    }
     
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.setHotel(nights: numberTextField.text)
    }
    
    @objc func submitGrooming(sender: UIButton) {
        DispatchQueue.main.async {
            self.groomingParentView.backgroundColor = lightblueColord7e8fa
            self.groomingSelectionButton.setImage(UIImage(named: "done")!.imageWithColor(color: lightblueColor), for: .normal)
            self.groomingTitleLabel.textColor = lightblueColor
            
            self.hotelParentView.backgroundColor = lightGreyColor
            self.hotelSelectionButton.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
            self.hotelTitleLabel.textColor = lightGreyColorcacbcc
            
            self.numberTextField.isHidden = true
            self.numberTextFieldHintLabel.isHidden = true
            
            self.nextView.isHidden = false
        }

        viewModel.setGrooming()
        
    }
    
}





