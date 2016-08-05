//
//  EntrantFormViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class EntrantFormViewController: UIViewController {
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var projectNumberTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var guestTab: UIButton!
    @IBOutlet weak var employeeTab: UIButton!
    @IBOutlet weak var managerTab: UIButton!
    @IBOutlet weak var contractorTab: UIButton!
    @IBOutlet weak var vendorTab: UIButton!
    
    var typeTabs: [UIButton]!

    @IBOutlet weak var subtypeTab0: UIButton!
    @IBOutlet weak var subtypeTab1: UIButton!
    @IBOutlet weak var subtypeTab2: UIButton!
    @IBOutlet weak var subtypeTab3: UIButton!
    @IBOutlet weak var subtypeTab4: UIButton!
    
    var subtypeTabs: [UIButton]!
    
    var entrant: EntrantType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableTextFields(projectNumberTextField, companyTextField, enabled: false)
        
        typeTabs = [
            guestTab,
            employeeTab,
            managerTab,
            contractorTab,
            vendorTab
        ]
        
        subtypeTabs = [
            subtypeTab0,
            subtypeTab1,
            subtypeTab2,
            subtypeTab3,
            subtypeTab4
        ]
    }

    func scan(entrant: EntrantType, accessType: AccessType) {
        Scanner.scan(entrant, accessType: accessType)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let epVC = segue.destinationViewController as? EntrantPassViewController {
            epVC.entrant = entrant
        }
    }
    
    @IBAction func guestTabTapped(sender: UIButton) {
        labelSubtabs("Classic", "VIP", "Free Child", "Season Pass", "Senior")
        entrantSubtypeTapped(sender)
    }
    
    @IBAction func employeeTabTapped(sender: UIButton) {
        labelSubtabs("Food Services", "Ride Services", "Maintenance")
        entrantSubtypeTapped(sender)
    }
    
    @IBAction func managerTabTapped(sender: UIButton) {
        labelSubtabs(" ")
        entrantSubtypeTapped(sender)
    }

    @IBAction func contractorTabTapped(sender: UIButton) {
        labelSubtabs("1001", "1002", "1003", "2001", "2002")
        entrantSubtypeTapped(sender)
    }
    
    @IBAction func vendorTabTapped(sender: UIButton) {
        labelSubtabs("Acme", "Orkin", "Fedex", "NW Electrical")
        entrantSubtypeTapped(sender)
    }
    
    @IBAction func entrantSubtypeTapped(sender: UIButton) {
        
        guard let tabText = sender.titleLabel?.text else {
            return
        }
        
        let def = DummyEntrantFactory.sharedInstance
        
        switch tabText {
        // Guest types
        case "Classic", "Guest":
            entrant = def.dummyGuest(.Classic)
        case "VIP":
            entrant = def.dummyGuest(.VIP)
        case "Free Child":
            entrant = def.dummyGuest(.FreeChild)
        case "Season Pass":
            entrant = def.dummyGuest(.SeasonPass)
        case "Senior":
            entrant = def.dummyGuest(.Senior)
        // Employee types
        case "Food Services", "Employee":
            entrant = def.dummyEmployee(.FoodServices)
        case "Ride Services":
            entrant = def.dummyEmployee(.RideServices)
        case "Maintenance":
            entrant = def.dummyEmployee(.Maintenance)
        case "1001", "1002", "1003", "2001", "2002", "Contractor":
            let contractProjectNumber: ContractorProjectNumber!
            if let projectNumber = Int(tabText) {
                contractProjectNumber = ContractorProjectNumber(rawValue: projectNumber)
            } else {
                contractProjectNumber = .P1001
            }
            projectNumberTextField.text = contractProjectNumber.rawValue.description
            entrant = def.dummyContractor(contractProjectNumber)
        case " ", "Manager": entrant = def.dummyEmployee(.Manager)
        // Vendor types
        case "Acme", "Orkin", "Fedex", "NW Electrical", "Vendor":
            let vendorName = VendorName(rawValue: tabText) ?? VendorName.Acme
            companyTextField.text = vendorName.rawValue
            entrant = def.dummyVendor(vendorName)
        default: print("Tab not recognized")
        }
        
        disableUnrequiredTextFieldsForEntrant(entrant)
    }
    
    @IBAction func generatePassButtonTapped() {
        
        if var person = entrant as? Nameable {
            do {
                person.fullName = try FullName(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
            } catch let error as FullNameError {
                presentAlertController(title: error.alertTitle, message: error.alertMessage)
            } catch let error {
                print(error)
            }
        }
        
        if var person = entrant as? Addressable {
            do {
                person.fullAddress = try FullAddress(streetAddress: streetAddressTextField.text!, city: cityTextField.text!, state: stateTextField.text!, zipCode: zipCodeTextField.text!)
            } catch let error as FullAddressError {
                presentAlertController(title: error.alertTitle, message: error.alertMessage)
            } catch let error {
                print(error)
            }
        }
        
        if var person = entrant as? BirthdayWishable {
            do {
                person.dateOfBirth = try parseDateOfBirthTextField()
            } catch let error as BirthdayError {
                presentAlertController(title: error.alertTitle, message: error.alertMessage)
            } catch let error {
                print(error)
            }
        }
        
        // TODO: Segue to next VC
    }
    
    @IBAction func populateDataButtonTapped() {
        
        if dateOfBirthTextField.enabledAndEmpty {
            dateOfBirthTextField.text = "05/12/55"
        }
        
        if firstNameTextField.enabledAndEmpty {
            firstNameTextField.text = "Homer"
        }
        
        if lastNameTextField.enabledAndEmpty {
            lastNameTextField.text = "Simpson"
        }
        
        if streetAddressTextField.enabledAndEmpty {
            streetAddressTextField.text = "742 Evergreen Terrace"
        }
        
        if cityTextField.enabledAndEmpty {
            cityTextField.text = "Springfield"
        }
        
        if stateTextField.enabledAndEmpty {
            stateTextField.text = "OR"
        }
        
        if zipCodeTextField.enabledAndEmpty {
            zipCodeTextField.text = "97477"
        }
    }
    
    // MARK: Helper methods
    
    func parseDateOfBirthTextField() throws -> NSDate {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        if let dateString = dateOfBirthTextField.text, birthday = formatter.dateFromString(dateString) {
            
            if entrant is FreeChildGuest && NSDate.numYearsOld(birthday) >= 5 {
                throw BirthdayError.TooOldForDiscount
            } else if entrant is SeniorGuest && NSDate.numYearsOld(birthday) < 65 {
                throw BirthdayError.TooYoungForDiscount
            }
            
            return birthday
            
        } else {
            throw BirthdayError.InvalidBirthday
        }
    }
    
    func presentAlertController(title title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showSubtabs(count: Int) {
        for i in 0..<count {
            subtypeTabs[i].hidden = false
        }
        
        for i in count..<subtypeTabs.count {
            subtypeTabs[i].hidden = true
        }
    }
    
    func labelSubtabs(labels: String...) {
        for (index, label) in labels.enumerate() {
            subtypeTabs[index].setTitle("\(label)", forState: .Normal)
        }
        showSubtabs(labels.count)
    }
    
    func disableUnrequiredTextFieldsForEntrant(entrant: EntrantType) {

        enableTextFields(dateOfBirthTextField, enabled: entrant is BirthdayWishable)
        enableTextFields(firstNameTextField, lastNameTextField, enabled: entrant is Nameable)
        enableTextFields(streetAddressTextField, cityTextField, stateTextField, zipCodeTextField, enabled: entrant is Addressable)
    }
    
    func enableTextFields(textFields: UITextField..., enabled: Bool) {
        
        for textField in textFields {
            if enabled {
                textField.alpha = 1.0
                textField.enabled = true
            } else {
                textField.alpha = 0.5
                textField.enabled = false
                textField.text = ""
            }
        }
    }
}

// MARK: extension UITextField

extension UITextField {
    var enabledAndEmpty: Bool {
        return self.enabled && self.text == ""
    }
}
