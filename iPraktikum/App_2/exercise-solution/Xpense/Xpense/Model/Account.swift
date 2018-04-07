//
//  Account.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import Foundation

class Account: Codable {
    // MARK: Stored Properties
    var id: Int
    var name: String
    var transactions: Set<Transaction> = []
    
    
    // MARK: Initializer
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    
    // MARK: Functions
    func balance(ofType currencyType: Currency = .euro) -> MonetaryUnit {
        var balance = 0.0
        for transaction in transactions {
            balance += transaction.value.amount
        }
        return MonetaryUnit(amount: balance, currency: currencyType)
    }
}


// MARK: - Extension: Equatable
extension Account: Equatable {
    static func ==(lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - Extension: Hashable
extension Account: Hashable {
    var hashValue: Int {
        return id
    }
}

