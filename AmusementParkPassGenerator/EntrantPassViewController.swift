//
//  EntrantPassViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 8/4/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class EntrantPassViewController: UIViewController {

    @IBOutlet weak var header0Label: UILabel!
    @IBOutlet weak var header1Label: UILabel!
    @IBOutlet weak var perk2Label: UILabel!
    @IBOutlet weak var perk1Label: UILabel!
    @IBOutlet weak var perk0Label: UILabel!
    
    var entrant: EntrantType!
    var passDescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePass()
    }
    
    @IBAction func createNewPassButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Helper methods
    
    func configurePass() {
        setHeaders()
    }
    
    func setHeaders() {
        
        if let person = entrant as? Nameable {
            header0Label.text = "\(person.fullName)"
            header1Label.text = passDescription
        } else {
            header0Label.text = passDescription
            header1Label.text = ""
        }
    }
}
