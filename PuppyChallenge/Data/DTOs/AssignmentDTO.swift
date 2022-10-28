//
//  AssignmentDTO.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation

struct AssignmentDTO: Codable {
    var dog, cat: Cat?
}

// MARK: - Cat
struct Cat: Codable {
    var services: Services
}

// MARK: - Services
struct Services: Codable {
    var grooming: Bool
    var hotel: Hotel
}

// MARK: - Hotel
struct Hotel: Codable {
    var nights: Int
}
