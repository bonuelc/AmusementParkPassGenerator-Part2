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