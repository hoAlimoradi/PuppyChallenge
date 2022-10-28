//
//  MainCategoryViewModel.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//
 
import Foundation
import RxSwift
import RxCocoa

class MainCategoryViewModel {
    
    @Inject private var repository: CalculateCostRepository
    
    let serviceType = BehaviorRelay(value: ServiceType.CAT)
    
    let state = BehaviorRelay(value: MainCategoryState.idle)
    
    let error = PublishRelay<String>()
    
    private let disposeBag = DisposeBag()
    //MARK: -- methods
    
    func getServiceType() {
        serviceType.accept(repository.getServiceType())
    }
    
    func createCatService() {
        repository.createCatService()
    }
    
    func createDogService() {
        repository.createDogService()
    }
   
}

// MARK: - Convenience Init for testing
extension MainCategoryViewModel {
    convenience init(repository: CalculateCostRepository) {
        self.init()
        self._repository.mockWrappedValue(with: repository)
    }
}
extension MainCategoryViewModel {
    enum MainCategoryState {
        case idle
        case error
    }
}
