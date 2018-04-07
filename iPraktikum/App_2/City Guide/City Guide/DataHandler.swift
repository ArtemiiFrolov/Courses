//
//  DataHandler.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation

class DataHandler {
    private struct Constants {
        static let fileName = "Cities.json"
        static var localStorageURL: URL {
            let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
            return DocumentsDirectory.appendingPathComponent(Constants.fileName)
        }
    }
    
    // Task 3: A class called DataHandler should be used to store multiple cities to and read and write them to JSON.
    
    static var cities: [City] = []
    
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
