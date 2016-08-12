//
//  Scanner.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/18/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import AudioToolbox

enum AccessType {
    // Area Access
    case AmusementAreas, KitchenAreas, RideControlAreas, MaintenanceAreas, OfficeAreas
    // Ride Access
    case AllRides, SkipRideLines
    // Discount Access
    case FoodDiscount(Int), MerchandiseDiscount(Int)
    
    var description: String {
        switch self {
        case .AmusementAreas: return "amusement areas"
        case .KitchenAreas: return "kitchen areas"
        case .RideControlAreas: return "ride control areas"
        case .MaintenanceAreas: return "maintenance areas"
        case .OfficeAreas: return "office areas"
        case .AllRides: return "all rides"
        case .SkipRideLines: return "skip ride lines"
        case .FoodDiscount(let discount): return (discount > 0) ? "\(discount)% food discount" : "food discount"
        case .MerchandiseDiscount(let discount): return (discount > 0) ? "\(discount)% discount" : "merchandise discount"
        }
    }
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
    
    private var sound: SystemSoundID = 0
    
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
            playSound(Access.Granted.url)
        } else {
            playSound(Access.Denied.url)
        }
        
        if var person = entrant as? VisitDateable {
            person.dateOfVisit = NSDate()
        }
        
        return accessGranted
    }
    
    private func playSound(url: NSURL) {
        AudioServicesCreateSystemSoundID(url, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}