//
//  SplashViewController.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SplashViewController: ViewControllerGenerator {
    
    private var coordinator: ProjectCoordinator?
    
    private var viewModel: SplashViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageViewHeight = CGFloat(140)
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private let vertionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test 1" 
        label.textColor = .white
        return label
    }()
    
    init(coordinator: ProjectCoordinator, viewModel: SplashViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addUIElements() {
        self.view.backgroundColor = cyan
        
        self.view.addSubview(vertionLabel)
        self.view.addSubview(loadingLabel)
        self.view.addSubview(imageView)
        
        viewModel.getVersion()
        
        
    }
    
    override func configUIElements() {
        
        // MARK: -
        vertionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        vertionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40.0).isActive = true
        vertionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80.0).isActive = true
        
        loadingLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20.0).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        
    }
    let disposeBag = DisposeBag()
    
    override func bindViewModel() {
        viewModel.state.asDriver()
            .drive(onNext: {[weak self] (state) in
                
                switch state {
                case .idle:
                    print("idle")
                    
                case .loading:
                    print("idle")
                    
                case .done:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self?.coordinator?.startFromSplashToMainCategoryView()
                    }
                    print("done")
                    
                case .error:
                    print("error")
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.error.bind {[weak self] (error) in
            self?.showTextAlert(title: "error", message: error)
        }
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true 
    }
}


