//
//  SplashRepository.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation
protocol SplashRepository {
    func getVersion(completion: @escaping (Result<String, Error>) -> Void) 
}
