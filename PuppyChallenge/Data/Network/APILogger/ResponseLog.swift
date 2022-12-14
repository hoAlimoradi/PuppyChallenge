//
//  ResponseLog.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi on 8/6/1401 AP.
//
 
import Foundation

struct ResponseLog: URLRequestLoggableProtocol {
    
    let ENABLELOG = true
    
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?) {
        guard ENABLELOG else { return }
        print("\nšµ ========== Start logResponse ========== šµ")
        defer {
            print("š¦ ========== End logResponse ========== š¦\n")
        }
        guard let response = response else {
            print("==", "ā NULL Response ERROR: ā")
            return
        }
        if let url = response.url?.absoluteString {
            print("==", "Request URL: `\(url)`")
            print("==", "Response CallBack Status Code: `\(response.statusCode)`")
        } else {
            print("==", "ā LOG ERROR: ā")
            print("==", "Empty URL")
        }
        if let method = HTTPMethod {
            print("==", "Request HTTPMethod: `\(method)`")
        }
        if let error = error {
            print("==", "ā GOT URL REQUEST ERROR: ā")
            print(error)
        }
        guard let data = data else {
            print("==", "ā Empty Response ERROR: ā")
            return
        }
        print("==", "ā Response CallBack Data: ā")
        if let json = data.prettyPrintedJSONString {
            print(json)
        } else {
            let responseDataString: String = String(data: data, encoding: .utf8) ?? "BAD ENCODING"
            print(responseDataString)
        }
    }
}

extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? else { return nil }
            
        return prettyPrintedString
    }
}
