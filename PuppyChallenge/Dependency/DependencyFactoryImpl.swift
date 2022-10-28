//
//  DependencyFactoryImpl.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation

class DependencyFactoryImpl: DependencyFactory {
    
   func makeInitialCoordinator() -> ProjectCoordinator {
       let coordinator = ProjectCoordinator(factory: self)
       return coordinator
   }
   
   
   // MARK: - Splash
   func makeSplashViewController(coordinator: ProjectCoordinator) -> SplashViewController {
       return SplashViewController(coordinator: coordinator, viewModel: SplashViewModel())
   }
   
    func makeCalculateCostViewController(coordinator: ProjectCoordinator) -> CalculateCostViewController {
        return CalculateCostViewController(coordinator: coordinator, viewModel: CalculateCostViewModel())
    }
    
    func makeChooseServicesViewModel(coordinator: ProjectCoordinator) -> ChooseServicesViewController {
       return ChooseServicesViewController(coordinator: coordinator, viewModel: ChooseServicesViewModel())
    }
    
    func makeMainCategoryViewController(coordinator: ProjectCoordinator) -> MainCategoryViewController {
        return MainCategoryViewController(coordinator: coordinator, viewModel: MainCategoryViewModel())
    }
    
    
    
}
