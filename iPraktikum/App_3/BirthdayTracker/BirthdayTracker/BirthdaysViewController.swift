//
//  BirthdaysViewController.swift
//  BirthdayTracker
//
//  Created by Paul Schmiedmayer on 10/10/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class BirthdaysViewController: UIViewController {
    
    // HINT: Use the UIAlertController+Extension to show AlertController!
    
    
    @IBOutlet weak var tableView: UITableView!
    // Task 2: Make the BirthdaysViewController conform to your protocol defined in Task 1
    
    // Task 4: Implement editing a birthday:
    // Use the same screen for editing as you use for adding a new birthday. Make sure to adapt the title of the scene accordingly!
    // Editing a birthday should be possible by tapping the row of the table view
    // If the user is editing a birthday, pass the data forward to pre-populate the text field and the date picker
    // Don’t forget to distinguish between adding and editing a birthday when saving it! Throw the appropriate BirthdayError where applicable.

    
    private var birthdays: [String: Date] = [:]
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        loadMockData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBirthdaySegue" {
            if let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AddBirthdayViewController {
                viewController.editBirthday = birthdays.sorted(by: {$0.value < $1.value })[(tableView.indexPathForSelectedRow?.row)!]
                viewController.delegate = self
                
            }
        } else {
            if let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AddBirthdayViewController {
                viewController.delegate = self
            }
        }
    }
    
    @IBAction func prepareFor(unwindSegue segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
}

extension BirthdaysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCell", for: indexPath)
        let birthday = birthdays.sorted(by: {$0.value < $1.value })[indexPath.row]
        let name = birthday.key
        let date = dateFormatter.string(from: birthday.value)
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = date
        return cell
    }
}
// Birthdate handeling
extension BirthdaysViewController {
    private func loadMockData() {
        do {
            
            try addBirthday(name: "Dora Dzvonyar", birthday: dateFormatter.date(from: "11.01.1990")!)
            /*
            try addBirthday(name: "Dominic Henze", birthday: "18.02.1991")
            try addBirthday(name: "Lukas Alperowitz", birthday: "10.08.1985")
            try addBirthday(name: "Paul Schmiedmayer", birthday: "29.12.1995")
            try addBirthday(name: "Jan Ole Johanssen", birthday: "21.09.1991")
            try addBirthday(name: "Dimitri Tyan", birthday: "13.03.1997")
            try addBirthday(name: "Julian Sauerhammer", birthday: "05.02.1998")
            try addBirthday(name: "Florian Bodlee", birthday: "10.10.1996")
            try addBirthday(name: "Victor Prüfer", birthday: "13.01.1998")
            try addBirthday(name: "Sebastian Borchers", birthday: "26.11.1994")
            try addBirthday(name: "Finn Gaida", birthday: "01.01.1970")
            try addBirthday(name: "Palle Klewitz", birthday: "13.05.1997")
            try addBirthday(name: "Sebastian Nikles", birthday: "16.08.1996")
            try addBirthday(name: "Lars Schwegmann", birthday: "12.01.1997")*/
        } catch BirthdayError.wrongDateFormat {
            showDateFormatError()
        } catch BirthdayError.entryAlreadyExists(let name) {
            showEntryAlreadyExistsError(name: name)
        } catch let error {
            print(error)
        }
    }
    
    private func showDateFormatError() {
        showAlert(withTitle: "Birthday in wrong format",
                  message: "Please provide the birthday in the format dd.mm.yyyy!")
    }
    
    private func showEntryAlreadyExistsError(name: String) {
        showAlert(withTitle: "Birthday already exists",
                  message: "An entry for \(name) already exists! Edit it instead.")
    }
    
    private func showAlert(withTitle title: String, message: String) {
        UIAlertController.presentError(withTitle: title, message: message, on: self)
    }
}

extension BirthdaysViewController: Birthday {
    func addBirthday(name: String, birthday: Date) throws {
        if birthdays[name] != nil {
            throw BirthdayError.entryAlreadyExists(name: name)
        }
        birthdays[name] = birthday
    }
    func editBirthday(name: String, birthday: Date) {
        birthdays[name] = birthday
    }
}
