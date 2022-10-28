//
//  URLRequestLoggableProtocol.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi  .
//
 
import Foundation

protocol URLRequestLoggableProtocol {
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}
