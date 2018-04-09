//
//  checkBool.swift
//  City Guide
//
//  Created by ios on 09/04/2018.
//  Copyright © 2018 TUM LS1. All rights reserved.
//

import Foundation
// MARK: - checkBool
class checkBool {
    var boolYText: Bool = false
    var boolXText: Bool = false
    var boolStateText: Bool = false
    var boolAreaText: Bool = false
    var boolPopulationText: Bool = false
    var boolNameText: Bool = false
    
    func checkIfDone() -> Bool {
        return boolXText && boolYText && boolAreaText && boolStateText && boolPopulationText && boolNameText
    }
}
