//
//  UIViewController+Extension.swift
//  Morari_Vasile_Test_Task
//
//  Created by Vasile Morari on 12/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

extension UIViewController {
    func addKeyboardDismissGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
