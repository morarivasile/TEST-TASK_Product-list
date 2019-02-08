//
//  AWSClient.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

class AWSClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }

    func getData<T: Decodable>(with endpoint: AWSFiles, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let request = endpoint.request else {
            assertionFailure("Failed to create URL Request")
            return
        }
        fetch(with: request, decode: { json -> [T]? in
            guard let banners = json as? [T] else { return  nil }
            return banners
        }, completion: completion)
    }
}
