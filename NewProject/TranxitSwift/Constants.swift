//
//  Constants.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit
import Foundation

typealias ViewController = (UIViewController & PostViewProtocol)
var presenterObject :PostPresenterInputProtocol?

// MARK: - Constant Strings
struct Constants {
    static let string = Constants()
    
    let Done = "Done"
    let camera = "camera"
    let photoLibrary = "photoLibrary"
    let Cancel = "Cancel"
    let english = "english"
    let arabic = "arabic"
    
    //MARK:- LunchScreen constant
    let bookYourRide  = "BOOK YOUR RIDE"
    
    //MARK:- WalkThrough page
    let walkthroughTitle1 = "Ride with new people's & enjoy the trip"
    let walkthroughTitle2 = "High quality ride for your trip"
    let walkthroughTitle3 = "High quality ride for your trip"
    
    let walkthroughSubtitle1 = "Book and feel your ride"
    let walkthroughSubtitle2 = "Book and feel your ride"
    let walkthroughSubtitle3 = "Book and feel your ride"
    
    //MARK:- Phone Number Page
    
    let enterYourMobileNumber = "Please enter your mobile number"
    let phoneNumber = "Phone Number"
    let next = "Next"
    let cc = "CC"
    
    //MARK:- PhoneNumber Verification
    
    let enterYourOTP = "Enter the OTP"
    let weHaveSentYouOTP = "We have sent you a 4 digit verification code in the given number."
    let resentCode = "Resent Code"
    
    //MARK:- sidebar menu
    
    let yourTrips = "Your Trips"
    let payment = "Payment"
    let help = "Help"
    let aboutUs = "About Us"
    let setting = "Settings"
    let logout = "Logout"
    
    //MARK:- Profile page Constant
    let email = "Email"
    let phone = "Phone"
    let accountInfo = "Account info"
    let profile = "Profile"
    let save = "Save"
    
    //MARK:- yourTrip details
    let pastTripDetail = "Past trip detail"
    
    //MARK:-PaymentViewcontroller
    let cash = "Cash"
    let card = "Card"
    let addCard = "Add card"
    let paymentMenthod = "Payment method"
    let savedCard = "Saved cards"
    
    //MARK:- YourTrip
    
    let past = "Past"
    let upcoming = "Upcoming"
   
    //MARK:- LocationSearch Page
    let work = "Work"
    let home = "Home"
    let fevroties = "Fevroties"
    let enterPickUpLocation = "Enter your pickup location"
    let searchYourAddress = "Search your address"
    let address = "Address"
    let edit = "Edit"
    let delete = "Delete"
    
    //MARK:- Home Page RideNowDetailView
    let rideNow = "Ride now"
    let applyCoupon = "Apply coupon"
    let scheduleRide = "Schedule ride"
    
    //MARK:- Country Code selection viewController
    let selectCountry = "Select a Country"
    
}


//ENUM TRIP TYPE

enum TripType : String, Codable {
    
    case Business
    case Personal
    
}

//Payment Type

enum  PaymentType : String, Codable {
    
    case CASH = "CASH"
    case ccAvenue = "CC_AVENUE"
    
}


// Date Formats

struct DateFormat {
    
    static let list = DateFormat()
    let yyyy_mm_dd_HH_MM_ss = "yyyy-MM-dd HH:mm:ss"
    let MMM_dd_yyyy_hh_mm_ss_a = "MMM dd, yyyy hh:mm:ss a"
    let hhmmddMMMyyyy = "hh:mm a - dd:MMM:yyyy"
    let ddMMyyyyhhmma = "dd-MM-yyyy hh:mma"
    let ddMMMyyyy = "dd MMM yyyy"
    let hh_mm_a = "hh : mm a"
    let dd_mm_yyyy = "dd/MM/yyyy"
}



// Devices

enum DeviceType : String, Codable {
    
    case ios = "ios"
    case android = "android"
    
}

//Lanugage

enum Language : String, Codable, CaseIterable {
    case english = "en"
    case arabic = "ar"
    
    var code : String {
        switch self {
        case .english:
            return "en"
        case .arabic:
            return "ar"
        }
    }
    
    var title : String {
        switch self {
        case .english:
            return Constants.string.english
        case .arabic:
            return Constants.string.arabic
        }
    }
    
    static var count: Int{ return 2 }
}



// MARK:- Login Type

enum LoginType : String, Codable {
    
    case facebook
    case google
    case manual
    
}




enum Vibration : UInt {
    case weak = 1519
    case threeBooms = 1107
}


enum CommonError: Error {
    case ViewCannotBeload(view: UIView)
}

