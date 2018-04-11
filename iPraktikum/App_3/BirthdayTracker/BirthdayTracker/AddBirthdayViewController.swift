//
//  AddBirthdayViewController.swift
//  BirthdayTracker
//
//  Created by Paul Schmiedmayer on 10/10/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    var editBirthday: (String, Date)?
    var delegate: Birthday?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Task 1: Implement adding a new birthday using delegation:
        // Define your own protocol in AddBirthdayViewController and make BirthdaysViewController conform to it. The protocol should contain a method that takes a String and a Date instance and the implementation in the  BirthdaysViewController should add them to the birthdays dictionary.
        // Call the method of the delegate when saving a birthday. Don’t forget to set the delegate beforehand!
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Saving a birthday is not implemented yet")
        
        self.performSegue(withIdentifier: "addBirthdayUnwindSegue", sender: self)
    }
}

extension AddBirthdayViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

protocol Birthday {
    func addBirthday (name: String, birthday: Date) throws
}
