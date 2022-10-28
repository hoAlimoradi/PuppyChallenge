//
//  MainCategoryViewController.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Lottie

class MainCategoryViewController: ViewControllerGenerator {
    
    private var coordinator: ProjectCoordinator?
    
    private var viewModel: MainCategoryViewModel
    
    private let disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Categores"
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
    
    private var dogAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private var catAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private var dogSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
        return button
    }()
     
    private let dogParentView: UIView = {
        let view = UIView()
        //view.backgroundColor = orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let dogTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Dog"
        return label
    }()
    
    private var catSelectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
        return button
    }()
     
    private let catParentView: UIView = {
        let view = UIView()
        //view.backgroundColor = orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let catTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Cat"
        return label
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
    
    private var assignmentDTO: AssignmentDTO? = nil
    
    init(coordinator: ProjectCoordinator, viewModel: MainCategoryViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addUIElements() {
        
        view.backgroundColor = cyan
        
        view.addSubview(titleLabel)
        view.addSubview(helpLabel)
        
        dogAnimationView.animation = Animation.named("empty.json")
        dogAnimationView.contentMode = .scaleAspectFit
        view.addSubview(dogAnimationView)
        
        catAnimationView.animation = Animation.named("empty.json")
        catAnimationView.contentMode = .scaleAspectFit
        view.addSubview(catAnimationView)
        catAnimationView.play()
        
        view.addSubview(dogParentView)
        dogParentView.addSubview(dogSelectionButton)
        dogParentView.addSubview(dogTitleLabel)
        
        view.addSubview(catParentView)
        catParentView.addSubview(catTitleLabel)
        catParentView.addSubview(catSelectionButton)
        
        dogSelectionButton.addTarget(self, action: #selector(submitDog(sender:)), for: .touchUpInside)
        catSelectionButton.addTarget(self, action: #selector(submitCat(sender:)), for: .touchUpInside)
      
        view.addSubview(nextView)
        nextView.addSubview(nextTitleLabel)
        
        nextView.setOnClickListener {
            self.coordinator?.startFromMainToChoosService()
        }
        
         
        
    }
    
    override func configUIElements() {
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        helpLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28.0).isActive = true
        helpLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        helpLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true   
         
        catParentView.topAnchor.constraint(equalTo: helpLabel.bottomAnchor, constant:  24.0).isActive = true
        catParentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        catParentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        catParentView.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
        
        catSelectionButton.centerYAnchor.constraint(equalTo: catParentView.centerYAnchor).isActive = true
        catSelectionButton.leftAnchor.constraint(equalTo: catParentView.leftAnchor, constant: 16.0).isActive = true
        catSelectionButton.widthAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        catSelectionButton.heightAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        
        catTitleLabel.centerYAnchor.constraint(equalTo: catParentView.centerYAnchor).isActive = true
        catTitleLabel.leftAnchor.constraint(equalTo: catSelectionButton.rightAnchor, constant: 16.0).isActive = true
        catTitleLabel.rightAnchor.constraint(equalTo: catParentView.rightAnchor, constant: -16.0).isActive = true
       
        dogParentView.topAnchor.constraint(equalTo: catParentView.bottomAnchor, constant:  24.0).isActive = true
        dogParentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        dogParentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        dogParentView.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
        
        dogSelectionButton.centerYAnchor.constraint(equalTo: dogParentView.centerYAnchor).isActive = true
        dogSelectionButton.leftAnchor.constraint(equalTo: catParentView.leftAnchor, constant: 16.0).isActive = true
        dogSelectionButton.widthAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        dogSelectionButton.heightAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
        
        dogTitleLabel.centerYAnchor.constraint(equalTo: dogParentView.centerYAnchor).isActive = true
        dogTitleLabel.leftAnchor.constraint(equalTo: dogSelectionButton.rightAnchor, constant: 16.0).isActive = true
        dogTitleLabel.rightAnchor.constraint(equalTo: dogParentView.rightAnchor, constant: -16.0).isActive = true
       
        
        dogAnimationView.topAnchor.constraint(equalTo: dogParentView.bottomAnchor, constant:  8.0).isActive = true
        dogAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dogAnimationView.widthAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        dogAnimationView.heightAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        
        catAnimationView.topAnchor.constraint(equalTo: dogParentView.bottomAnchor, constant: 8.0).isActive = true
        catAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catAnimationView.widthAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        catAnimationView.heightAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        
        // MARK: -
        nextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:  -24.0).isActive = true
        nextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        nextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        nextView.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
         
        nextTitleLabel.centerXAnchor.constraint(equalTo: nextView.centerXAnchor).isActive = true
        nextTitleLabel.centerYAnchor.constraint(equalTo: nextView.centerYAnchor).isActive = true
    }
    
    override func bindViewModel() {
        
        viewModel.getServiceType()
        /*
         viewModel.serviceType.bind {[weak self] (serviceType) in
             print("service type observed: \(serviceType)")
             switch serviceType {
             case .DOG:
                 self?.checkedDog()
             case .CAT:
                 self?.checkedCat()
             }
         }
         .disposed(by: disposeBag)
         */

        
        viewModel.serviceType.asDriver()
            .drive(onNext: {[weak self] (serviceType) in
                    print("service type observed: \(serviceType)")
                    switch serviceType {
                    case .DOG:
                        self?.checkedDog()
                    case .CAT:
                        self?.checkedCat()
                    }
                
            })
            .disposed(by: disposeBag)
        
        
        viewModel.state.asDriver()
            .drive(onNext: {[weak self] (state) in
                
                switch state {
                case .idle:
                    print("idle")
                    
                case .error:
                    print("error")
                }
                
            })
            .disposed(by: disposeBag)
        // viewModel.error.bind(to: loadingLabel.rx.text).disposed(by: disposeBag)
        viewModel.error.bind {[weak self] (error) in
            self?.showTextAlert(title: "error", message: error)
        }
        .disposed(by: disposeBag)
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    
    
    @objc func submitDog(sender: UIButton) {
        checkedDog()
        viewModel.createDogService()
    }
     
    
    @objc func submitCat(sender: UIButton) {
        //var superview = sender.superview
        checkedCat()
        viewModel.createCatService()
    }
    
    
    private func checkedDog() {
        DispatchQueue.main.async {
            self.catAnimationView.isHidden = true
            self.catAnimationView.stop()
            
            self.dogAnimationView.isHidden = false
            self.dogAnimationView.play()
            
            self.dogParentView.backgroundColor = lightblueColord7e8fa
            self.dogSelectionButton.setImage(UIImage(named: "done")!.imageWithColor(color: lightblueColor), for: .normal)
            self.dogTitleLabel.textColor = lightblueColor
            
            self.catParentView.backgroundColor = lightGreyColor
            self.catSelectionButton.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
            self.catTitleLabel.textColor = lightGreyColorcacbcc
        }
    }
    
    
    private func checkedCat() {
        DispatchQueue.main.async {
            self.dogAnimationView.isHidden = true
            self.dogAnimationView.stop()
            
            self.catAnimationView.isHidden = false
            self.catAnimationView.play()
            
            self.catParentView.backgroundColor = lightblueColord7e8fa
            self.catSelectionButton.setImage(UIImage(named: "done")!.imageWithColor(color: lightblueColor), for: .normal)
            self.catTitleLabel.textColor = lightblueColor
            
            self.dogParentView.backgroundColor = lightGreyColor
            self.dogSelectionButton.setImage(UIImage(named: "outline_crop")!.imageWithColor(color: lightGreyColorcacbcc), for: .normal)
            self.dogTitleLabel.textColor = lightGreyColorcacbcc
        }
    }
}




