//
//  DummyEntrantFactory.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 8/2/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

enum Guest: String {
    case Classic, VIP, Senior
    case SeasonPass = "Season"
    case FreeChild = "Free Child"
    
    var passDescription: String {
        return "\(self.rawValue) Guest Pass"
    }
}

enum Employee: String {
    case Maintenance, Manager
    case FoodServices = "Food Services"
    case RideServices = "Ride Services"
    
    var passDescription: String {
        return "Employee Pass - \(self.rawValue)"
    }
}

enum ContractorProjectNumber: Int {
    case P1001 = 1001, P1002, P1003
    case P2001 = 2001, P2002
    
    var passDescription: String {
        return "Contractor Pass - Project #\(self.rawValue)"
    }
}

enum VendorName: String {
    case Acme, Orkin, Fedex
    case NWElectrical = "NW Electrical"
    
    var passDescription: String {
        return "Vendor Pass - \(self.rawValue)"
    }
}

class DummyEntrantFactory {
    
    static let sharedInstance = DummyEntrantFactory()
    
    private init() {}
    
    private let dummyFullName: FullName = try! FullName(firstName: "firstName", lastName: "lastName")
    private let dummyFullAdddress: FullAddress = try! FullAddress(streetAddress: "streetAddress", city: "city", state: "state", zipCode: 12345)
    
    func dummyGuest(guestType: Guest) -> GuestType {
        
        switch guestType {
        case .Classic: return ClassicGuest()
        case .VIP: return VIPGuest()
        case .SeasonPass: return SeasonPassGuest(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .FreeChild: return try! FreeChildGuest(birthMonth: 1, birthDay: 1, birthYear: 2016)
        case .Senior: return try! SeniorGuest(fullName: dummyFullName, fullAddress: dummyFullAdddress, birthMonth: 1, birthDay: 1, birthYear: 1916)
        }
    }
    
    func dummyEmployee(employeeType: Employee) -> EmployeeType {
        
        switch employeeType {
        case .FoodServices: return HourlyEmployeeFoodServices(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .RideServices: return HourlyEmployeeRideServices(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .Maintenance: return HourlyEmployeeMaintenance(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .Manager: return Manager(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        }
    }
    
    func dummyContractor(projectNumber: ContractorProjectNumber) -> ContractEmployeeType {
        switch projectNumber {
        case .P1001: return ContractEmployeeProject1001(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .P1002: return ContractEmployeeProject1002(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .P1003: return ContractEmployeeProject1003(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .P2001: return ContractEmployeeProject2001(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        case .P2002: return ContractEmployeeProject2002(fullName: dummyFullName, fullAddress: dummyFullAdddress)
        }
    }
    
    func dummyVendor(vendorName: VendorName) -> VendorType {
        
        switch vendorName {
        case .Acme: return try! Vendor(fullName: dummyFullName, fullAddress: dummyFullAdddress, birthMonth: 1, birthDay: 1, birthYear: 1)
        case .Fedex: return try! Vendor(fullName: dummyFullName, fullAddress: dummyFullAdddress, birthMonth: 1, birthDay: 1, birthYear: 1)
        case .NWElectrical: return try! Vendor(fullName: dummyFullName, fullAddress: dummyFullAdddress, birthMonth: 1, birthDay: 1, birthYear: 1)
        case .Orkin: return try! Vendor(fullName: dummyFullName, fullAddress: dummyFullAdddress, birthMonth: 1, birthDay: 1, birthYear: 1)
        }
    }
}