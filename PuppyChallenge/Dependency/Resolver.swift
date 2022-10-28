//
//  Resolver.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//
 
import Foundation
import Swinject

final class Resolver {
    static let shared = Resolver()
    
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

fileprivate func buildContainer() -> Container {
    let container = Container()
    
    container.register(NetworkProtocol.self) { _ in
        return NetworkImpl(session: .shared)
    }
    .inObjectScope(.container)
    
    
    container.register(SplashRepository.self) { _ in
        return SplashRepositoryImpl()
    }
    .inObjectScope(.container)
     
    
    container.register(CalculateCostRepository.self) { _ in
        return CalculateCostRepositoryImpl()
    }
    .inObjectScope(.container)
    
    
    return container
}


