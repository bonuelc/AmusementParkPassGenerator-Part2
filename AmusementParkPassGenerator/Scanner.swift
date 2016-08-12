//
//  Scanner.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/18/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import AudioToolbox

enum AccessType: String {
    // Area Access
    case AmusementAreas, KitchenAreas, RideControlAreas, MaintenanceAreas, OfficeAreas
    // Ride Access
    case AllRides, SkipRideLines
    // Discount Access
    case FoodDiscount, MerchandiseDiscount
}



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

class Scanner {
    
    static let sharedInstance = Scanner()
    private init() {}
    
    var sound: SystemSoundID = 0
    
    func scan(entrant: EntrantType, accessType: AccessType) -> Bool {
        
        if let birthdayPerson = entrant as? BirthdayWishable {
            if NSDate.isTodayAnniversary(birthdayPerson.dateOfBirth) {
                print("Happy Birthday!")
            }
        }
        
        
        var accessGranted: Bool = false
        
        switch accessType {
        // Area Access
        case .AmusementAreas:
            accessGranted = entrant is AmusementAreaAccessible
        case .KitchenAreas:
            accessGranted = entrant is KitchenAreaAccessible
        case .RideControlAreas:
            accessGranted = entrant is RideControlAreaAccessible
        case .MaintenanceAreas:
            accessGranted = entrant is MaintenanceAreaAccessible
        case .OfficeAreas:
            accessGranted = entrant is OfficeAreaAccessible
        // Ride Access
        case .AllRides:
            accessGranted = entrant is AllRidesAcesssible
        case .SkipRideLines:
            accessGranted = entrant is SkipAllRideLinesAcessible
        // Discount Access
        case .FoodDiscount:
            accessGranted = entrant is FoodDiscountAccessible
        case .MerchandiseDiscount:
            accessGranted = entrant is MerchandiseDiscountAccessible
        }
        
        if accessGranted {
            print("Access to \(accessType) is granted")
            playSound(Access.Granted.url)
        } else {
            print("Access to \(accessType) is denied")
            playSound(Access.Denied.url)
        }
        
        return accessGranted
    }
    
    func playSound(url: NSURL) {
        AudioServicesCreateSystemSoundID(url, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}