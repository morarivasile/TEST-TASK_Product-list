//
//  Float+Extension.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

extension Float {
    func stringValue(_ digitsAfter: Int = 2) -> String {
        if truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.f", self)
        } else {
            return String(format: "%.\(digitsAfter)f", self)
        }
    }
}
