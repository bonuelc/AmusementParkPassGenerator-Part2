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
    
    @IBAction func guestTabTapped(sender: UIButton) {
        labelSubtabs("Classic", "VIP", "Free Child", "Season Pass", "Senior")
    }
    
    @IBAction func employeeTabTapped(sender: UIButton) {
        labelSubtabs("Food Services", "Ride Services", "Maintenance")
    }
    
    @IBAction func managerTabTapped(sender: UIButton) {
        labelSubtabs(" ")
    }

    @IBAction func contractorTabTapped(sender: UIButton) {
        labelSubtabs("1001", "1002", "1003", "2001", "2002")
    }
    
    @IBAction func vendorTabTapped(sender: UIButton) {
        labelSubtabs("Acme", "Orkin", "Fedex", "NW Electrical")
    }
    
    @IBAction func entrantSubtypeTapped(sender: UIButton) {
        
        guard let tabText = sender.titleLabel?.text else {
            return
        }
        
        let def = DummyEntrantFactory.sharedInstance
        
        switch tabText {
        // Guest types
        case "Classic":
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
        case "Food Services":
            entrant = def.dummyEmployee(.FoodServices)
        case "Ride Services":
            entrant = def.dummyEmployee(.RideServices)
        case "Maintenance":
            entrant = def.dummyEmployee(.Maintenance)
        case "1001", "1002", "1003", "2001", "2002":
            projectNumberTextField.text = tabText
            
            guard let projectNumber = Int(tabText), contractProjectNumber = ContractorProjectNumber(rawValue: projectNumber) else {
                print("Invalid project number")
                return
            }

            entrant = def.dummyContractor(contractProjectNumber)
        case " ": entrant = def.dummyEmployee(.Manager)
        // Vendor types
        case "Acme", "Orkin", "Fedex", "NW Electrical":
            companyTextField.text = tabText
            
            guard let vendorName = VendorName(rawValue: tabText) else {
                print("Invalid vendor name")
                return
            }
            
            entrant = def.dummyVendor(vendorName)
        default: print("Tab not recognized")
        }
        
        disableUnrequiredTextFieldsForEntrant(entrant)
    }
    
    // MARK: Helper methods
    
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
        enableTextFields(projectNumberTextField, enabled: entrant is ContractEmployeeType)
        enableTextFields(firstNameTextField, lastNameTextField, enabled: entrant is Nameable)
        enableTextFields(companyTextField, enabled: entrant is VendorType)
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
