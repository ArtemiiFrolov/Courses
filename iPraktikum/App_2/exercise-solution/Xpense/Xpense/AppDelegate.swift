//
//  AppDelegate.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        DataHandler.loadFromJSON()
        if DataHandler.accounts.isEmpty {
            DataHandler.accounts.insert(Account(id: 1, name: "Wallet"))
        }
        
        return true
    }
}

