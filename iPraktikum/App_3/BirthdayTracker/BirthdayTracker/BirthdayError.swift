//
//  BirthdayError.swift
//  BirthdayTracker
//
//  Created by Paul Schmiedmayer on 10/10/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation

enum BirthdayError: Error {
    case wrongDateFormat
    case entryAlreadyExists(name: String)
}
