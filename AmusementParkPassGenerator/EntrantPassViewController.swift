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
    
    @IBOutlet weak var testResultsLabel: UILabel!
    
    var accessButtons: [UIButton]!
    
    var entrant: EntrantType!
    var passDescription: String!
    var perks: [String] = []
    let scanner = Scanner.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePass()
        
        accessButtons = [
            accessButton0,
            accessButton1,
            accessButton2,
            accessButton3,
            accessButton4
        ]
    }
    
    @IBAction func createNewPassButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func accessButtonTapped(sender: UIButton) {
        
        guard let buttonText = sender.titleLabel?.text else {
            print("Button doesn't have any text")
            return
        }
        
        var accessType: AccessType?
        
        switch buttonText {
        // show sub-access-type buttons
        case "Area Access": labelAccessButtons("Amusement", "Kitchen", "Ride Control", "Maintenance", "Office")
        case "Ride Access": labelAccessButtons("All Rides", "Skip Line")
        case "Discount Access": labelAccessButtons("Food", "Merchandise")
        // scan entrant for access
        case "Amusement": accessType = .AmusementAreas
        case "Kitchen": accessType = .KitchenAreas
        case "Ride Control": accessType = .RideControlAreas
        case "Maintenance": accessType = .MaintenanceAreas
        case "Office": accessType = .OfficeAreas
        case "All Rides": accessType = .AllRides
        case "Skip Line": accessType = .SkipRideLines
        case "Food": accessType = .FoodDiscount
        case "Merchandise": accessType = .MerchandiseDiscount
        default:
            print("Button not recognized")
            return
        }
        
        if let accessType = accessType {
            showAccessResult(accessType)
            // show original access buttons
            labelAccessButtons("Area Access", "Ride Access", "Discount Access")
        }
    }
    
    // MARK: Helper methods
    
    func showAccessResult(accessType: AccessType) {
        
        let accessGranted = scanner.scan(entrant, accessType: accessType)
        
        testResultsLabel.textColor = UIColor.whiteColor()
        
        if accessGranted {
            testResultsLabel.backgroundColor = UIColor(red: 72.0/255.0, green: 132.0/255.0, blue: 124.0/255.0, alpha: 1.0)
            testResultsLabel.text = "Access to \(accessType) is granted"
        } else {
            testResultsLabel.backgroundColor = UIColor(red: 228.0/255.0, green: 0.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            testResultsLabel.text = "Access to \(accessType) is denied"
        }
    }
    
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
    
    func showAccessButtons(count: Int) {
        for i in 0..<count {
            accessButtons[i].hidden = false
        }
        
        for i in count..<accessButtons.count {
            accessButtons[i].hidden = true
        }
    }
    
    func labelAccessButtons(labels: String...) {
        for (index, label) in labels.enumerate() {
            accessButtons[index].setTitle("\(label)", forState: .Normal)
        }
        showAccessButtons(labels.count)
    }
}
