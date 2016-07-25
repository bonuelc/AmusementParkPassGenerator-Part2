//
//  EntrantFormViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class EntrantFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
