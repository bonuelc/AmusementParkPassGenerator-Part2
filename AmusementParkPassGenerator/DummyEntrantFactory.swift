//
//  DummyEntrantFactory.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 8/2/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

enum Guest {
    case Classic, VIP, SeasonPass, FreeChild, Senior
}

enum Employee {
    case FoodServices
    case RideServices
    case Maintenance
    case Manager
}

enum ContractorProjectNumber: Int {
    case P1001 = 1001, P1002, P1003
    case P2001 = 2001, P2002
}

enum VendorName: String {
    case Acme, Orkin, Fedex
    case NWElectrical = "NW Electrical"
}

class DummyEntrantFactory {
    
    static let sharedInstance = DummyEntrantFactory()
    
    private init() {}
}