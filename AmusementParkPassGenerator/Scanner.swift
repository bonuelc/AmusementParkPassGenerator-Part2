//
//  Scanner.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/18/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

enum AccessType: String {
    // Area Access
    case AmusementAreas, KitchenAreas, RideControlAreas, MaintenanceAreas, OfficeAreas
    // Ride Access
    case AllRides, SkipRideLines
    // Discount Access
    case FoodDiscount, MerchandiseDiscount
}

class Scanner {
    static func scan(entrant: EntrantType, accessType: AccessType) -> Bool {
        switch accessType {
        // Area Access
        case .AmusementAreas:
            return entrant is AmusementAreaAccessible
        case .KitchenAreas:
            return entrant is KitchenAreaAccessible
        case .RideControlAreas:
            return entrant is RideControlAreaAccessible
        case .MaintenanceAreas:
            return entrant is MaintenanceAreaAccessible
        case .OfficeAreas:
            return entrant is OfficeAreaAccessible
        // Ride Access
        case .AllRides:
            return entrant is AllRidesAcesssible
        case .SkipRideLines:
            return entrant is SkipAllRideLinesAcessible
        // Discount Access
        case .FoodDiscount:
            return entrant is FoodDiscountAccessible
        case .MerchandiseDiscount:
            return entrant is MerchandiseDiscountAccessible
        }
    }
}