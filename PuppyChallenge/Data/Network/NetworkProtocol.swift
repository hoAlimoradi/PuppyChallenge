//
//  Networking.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//

import Foundation

protocol NetworkProtocol {
  func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
  func request(_ endpoint: Endpoint) async throws
}


/// Custom error returned from the requests
enum NetworkError: Error, LocalizedError {
  case invalidURL
  case invalidStatusCode(statusCode: Int)
  case dataTaskError(String)
  case corruptData
  case decodingError(String)
  case unauthorised
  case notFound
  case internalServerError
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return NSLocalizedString("THe endpoint URL is invalid", comment: "")
    case .invalidStatusCode(let statusCode):
      return NSLocalizedString("The API failed to issue a valid response with status code \(statusCode)", comment: "")
    case .dataTaskError(let string):
      return string
    case .corruptData:
      return NSLocalizedString("The data provided appears to be corrupt", comment: "")
    case .decodingError(let string):
      return string
    case .unauthorised:
      return NSLocalizedString("Invalid credentials", comment: "")
    case .notFound:
      return NSLocalizedString("404 Not Found", comment: "")
    case .internalServerError:
      return NSLocalizedString("Internal Server Error", comment: "")
    }
  }
}
