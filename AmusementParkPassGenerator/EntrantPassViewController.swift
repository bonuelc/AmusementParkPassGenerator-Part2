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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePass()
    }
    
    func configurePass() {
        if let person = entrant as? Nameable {
            header1Label.text = "\(person.fullName)"
        }
    }
}
