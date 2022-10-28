//
//  Endpoint.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//
import Foundation

// MARK: - Endpoints
/// endpoints available for our application in the backend
enum Endpoint {
    case assignment(data: Data?)
}

// MARK: - Host and Paths
extension Endpoint {
  var host: String {
    return "assignment.shly.me"
  }
  
  var path: String {
    switch self {
    case .assignment(let data):
      return "/"
     
    }
  }
}

// MARK: - MethodType and URL Building
extension Endpoint {
  
  enum MethodType: Equatable {
    case GET
    case POST(data: Data?)
    case DELETE
  }
  
  var methodType: MethodType {
    switch self {
    case .assignment(let data):
        return .POST(data: data)
    }
  }
  
  var url: URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    urlComponents.path = path
    
    return urlComponents.url
  }
}


