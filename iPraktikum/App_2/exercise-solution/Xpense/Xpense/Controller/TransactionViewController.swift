//
//  TransactionViewController.swift
//  Xpense
//
//  Created by Paul Schmiedmayer on 7/1/17.
//  Copyright © 2017 LS1 TUM. All rights reserved.
//

import UIKit

// MARK: - TransactionViewController
class TransactionViewController: UIViewController {
	// MARK: Constants
    private struct Constants {
        static let saveButtonDisabledAlpha = CGFloat(0.5)
        static let hideSaveTransactionButtonLevel = CGFloat(230)
        static let hidetransactionDatePickerLevel = hideSaveTransactionButtonLevel + 150
    }
    
	// MARK: IBOutlets
    @IBOutlet private weak var transactionDescriptionField: UITextField!
    @IBOutlet private weak var transactionAmountField: UITextField!
    @IBOutlet private weak var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var transactionDatePicker: UIDatePicker!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var saveTransactionButton: UIButton!
    
	
    // MARK: Overwritten Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionDescriptionField.delegate = self
        transactionAmountField.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        
        if let account = DataHandler.accounts.first {
            balanceLabel.text = String(describing: account.balance())
        }
        
        resetViewController()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
	// MARK: IBActions
    @IBAction private func saveTransaction() {
        guard let transactionAmountString = transactionAmountField.text,
              let transactionDescriptionString = transactionDescriptionField.text,
              let transactionAmount = Double(transactionAmountString),
              let account = DataHandler.accounts.first else {
            return
        }
        
        let amount = transactionTypeSegmentedControl.selectedSegmentIndex == 0 ? -transactionAmount : transactionAmount
        let description = transactionDescriptionString == "" ? nil : transactionDescriptionString

        let newTransaction = Transaction(value: MonetaryUnit(amount: amount),
                                         description: description,
                                         date: transactionDatePicker.date,
                                         accountId: account.id)
        account.transactions.insert(newTransaction)
        
        balanceLabel.text = String(describing: account.balance())
        
        transactionAmountField.resignFirstResponder()
        transactionDescriptionField.resignFirstResponder()
        showSavedAlert()
        resetViewController()
        
        DataHandler.saveToJSON()
    }
    
    @IBAction private func refreshValidationViews() {
        guard let text = transactionAmountField.text else {
            return
        }
        let validTransactionAmount = Double(text) != nil || text == ""
        transactionAmountField.redBorder(!validTransactionAmount)
        
        let enableSave = validTransactionAmount && text != ""
        saveTransactionButton.isEnabled = enableSave
        saveTransactionButton.alpha = enableSave ? 1.0 : Constants.saveButtonDisabledAlpha
    }
    
    
    // MARK: Functions
    private func resetViewController() {
        transactionDescriptionField.text = ""
        transactionAmountField.text = ""
        
        refreshValidationViews()
    }
    
    private func showSavedAlert() {
        let alertController = UIAlertController(title: "Saved Transaction", message: "Successfully added the transaction to your account", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
}


// MARK: - Extension: UITextFieldDelegate
extension TransactionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if saveTransactionButton.isEnabled {
            saveTransaction()
        }
        return true
    }
}


// MARK: - Extension: React to Keyboard
extension TransactionViewController {
    private func keyboardParameterFrom(notification: NSNotification) -> (keyboardHeight: CGFloat, duration: Double, animatorOption: UIViewAnimationOptions)? {
        guard  let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationTime = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
            let animationCurve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
                return nil
        }
        let animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.intValue<<16))
        return (keyboardSize.height, animationTime.doubleValue, animationOptions)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let parameter = keyboardParameterFrom(notification: notification) {
            UIView.animate(withDuration: parameter.duration, delay: 0.0, options: parameter.animatorOption , animations: {
                self.additionalSafeAreaInsets.bottom = 0.0
                self.additionalSafeAreaInsets.bottom = parameter.keyboardHeight - self.view.safeAreaInsets.bottom
                let remainingHeight = self.view.frame.size.height - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top
                self.saveTransactionButton.isHidden = remainingHeight < Constants.hideSaveTransactionButtonLevel
                self.transactionDatePicker.isHidden = remainingHeight < Constants.hidetransactionDatePickerLevel
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let parameter = keyboardParameterFrom(notification: notification) {
            UIView.animate(withDuration: parameter.duration, delay: 0.0, options: parameter.animatorOption , animations: {
                self.additionalSafeAreaInsets.bottom = 0.0
                self.saveTransactionButton.isHidden = false
                self.transactionDatePicker.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
}
