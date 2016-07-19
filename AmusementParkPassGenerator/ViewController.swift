//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    enum Access {
        case Granted
        case Denied
        
        private var filename: String {
            switch(self) {
            case .Granted: return "AccessGranted"
            case .Denied: return "AccessDenied"
            }
        }
        
        var url: NSURL {
            let path = NSBundle.mainBundle().pathForResource(self.filename, ofType: "wav")!
            return  NSURL(fileURLWithPath: path)
        }
    }
    
    var sound: SystemSoundID = 0
    var entrants: [EntrantType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createValidEntrants()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scan(entrant: EntrantType, accessType: AccessType) {
        
        if let birthdayPerson = entrant as? BirthdayWishable {
            if NSDate.isTodayAnniversary(birthdayPerson.dateOfBirth) {
                print("Happy Birthday!")
            }
        }
        
        if Scanner.scan(entrant, accessType: accessType) {
            print("Access to \(accessType) is granted")
            playSound(Access.Granted.url)
        } else {
            print("Access to \(accessType) is denied")
            playSound(Access.Denied.url)
        }
    }
    
    func playSound(url: NSURL) {
        AudioServicesCreateSystemSoundID(url, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
    func createValidEntrants() {
        entrants.append(ClassicGuest())
        
        entrants.append(VIPGuest())
        
        try! entrants.append(FreeChildGuest(birthMonth: 7, birthDay: 19, birthYear: 2015))
        
        let marioName = try! FullName(firstName: "Mario", lastName: "Mario")
        let marioAddress = try! FullAddress(streetAddress: "123 Mushroom", city: "Green Pipe", state: "MM", zipCode: 12345)
        let Mario = HourlyEmployeeFoodServices(fullName: marioName, fullAddress: marioAddress)
        entrants.append(Mario)
        
        let yoshiName = try! FullName(firstName: "Yoshi", lastName: "Horse")
        let yoshiAddress = marioAddress
        let Yoshi = HourlyEmployeeRideServices(fullName: yoshiName, fullAddress: yoshiAddress)
        entrants.append(Yoshi)
        
        let luigiName = try! FullName(firstName: "Luigi", lastName: "Mario")
        let luigiAddress = marioAddress
        let Luigi = HourlyEmployeeMaintenance(fullName: luigiName, fullAddress: luigiAddress)
        entrants.append(Luigi)
        
        let bowserName = try! FullName(firstName: "Bowser", lastName: "Reptile")
        let bowserAddress = try! FullAddress(streetAddress: "123 Lava", city: "Phoenix", state: "AZ", zipCode: 12345)
        let Bowser = Manager(fullName: bowserName, fullAddress: bowserAddress)
        entrants.append(Bowser)
    }
}