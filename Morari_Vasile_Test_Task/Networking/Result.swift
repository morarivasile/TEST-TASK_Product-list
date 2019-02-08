//
//  Result.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

protocol Endpoint {
    var host: String { get }
    var basePath: String { get }
    var path: String { get }
}

extension Endpoint {
    var baseURLComponents: URLComponents? {
        guard var components = URLComponents(string: host) else {
            assertionFailure("Invalid HOST string: \(host)")
            return nil
        }
        components.path = basePath
        return components
    }
    
    var request: URLRequest? {
        guard let url = baseURLComponents?.url?.appendingPathComponent(path) else {
            assertionFailure("Unable to get URL from provided base URL components!")
            return nil
        }
        return URLRequest(url: url)
    }
}
