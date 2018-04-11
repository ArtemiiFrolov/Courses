//
//  UIAlertController+Extension.swift
//  BirthdayTracker
//
//  Created by Paul Schmiedmayer on 10/10/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    // Use this static method to present an UIAlert consisting of a title and message on a specified UIViewController
    static func presentError(withTitle title: String, message: String, on viewController: UIViewController) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true)
    }
}
