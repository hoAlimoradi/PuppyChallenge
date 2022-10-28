//
//  CalculateCostViewController.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
 
import Foundation
import UIKit
import RxSwift
import RxCocoa

class CalculateCostViewController: ViewControllerGenerator {
    
    private var coordinator: ProjectCoordinator?
    
    private var viewModel: CalculateCostViewModel
    
    let disposeBag = DisposeBag()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageViewHeight = CGFloat(140)
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Prepare to calculate"
        label.textColor = .yellow
        return label
    }()
   
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
  
    private let apiCallView: UIView = {
        let view = UIView()
        view.backgroundColor = orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let apiCallTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "apiCall"
        label.textColor = .black
        return label
    }()
    
    private let resetView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let resetTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Back To Home"
        label.textColor = .black
        return label
    }()
    
    init(coordinator: ProjectCoordinator, viewModel: CalculateCostViewModel) {
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
        view.addSubview(resultLabel)
        
        view.addSubview(resetView)
        resetView.addSubview(resetTitleLabel)
        
        view.addSubview(apiCallView)
        apiCallView.addSubview(apiCallTitleLabel)
        
        apiCallView.setOnClickListener {
            Task {
                await self.viewModel.assignment()
            }
        }
        
        resetView.setOnClickListener {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for aViewController in viewControllers {
                    if aViewController is MainCategoryViewController {
                        self.navigationController?.popToViewController(aViewController, animated: true)
                    }
                }
                
            }
        }
       
        
         
    }
    
    override func configUIElements() {
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48.0).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        
        // MARK: -
        
        resetView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:  -24.0).isActive = true
        resetView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        resetView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        resetView.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
         
        resetTitleLabel.centerXAnchor.constraint(equalTo: resetView.centerXAnchor).isActive = true
        resetTitleLabel.centerYAnchor.constraint(equalTo: resetView.centerYAnchor).isActive = true
        
        apiCallView.bottomAnchor.constraint(equalTo: resetView.topAnchor, constant:  -24.0).isActive = true
        apiCallView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40.0).isActive = true
        apiCallView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40.0).isActive = true
        apiCallView.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
         
        apiCallTitleLabel.centerXAnchor.constraint(equalTo: apiCallView.centerXAnchor).isActive = true
        apiCallTitleLabel.centerYAnchor.constraint(equalTo: apiCallView.centerYAnchor).isActive = true
    }
    
    override func bindViewModel() {
        viewModel.state.asDriver()
            .drive(onNext: {[weak self] (state) in
                
                switch state {
                case .idle:
                    self?.LoadingStop()
                    print("idle")
                    
                case .loading:
                    self?.LoadingStart()
                    print("idle")
                    
                case .done:
                    self?.LoadingStop()
                    print("done")
                    
                case .error:
                    self?.LoadingStop()
                    print("error")
                }
                
            })
            .disposed(by: disposeBag)
        
        //
        viewModel.totalPrice.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.error.bind {[weak self] (error) in
             
            self?.showTextAlert(title: "error", message: error)
        }
        .disposed(by: disposeBag)
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = false
    }
}







