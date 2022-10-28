//
//  CalculateCostRepositoryImpl.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//
import Foundation

final class CalculateCostRepositoryImpl: CalculateCostRepository {
     
    @Inject private var network: NetworkProtocol
    
    private var serviceType: ServiceType = .CAT
    
    private var cat: Cat? = nil
    
    private var dog: Cat? = nil
    
    func getServiceType() -> ServiceType {
        return serviceType
    }
    
    func createCatService() {
        serviceType = .CAT
    }
    
    func createDogService() {
        serviceType = .DOG
    }
    
    func setServiceValue(services: Services) {
        switch serviceType {
        case .DOG:
            dog = Cat(services: services)
        case .CAT:
            cat = Cat(services: services)
        }
    }
    
    func getCatService() -> Cat? {
        return cat
    }
     
    func getDogService() -> Cat? {
        return dog
    }
    
    func getAssignment() -> AssignmentDTO {
        var cat = Cat(services: Services(grooming: true, hotel: Hotel(nights: 2)))
        let dog = Cat(services: Services(grooming: false, hotel: Hotel(nights: 3)))
        let assignment = AssignmentDTO(dog: dog, cat: cat)
        return assignment
    }
    
    func assignment(assignmentDTO :AssignmentDTO) async throws -> CalculateCostDTO {
        let data = try? JSONEncoder().encode(assignmentDTO)
        //let data = try? JSONSerialization.data(withJSONObject: json)
        let response = try await network.request(
          .assignment(data: data),
          type: CalculateCostDTO.self
        )
        print("response: \(response)")
        return response
    }
  
}
 
// MARK: - Convenience Init for testing
extension CalculateCostRepositoryImpl {
  convenience init(network: NetworkProtocol) {
    self.init()
    self._network.mockWrappedValue(with: network)
  }
}

enum ServiceType {
    case DOG
    case CAT
}

