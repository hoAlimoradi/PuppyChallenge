//
//  CalculateCostDTO.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation
struct CalculateCostDTO: Codable {
    let total_price: Int
}
// MARK: - Mappers
extension CalculateCostDTO {
 
 /// Maps the Character DTO into a Character Model for UI use
 func toCalculateCost() -> CalculateCost {
     return CalculateCost(totalPrice: self.total_price)
  }
}
