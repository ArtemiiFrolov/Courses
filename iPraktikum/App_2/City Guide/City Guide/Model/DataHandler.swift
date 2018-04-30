//
//  DataHandler.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation
// MARK: - DataHandler
class DataHandler {
    // MARK: Constants
    private struct Constants {
        static let fileName = "Cities.json"
        static var localStorageURL: URL {
            let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
            return DocumentsDirectory.appendingPathComponent(Constants.fileName)
        }
    }
    
    // MARK: Stored property
    static var cities: [City] = []
    
    // MARK: Type functions
    static func loadFromJSON() {
        do {
            let fileWrapper = try FileWrapper(url: Constants.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            cities = try JSONDecoder().decode(Array<City>.self, from: data)
        }
        catch _ {
            print("Could not load Cities, DataHandler uses empty cities")
        }
    }
    
    static func saveToJSON() {
        do {
            let data = try JSONEncoder().encode(cities)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: Constants.localStorageURL,                        options:FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
            print("Saved account.")
        } catch _ {
            print("Could not save Account")
        }
    }
}
