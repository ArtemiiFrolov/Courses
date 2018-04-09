//
//  AddCityViewController.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

// MARK: - AddCityViewController: UIViewController
class AddCityViewController: UIViewController {
    
    // MARK: type constants
   let check = checkBool()
    // Task 5: To add a new city the AddCityViewController should be used, that is already connected with the other elements of the UI using Bar Button Items. Create a UI using labels, text fields (and slider, segmented controls or picker if you feel comfortable with it).
    // MARK: IBOutlets
    @IBOutlet weak var countrySegment: UISegmentedControl!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var yText: UITextField!
    @IBOutlet weak var xText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var areaText: UITextField!
    @IBOutlet weak var populationText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    // Task 6: The user should enter all the information that is stored in an instance of City on this screen and you should validate his input so that only correct data is entered.
    // A state should be located in the country that is entered
    // When a number is expected only a number should be accepted and when a string is accepted only a string should be stored in the model

    // MARK: Overwritten Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: @IBActions
    @IBAction func nameChanged(_ sender: Any) {
        if let name = nameText.text,
            name != "" {
            nameText.redBorder(false)
            check.boolNameText = true
        } else {
            nameText.redBorder(true)
            check.boolNameText = false
        }
    }
    
    @IBAction func yChanged(_ sender: Any) {
        if checkForNumber(textField: yText, type: Double.self) {
            yText.redBorder(false)
            check.boolYText = true
        } else {
            yText.redBorder(true)
            check.boolYText = false
        }
    }
    
    @IBAction func xChanged(_ sender: Any) {
        if checkForNumber(textField: xText, type: Double.self) {
            xText.redBorder(false)
            check.boolXText = true
        } else {
            xText.redBorder(true)
            check.boolXText = false
        }
    }
    
    @IBAction func populationChanged(_ sender: Any) {
        if checkForNumber(textField: populationText, type: Int.self) {
            populationText.redBorder(false)
            check.boolPopulationText = true
        } else {
            populationText.redBorder(true)
            check.boolPopulationText = false
        }
    }
    
    @IBAction func areaChanged(_ sender: Any) {
        if checkForNumber(textField: areaText, type: Double.self) {
            areaText.redBorder(false)
            check.boolAreaText = true
        } else {
            areaText.redBorder(true)
            check.boolAreaText = false
        }
    }
    
    @IBAction func stateChanged(_ sender: Any) {
        guard let text = stateText.text else {
            return
        }
        let state =  State(rawValue:text)
        if let state = state,
        let country = countrySegment.titleForSegment(at: countrySegment.selectedSegmentIndex),
        state.checkCountry() == country
       {
            stateText.redBorder(false)
            check.boolStateText = true
       }
        else {
            stateText.redBorder(true)
            check.boolStateText = false
        }
    }
    // Task 7: If a user has entered wrong information when he pressed the save button, inform him with a UIAlertView describing the wrong input.
    
    // Task 8: You only need to offer the possibility to validate 3 countries with 2 states each in your validation logic. Use computed properties and extensions when implementing the validation. Unknown countries, states and parties can be denied. (Normally not a good practice but acceptable for this example 🤓)

    // Connection your IBOutlets here
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // Create a new instace of City here and save it using the DataHandler
        if check.checkIfDone() {
            let location = Location (coordinates: Coordinates(coordinateX: Double(xText.text!)!, coordinateY: Double(yText.text!)!), state: State(rawValue: stateText.text!)!, country: Country(rawValue: countrySegment.titleForSegment(at: countrySegment.selectedSegmentIndex)!)!)
            let city = City(name: nameText.text!, description: descriptionText.text, population: Int(populationText.text!)!, area: Double(areaText.text!)!, location: location)
            DataHandler.cities.append(city)
            DataHandler.saveToJSON()
        } else {
            showedAlert()
        }
        
        self.performSegue(withIdentifier: "addCityUnwindSegue", sender: self)
    }
    
    // MARK: Private Functions
    private func showedAlert() {
        let alertController = UIAlertController(title: "Wron values", message: "Check validity of your data", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Number:Comparable
protocol Number:Comparable{
    init?(_ text: String)
    init (_ value: Int)
}

// MARK: extensions
extension Int: Number {}
extension Double: Number {}
extension Float: Number {}
extension AddCityViewController {
    private func checkForNumber <T:Number> (textField: UITextField, type: T.Type) -> Bool {
        if let numberString = textField.text,
            let number = T(numberString),
            number > T(0) {
            return true
        } else {
            return false
        }
    }
}
