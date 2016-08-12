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
    
    @IBOutlet weak var accessButton0: UIButton!
    @IBOutlet weak var accessButton1: UIButton!
    @IBOutlet weak var accessButton2: UIButton!
    @IBOutlet weak var accessButton3: UIButton!
    @IBOutlet weak var accessButton4: UIButton!
    
    var entrant: EntrantType!
    var passDescription: String!
    var perks: [String] = []
    
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
        getPerks()
        setPerkLabels()
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
    
    func getPerks() {
        
        if entrant is AllRidesAcesssible {
            perks.append("• Unlimited Rides")
        } else {
            perks.append("")
        }
        
        if let person = entrant as? FoodDiscountAccessible {
            perks.append("• \(person.foodDiscountPercent)% Food Discount")
        } else {
            perks.append("")
        }
        
        if let person = entrant as? MerchandiseDiscountAccessible {
            perks.append("• \(person.merchandiseDiscountPercent)% Merchandise Discount")
        } else {
            perks.append("")
        }
    }
    
    func setPerkLabels() {
        perk2Label.text = perks[2]
        perk1Label.text = perks[1]
        perk0Label.text = perks[0]
    }
}
