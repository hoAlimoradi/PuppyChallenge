//
//  DependencyFactory.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//
import Foundation

protocol DependencyFactory {
    
    func makeSplashViewController(coordinator: ProjectCoordinator) -> SplashViewController
     
    func makeMainCategoryViewController(coordinator: ProjectCoordinator) -> MainCategoryViewController
    
    func makeCalculateCostViewController(coordinator: ProjectCoordinator) -> CalculateCostViewController
    
    func makeChooseServicesViewModel(coordinator: ProjectCoordinator) -> ChooseServicesViewController
    
}

