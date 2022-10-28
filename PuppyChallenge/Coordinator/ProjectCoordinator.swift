//
//  ProjectCoordinator.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//
import UIKit
import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}

protocol RootCoordinator: class {
    func start(_ navigationController: UINavigationController)
}


class ProjectCoordinator: AbstractCoordinator, RootCoordinator {
    
    private(set) var childCoordinators: [AbstractCoordinator] = [] 
    weak var navigationController: UINavigationController?
    
    private var factory: DependencyFactory
    
    init(factory: DependencyFactory) {
        self.factory = factory
    }
    
    func addChildCoordinator(_ coordinator: AbstractCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    /// Start the coordinator, intiializing dependencies
    func start(_ navigationController: UINavigationController) {
        DispatchQueue.main.async {
            let vc = self.factory.makeSplashViewController(coordinator: self)
            self.navigationController = navigationController
            self.navigationController?.pushViewController(vc, animated: true)
             
        }
    }
    
    func startFromSplashToMainCategoryView() {
        DispatchQueue.main.async {
            let vc = self.factory.makeMainCategoryViewController(coordinator: self)
            self.navigationController?.pushViewController(vc, animated: true)
             
        }
    }
    
    func startFromMainToChoosService() {
        DispatchQueue.main.async {
            let vc = self.factory.makeChooseServicesViewModel(coordinator: self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func startFromChoosServiceToCalculateCost() {
        DispatchQueue.main.async {
            let vc = self.factory.makeCalculateCostViewController(coordinator: self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
