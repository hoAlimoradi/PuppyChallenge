//
//  SplashRepositoryImpl.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//

import Foundation

class SplashRepositoryImpl: SplashRepository {
    
    func getVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("1.0"))
    }
   
}
