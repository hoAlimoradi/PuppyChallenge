//
//  CalculateCostRepository.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
protocol CalculateCostRepository {
    
    func getServiceType() -> ServiceType
    
    func createCatService()  
    
    func createDogService()
     
    //MARK: -
    func setServiceValue(services: Services)
    
    func getCatService() -> Cat?
    
    //MARK: -
    func getDogService() -> Cat?
    
    
    //MARK: - api call
    func getAssignment() -> AssignmentDTO
    
    func assignment(assignmentDTO :AssignmentDTO) async throws -> CalculateCostDTO
}
