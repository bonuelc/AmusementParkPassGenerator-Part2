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

struct FullName: CustomStringConvertible {
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
    
    var description: String {
        return "\(firstName) \(lastName)"
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

protocol EntrantType: AmusementAreaAccessible {
}

protocol GuestType: EntrantType, AllRidesAcesssible {
}

protocol EmployeeType: EntrantType, Nameable, Addressable {
}

protocol FullTimeEmployeeType: EmployeeType, FoodDiscountAccessible, MerchandiseDiscountAccessible, AllRidesAcesssible {
}

// Contrete Types

// Guests

struct ClassicGuest: GuestType {
}

struct VIPGuest: GuestType, SkipAllRideLinesAcessible, FoodDiscountAccessible, MerchandiseDiscountAccessible {
    let foodDiscountPercent: Int = 10
    let merchandiseDiscountPercent: Int = 20
}

enum BirthdayError: ErrorType {
    case InvalidBirthday
    case TooOldForDiscount
    case TooYoungForDiscount
}

struct FreeChildGuest: GuestType, BirthdayWishable {
    
    var dateOfBirth: NSDate
    
    init (birthMonth: Int, birthDay:  Int, birthYear: Int) throws {
        guard let birthday = NSCalendar.currentCalendar().dateWithEra(1, year: birthYear, month: birthMonth, day: birthDay, hour: 0, minute: 0, second: 0, nanosecond: 0) else {
            throw BirthdayError.InvalidBirthday
        }
        
        if NSDate.numYearsOld(birthday) >= 5 {
            throw BirthdayError.TooOldForDiscount
        }
        
        dateOfBirth = birthday
    }
}

extension NSDate {
    static func numYearsOld(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: NSDate(), options: []).year
    }
    
    static func isTodayAnniversary(eventDate: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        
        let today = NSDate()
        
        let todayComponents = calendar.components([.Month, .Day], fromDate: today)
        let eventComponents = calendar.components([.Month, .Day], fromDate: eventDate)
        
        return todayComponents.month == eventComponents.month && todayComponents.day == eventComponents.day
    }
}

struct SeasonPassGuest: GuestType, SkipAllRideLinesAcessible, FoodDiscountAccessible, MerchandiseDiscountAccessible, Nameable, Addressable {
    let fullName: FullName
    let fullAddress: FullAddress
    let foodDiscountPercent: Int = 10
    let merchandiseDiscountPercent: Int = 20
}

struct SeniorGuest: GuestType, SkipAllRideLinesAcessible, FoodDiscountAccessible, MerchandiseDiscountAccessible, Nameable, BirthdayWishable {
    
    let dateOfBirth: NSDate
    
    let fullName: FullName
    let fullAddress: FullAddress
    let foodDiscountPercent: Int = 10
    let merchandiseDiscountPercent: Int = 10
    
    init (fullName: FullName, fullAddress: FullAddress, birthMonth: Int, birthDay:  Int, birthYear: Int) throws {
        guard let birthday = NSCalendar.currentCalendar().dateWithEra(1, year: birthYear, month: birthMonth, day: birthDay, hour: 0, minute: 0, second: 0, nanosecond: 0) else {
            throw BirthdayError.InvalidBirthday
        }
        
        if NSDate.numYearsOld(birthday) < 65 {
            throw BirthdayError.TooYoungForDiscount
        }
        
        self.dateOfBirth = birthday
        
        self.fullName = fullName
        self.fullAddress = fullAddress
    }
}

// Employees

class Employee: EmployeeType {
    let fullName: FullName
    let fullAddress: FullAddress
    var foodDiscountPercent: Int = 15
    var merchandiseDiscountPercent: Int = 25
    
    init(fullName: FullName, fullAddress: FullAddress) {
        self.fullName = fullName
        self.fullAddress = fullAddress
    }
}

class HourlyEmployeeFoodServices: Employee, KitchenAreaAccessible, AllRidesAcesssible {
}

class HourlyEmployeeRideServices: Employee, RideControlAreaAccessible, AllRidesAcesssible {
}

class HourlyEmployeeMaintenance: Employee, KitchenAreaAccessible, RideControlAreaAccessible, MaintenanceAreaAccessible {
}

class Manager: Employee, KitchenAreaAccessible, RideControlAreaAccessible, MaintenanceAreaAccessible, OfficeAreaAccessible {
    
    override init(fullName: FullName, fullAddress: FullAddress) {
        super.init(fullName: fullName, fullAddress: fullAddress)
        self.foodDiscountPercent = 25
    }
}

