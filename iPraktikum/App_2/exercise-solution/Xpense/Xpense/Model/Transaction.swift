//
//  Transaction.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import Foundation

class Transaction: Codable {
    // MARK: Stored Properties
    var id: Int
    var value: MonetaryUnit
    var description: String?
    var date: Date
    var accountId: Int
    
    
    // MARK: Initializer
    init(value: MonetaryUnit, description: String?, date: Date, accountId: Int) {
        self.id = DataHandler.nextTransactionID
        self.value = value
        self.description = description
        self.date = date
        self.accountId = accountId
    }
}


// MARK: - Extension: Equatable
extension Transaction: Equatable {
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - Extension: Hashable
extension Transaction: Hashable {
    var hashValue: Int {
        return id
    }
}
