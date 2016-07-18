//
//  EntrantModel.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Foundation


// MARK: Wrapper Structs

enum FullNameError: ErrorType {
    case EmptyFirstName
    case EmptyLastName
}

enum FullAddressError: ErrorType {
    case EmptyStreetAddress
    case EmptyCity
    case EmptyState
}

struct FullName {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName:String) throws {
        if firstName.isEmpty {
            throw FullNameError.EmptyFirstName
        }
        
        if lastName.isEmpty {
            throw FullNameError.EmptyLastName
        }
        
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct FullAddress {
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: Int
    
    init(streetAddress: String, city: String, state: String, zipCode: Int) throws {
        if streetAddress.isEmpty {
            throw FullAddressError.EmptyStreetAddress
        }
        
        if city.isEmpty {
            throw FullAddressError.EmptyCity
        }
        
        if state.isEmpty {
            throw FullAddressError.EmptyState
        }
        
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}


// MARK: Can-Do Protocols

// MARK: Area Accessible Protocols

protocol AreaAccessible {
}

protocol AmusementAreaAccessible: AreaAccessible {
}

protocol KitchenAreaAccessible: AreaAccessible {
}

protocol RideControlAreaAccessible: AreaAccessible {
}

protocol MaintenanceAreaAccessible: AreaAccessible {
}

protocol OfficeAreaAccessible: AreaAccessible {
}

// MARK: Ride Acessible Protocols

protocol RideAccessible {
}

protocol AllRidesAcesssible: RideAccessible {
}

protocol SkipAllRideLinesAcessible: RideAccessible {
}

// MARK: Discount Accessible Protocols

protocol DiscountAccessible {
}

protocol FoodDiscountAccessible: DiscountAccessible {
    var foodDiscountPercent: Int { get }
}

protocol MerchandiseDiscountAccessible: DiscountAccessible {
    var merchandiseDiscountPercent: Int { get }
}

// MARK: Required Personal/Business Information Protocols

protocol Nameable {
    var fullName: FullName { get }
}

protocol Addressable {
    var fullAddress: FullAddress { get }
}

protocol BirthdayWishable {
    var dateOfBirth: NSDate { get }
}


// MARK: Is-A Protocols

protocol EntrantType {
}

protocol GuestType: EntrantType {
}

protocol ManagerType: EntrantType {
}

protocol EmployeeType: EntrantType {
}

protocol VendorType: EntrantType {
}

