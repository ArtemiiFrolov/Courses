//
//  City.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation

struct Coordinates: Codable {
    let coordinateX: Double
    let coordinateY: Double
}

enum Country: String, Codable {
    case Germany
    case Russia
}

enum State: String, Codable {
    case Bayern
    case Berlin
    case Kuybishev
    case Syberia
}

struct Location: Codable {
    let coordinates: Coordinates
    let state: State
    let country: Country
}

struct City: Codable {
    // Task 0: Each City you store should have a name and a description. The population should be saved as an Integer value and the area of the city using a floating point number that stores the area in km².
    let name: String
    let description: String
    let population: Int
    let area: Double
    let location: Location
    // Task 1: Each City should have a location associated with it that not only stores a coordinate, but also the country and state the City is located in. Location and Coordinate should be structures, Country and State should be enumerations.
}

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        if lhs.name == rhs.name,
            lhs.location.coordinates.coordinateX == rhs.location.coordinates.coordinateX,
            lhs.location.coordinates.coordinateY == rhs.location.coordinates.coordinateY {
            return true
        }
        // Task 2: City should conform to the Equatable protocol by comparing the name and the location coordinate.
        return false
    }
}
