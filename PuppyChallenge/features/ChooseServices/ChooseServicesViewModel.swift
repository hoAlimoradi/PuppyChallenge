//
//  ChooseServicesViewModel.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
import RxSwift
import RxCocoa

class ChooseServicesViewModel {
   
   @Inject private var repository: CalculateCostRepository
   
   let state = BehaviorRelay(value: ChooseServicesState.idle)
    
   let nightsObserver = BehaviorRelay(value: "1")
    
   let error = PublishRelay<String>()
   
   private let disposeBag = DisposeBag()
    
   private var service = Services(grooming: false, hotel: Hotel(nights: 0))
    //MARK: -- methods
    
    func setGrooming() {
        service.grooming = true
        repository.setServiceValue(services: service)
        nightsObserver.accept(String(service.hotel.nights))
    }
    
    func setHotel(nights: String?) {
        guard let nights = nights, let nightsValue = Int(nights)  else {
            self.state.accept(.error)
            self.error.accept("please insert nights value in editText")
            return
        } 
        service.grooming = false
        service.hotel.nights = nightsValue
        repository.setServiceValue(services: service)        
        nightsObserver.accept(String(service.hotel.nights))
        
    }
    
    func goNext() {
        if service.grooming {
            self.state.accept(.next)
        } else {
            if( service.hotel.nights > 0 ) {
                self.state.accept(.next)
            } else {
                self.state.accept(.error)
                self.error.accept("please insert nights value in editText")
            }
        }
    }
    
}

// MARK: - Convenience Init for testing
extension ChooseServicesViewModel {
   convenience init(repository: CalculateCostRepository) {
       self.init()
       self._repository.mockWrappedValue(with: repository)
   }
}
extension ChooseServicesViewModel {
   enum ChooseServicesState {
       case idle
       case next
       case error
   }
}

