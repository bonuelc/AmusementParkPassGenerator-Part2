//
//  EntrantFormViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class EntrantFormViewController: UIViewController {

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
    }
    
    @IBAction func employeeTabTapped(sender: UIButton) {
    }
    
    @IBAction func managerTabTapped(sender: UIButton) {
    }
    
    @IBAction func contractorTabTapped(sender: UIButton) {
    }
    
    @IBAction func vendorTabTapped(sender: UIButton) {
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
}
