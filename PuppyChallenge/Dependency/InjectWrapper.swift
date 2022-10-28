//
//  InjectWrapper.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi.
//
import Foundation

@propertyWrapper
struct Inject<T> {
  private(set) var wrappedValue: T
  
  init() {
    self.wrappedValue = Resolver.shared.resolve(T.self)
  }
  
  mutating func mockWrappedValue(with wrappedValue: T) {
    self.wrappedValue = wrappedValue
  }
}
