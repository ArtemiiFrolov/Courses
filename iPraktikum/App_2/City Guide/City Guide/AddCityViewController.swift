//
//  AddCityViewController.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    // Task 5: To add a new city the AddCityViewController should be used, that is already connected with the other elements of the UI using Bar Button Items. Create a UI using labels, text fields (and slider, segmented controls or picker if you feel comfortable with it).
    
    @IBOutlet weak var yText: UITextField!
    @IBOutlet weak var xText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var areaText: UITextField!
    @IBOutlet weak var populationText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    // Task 6: The user should enter all the information that is stored in an instance of City on this screen and you should validate his input so that only correct data is entered.
    // A state should be located in the country that is entered
    // When a number is expected only a number should be accepted and when a string is accepted only a string should be stored in the model
    
    // Task 7: If a user has entered wrong information when he pressed the save button, inform him with a UIAlertView describing the wrong input.
    
    // Task 8: You only need to offer the possibility to validate 3 countries with 2 states each in your validation logic. Use computed properties and extensions when implementing the validation. Unknown countries, states and parties can be denied. (Normally not a good practice but acceptable for this example 🤓)

    // Connection your IBOutlets here
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // Create a new instace of City here and save it using the DataHandler
        
        self.performSegue(withIdentifier: "addCityUnwindSegue", sender: self)
    }
}
