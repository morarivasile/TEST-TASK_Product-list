//
//  APIError.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed(cause: String)
    case jsonConversionFailure
    case invalidData
    case jsonParsingFailure
    case responseUnsuccessful(String)
    
    var description: String {
        switch self {
        case .requestFailed(let desc): return desc
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
