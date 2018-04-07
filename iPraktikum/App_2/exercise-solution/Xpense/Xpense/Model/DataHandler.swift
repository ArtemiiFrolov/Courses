//
//  DataHandler.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import Foundation

class DataHandler {
	// MARK: Constants
    private struct Constants {
        static let fileName = "Accounts.json"
        static var localStorageURL: URL {
            let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
            return DocumentsDirectory.appendingPathComponent(Constants.fileName)
        }
    }
    
    
    // MARK: Static Stored Properties
    static var accounts: Set<Account> = []
    
    
    // MARK: Static Computed Properties
    static var nextTransactionID: Int {
        var largestId = 0
        for account in accounts {
            for transaction in account.transactions where transaction.id > largestId {
                largestId = transaction.id
            }
        }
        return largestId + 1
    }
    
    static func loadFromJSON() {
        do {
            let fileWrapper = try FileWrapper(url: Constants.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            accounts = try JSONDecoder().decode(Set<Account>.self, from: data)
            print("Decoded \(accounts.count) accounts.")
        } catch _ {
            print("Could not load Account, DataHandler uses empty account")
        }
    }
    
    static func saveToJSON() {
        do {
            let data = try JSONEncoder().encode(accounts)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: Constants.localStorageURL, options: FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
            print("Saved account.")
        } catch _ {
            print("Could not save Account")
        }
    }
}
