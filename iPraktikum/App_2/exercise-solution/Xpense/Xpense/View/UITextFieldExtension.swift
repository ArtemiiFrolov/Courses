//
//  UITextFieldExtension.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/7/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import UIKit

extension UITextField {
    func redBorder(_ markRed: Bool) {
        self.layer.cornerRadius = 1.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        if markRed {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
