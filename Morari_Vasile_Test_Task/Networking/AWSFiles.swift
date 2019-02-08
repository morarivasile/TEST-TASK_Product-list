//
//  AWSFiles.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/4/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

enum AWSFiles {
    case banners
    case offers
}

extension AWSFiles: Endpoint {
    var host: String {
        return "https://s3.eu-central-1.amazonaws.com"
    }
    
    var basePath: String {
        return "/sl.files"
    }
    
    var path: String {
        switch self {
        case .banners: return "/banners.json"
        case .offers: return "/offers.json"
        }
    }
}
