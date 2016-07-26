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

    @IBOutlet weak var subtypeTab0: UIButton!
    @IBOutlet weak var subtypeTab1: UIButton!
    @IBOutlet weak var subtypeTab2: UIButton!
    @IBOutlet weak var subtypeTab3: UIButton!
    @IBOutlet weak var subtypeTab4: UIButton!
    
    var subtypeTabs: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
