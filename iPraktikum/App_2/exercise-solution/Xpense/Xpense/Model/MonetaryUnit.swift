//
//  MonetaryUnit.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import Foundation

// MARK: - Currency
enum Currency: String, Codable {
    case euro = "€"
    case dollar = "$"
    
    var factorToDollar: Double {
        switch self {
            case .dollar:
                return 1.0
            case .euro:
                return 1.143
        }
    }
}

// MARK: - MonetaryUnit
struct MonetaryUnit: Codable {
	// MARK: Stored Properties
    var amount: Double
    let currency: Currency
    
    
    // MARK: Initializer
    init(amount: Double, currency: Currency = .euro) {
        self.amount = amount
        self.currency = currency
    }
    
    
	// MARK: Functions
    func translate(toType type: Currency) -> MonetaryUnit {
        return MonetaryUnit(amount: self.amount * self.currency.factorToDollar / type.factorToDollar,
                            currency: type)
    }
}


// MARK: - Extension: CustomStringConvertible
extension MonetaryUnit: CustomStringConvertible {
    var description: String {
        return String(format: "%.2f", amount) + currency.rawValue
    }
}
