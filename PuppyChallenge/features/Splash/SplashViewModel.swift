//
//  SplashViewModel.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel {
    
    @Inject private var repository: SplashRepository
    
    let state = BehaviorRelay(value: SplashState.idle)
    
    let error = PublishRelay<String>()
    
    let disposeBag = DisposeBag()
    
    //MARK: -- methods
    func getVersion()  {
        
        state.accept(.loading)
        
        repository.getVersion(completion: { vertion in
            switch vertion {
            case .success(let data):
                self.state.accept(.done)
                print(data)
            case .failure(let error):
                self.state.accept(.error)
                self.error.accept(error.localizedDescription) 
            }
        })
    }
    
    
}

// MARK: - Convenience Init for testing
extension SplashViewModel {
    convenience init(repository: SplashRepository) {
        self.init()
        self._repository.mockWrappedValue(with: repository)
    }
}
extension SplashViewModel {
    enum SplashState {
        case idle
        case loading
        case done
        case error
    }
}
