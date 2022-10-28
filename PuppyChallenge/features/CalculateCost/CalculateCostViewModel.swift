//
//  CalculateCostViewModel.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
import RxSwift
import RxCocoa

class CalculateCostViewModel {
   
   @Inject private var repository: CalculateCostRepository
   
   let state = BehaviorRelay(value: CalculateCostState.idle)
   
   let error = PublishRelay<String>()
    
   let totalPrice = PublishRelay<String>()
 
   private let disposeBag = DisposeBag()
   
    
   //MARK: -- methods
   func assignment() async {
      
       self.totalPrice.accept("")
       guard let cat = repository.getCatService() else {
           self.state.accept(.error)
           self.error.accept("please create a cat service")
           return
       }
       
       
       guard let dog = repository.getDogService() else {
           self.state.accept(.error)
           self.error.accept("please create a dog service")
           return
       }
       state.accept(.loading)
       let assignment = AssignmentDTO(dog: dog, cat: cat)
        do {
            let response = try await repository.assignment(assignmentDTO: assignment)
            let calculateCost = "calculateCost.totalPrice: \(response.toCalculateCost())"
            
            print("assignment response: \(calculateCost)")
            self.totalPrice.accept(calculateCost)
            self.state.accept(.done)
        } catch {
            print("assignment  : \(error.localizedDescription)")
            self.state.accept(.error)
            self.error.accept(error.localizedDescription)
        }
    }
 
}

// MARK: - Convenience Init for testing
extension CalculateCostViewModel {
   convenience init(repository: CalculateCostRepository) {
       self.init()
       self._repository.mockWrappedValue(with: repository)
   }
}
extension CalculateCostViewModel {
   enum CalculateCostState {
       case idle
       case loading
       case done
       case error
   }
}


/*
 
API: https://assignment.shly.me
Method: Post
JSON Raw Body:
{
  "dog": {
    "services": {
      "grooming": true,
      "hotel": {
        "nights": 2
      }
    }
  },
  "cat": {
    "services": {
      "grooming": false,
      "hotel": {
          "nights": 3
      }
    }
  }
}

*/
