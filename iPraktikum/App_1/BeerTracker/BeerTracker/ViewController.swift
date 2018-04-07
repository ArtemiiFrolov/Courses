//
//  ViewController.swift
//  BeerTracker
//
//  Created by ios on 06/04/2018.
//  Copyright © 2018 TUM LS1. All rights reserved.
//

import UIKit
// MARK: -ViewController: UIViewController
class ViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var beerCounterField: UITextField!
    @IBOutlet weak var beerCounterText: UILabel!
    
    //MARK: Stored Properties
    var beerCounter: Int? {
        if let beerCounterString = beerCounterText.text,
            let beerCounter = Int(beerCounterString) {
            return beerCounter
        }
        return nil
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        beerCounterField.delegate = self
    }
    
    // MARK: resetViewController
    private func resetViewController() {
        beerCounterField.text = ""
    }
    
    // MARK: didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: saveBeer
    @IBAction func saveBeer() {
        if let beerCountString = beerCounterField.text,
            let beerCount = Int(beerCountString),
            let beerCounter = beerCounter {
            if beerCount > 0 {
                beerCounterText.text = String(beerCount + beerCounter)
                showedAlert(amount: beerCount, flagPositive: true)
            }
            else {
                showedAlert(amount: beerCount, flagPositive: false)
            }
            resetViewController()
        }
    }
    
    // MARK: private functions
    private func showedAlert(amount: Int, flagPositive: Bool) {
        var alertController = UIAlertController(title: "Prost!", message: "You drink \(amount) of beer", preferredStyle: UIAlertControllerStyle.alert)
        if !flagPositive {
           alertController = UIAlertController(title: "WTF", message: "You can't drink \(amount) of beer", preferredStyle: UIAlertControllerStyle.alert)
    }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: ViewController: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveBeer()
        return true
    }
}

