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
    
    var alertTitle: String {
        switch self {
        case .EmptyFirstName: return "First name entry is blank"
        case .EmptyLastName: return "Last name entry is blank"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .EmptyFirstName: return "Please fill in first name"
        case .EmptyLastName: return "Please fill in last name"
        }
    }
}

enum FullAddressError: ErrorType {
    case EmptyStreetAddress
    case EmptyCity
    case EmptyState
    
    var alertTitle: String {
        switch self {
        case .EmptyStreetAddress: return "Street address entry is blank"
        case .EmptyCity: return "City entry is blank"
        case .EmptyState: return "State entry is blank"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .EmptyStreetAddress: return "Please fill in street address"
        case .EmptyCity: return "Please fill in city"
        case .EmptyState: return "Please fill in state"
        }
    }
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
    var fullName: FullName { get set }
}

protocol Addressable {
    var fullAddress: FullAddress { get set }
}

protocol BirthdayWishable {
    var dateOfBirth: NSDate { get set }
}

protocol VisitDateable {
    var dateOfVisit: NSDate? { get set }
}


// MARK: Is-A Protocols

protocol EntrantType {
}

protocol GuestType: EntrantType, AmusementAreaAccessible, AllRidesAcesssible {
}

protocol EmployeeType: EntrantType, Nameable, Addressable {
}

protocol FullTimeEmployeeType: EmployeeType, AmusementAreaAccessible, FoodDiscountAccessible, MerchandiseDiscountAccessible, AllRidesAcesssible {
}

protocol ContractEmployeeType: EmployeeType {
}

protocol VendorType: EntrantType, Nameable, BirthdayWishable, VisitDateable {
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
    var fullName: FullName
    var fullAddress: FullAddress
    let foodDiscountPercent: Int = 10
    let merchandiseDiscountPercent: Int = 20
}

struct SeniorGuest: GuestType, SkipAllRideLinesAcessible, FoodDiscountAccessible, MerchandiseDiscountAccessible, Nameable, BirthdayWishable {
    
    var dateOfBirth: NSDate
    
    var fullName: FullName
    var fullAddress: FullAddress
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

class FullTimeEmployee: FullTimeEmployeeType {
    var fullName: FullName
    var fullAddress: FullAddress
    var foodDiscountPercent: Int = 15
    var merchandiseDiscountPercent: Int = 25
    
    init(fullName: FullName, fullAddress: FullAddress) {
        self.fullName = fullName
        self.fullAddress = fullAddress
    }
}

class HourlyEmployeeFoodServices: FullTimeEmployee, KitchenAreaAccessible {
}

class HourlyEmployeeRideServices: FullTimeEmployee, RideControlAreaAccessible {
}

class HourlyEmployeeMaintenance: FullTimeEmployee, KitchenAreaAccessible, RideControlAreaAccessible, MaintenanceAreaAccessible {
}

class Manager: FullTimeEmployee, KitchenAreaAccessible, RideControlAreaAccessible, MaintenanceAreaAccessible, OfficeAreaAccessible {
    
    override init(fullName: FullName, fullAddress: FullAddress) {
        super.init(fullName: fullName, fullAddress: fullAddress)
        self.foodDiscountPercent = 25
    }
}

enum ProjectNumberError: ErrorType {
    case InvalidNumber
}

struct ContractEmployeeFactory {
    
    func createContractEmployee(fullName: FullName, fullAddress: FullAddress, projectNumber: Int) throws -> EmployeeType {
        switch projectNumber {
        case 1001:
            return ContractEmployeeProject1001(fullName: fullName, fullAddress: fullAddress)
        case 1002:
            return ContractEmployeeProject1002(fullName: fullName, fullAddress: fullAddress)
        case 1003:
            return ContractEmployeeProject1003(fullName: fullName, fullAddress: fullAddress)
        case 2001:
            return ContractEmployeeProject2001(fullName: fullName, fullAddress: fullAddress)
        case 2002:
            return ContractEmployeeProject2002(fullName: fullName, fullAddress: fullAddress)
        default:
            throw ProjectNumberError.InvalidNumber
        }
    }
}

class ContractEmployee: ContractEmployeeType {
    var fullName: FullName
    var fullAddress: FullAddress
    
    init(fullName: FullName, fullAddress: FullAddress) {
        self.fullName = fullName
        self.fullAddress = fullAddress
    }
}

class ContractEmployeeProject1001: ContractEmployee, AmusementAreaAccessible, AllRidesAcesssible, SkipAllRideLinesAcessible {
}

class ContractEmployeeProject1002: ContractEmployee, AmusementAreaAccessible, MaintenanceAreaAccessible, AllRidesAcesssible, SkipAllRideLinesAcessible {
}

class ContractEmployeeProject1003: ContractEmployee, AmusementAreaAccessible, KitchenAreaAccessible, MaintenanceAreaAccessible, OfficeAreaAccessible, AllRidesAcesssible, SkipAllRideLinesAcessible {
}

class ContractEmployeeProject2001: ContractEmployee, OfficeAreaAccessible {
}

class ContractEmployeeProject2002: ContractEmployee, KitchenAreaAccessible, MaintenanceAreaAccessible {
}

// Vendors

enum VendorNameError: ErrorType {
    case InvalidVendor
}

struct VendorFactory {
    
    func createVendor(fullName: FullName, fullAddress: FullAddress, birthMonth: Int, birthDay:  Int, birthYear: Int, vendorName: String) throws -> VendorType {
        do {
            
            switch vendorName {
            case "Acme":
                return try Acme(fullName: fullName, fullAddress: fullAddress, birthMonth: birthMonth, birthDay: birthDay, birthYear: birthYear)
            case "Orkin":
                return try Orkin(fullName: fullName, fullAddress: fullAddress, birthMonth: birthMonth, birthDay: birthDay, birthYear: birthYear)
            case "Fedex":
                return try Fedex(fullName: fullName, fullAddress: fullAddress, birthMonth: birthMonth, birthDay: birthDay, birthYear: birthYear)
            case "NW Electrical":
                return try NWElectrical(fullName: fullName, fullAddress: fullAddress, birthMonth: birthMonth, birthDay: birthDay, birthYear: birthYear)
            default:
                throw VendorNameError.InvalidVendor
            }
        } catch {
            throw BirthdayError.InvalidBirthday
        }
    }
}

class Vendor: VendorType {
    var fullName: FullName
    var fullAddress: FullAddress
    
    var dateOfVisit: NSDate?
    
    var dateOfBirth: NSDate
    
    init (fullName: FullName, fullAddress: FullAddress, birthMonth: Int, birthDay:  Int, birthYear: Int) throws {
        guard let birthday = NSCalendar.currentCalendar().dateWithEra(1, year: birthYear, month: birthMonth, day: birthDay, hour: 0, minute: 0, second: 0, nanosecond: 0) else {
            throw BirthdayError.InvalidBirthday
        }
        
        self.dateOfBirth = birthday
        
        self.fullName = fullName
        self.fullAddress = fullAddress
    }
}

class Acme: Vendor, KitchenAreaAccessible {
}

class Orkin: Vendor, AmusementAreaAccessible, RideControlAreaAccessible, KitchenAreaAccessible {
}

class Fedex: Vendor, MaintenanceAreaAccessible, OfficeAreaAccessible {
}

class NWElectrical: Vendor, AmusementAreaAccessible, RideControlAreaAccessible, KitchenAreaAccessible, MaintenanceAreaAccessible, OfficeAreaAccessible {
}