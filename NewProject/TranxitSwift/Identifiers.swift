//
//  Identifiers.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

// MARK:- Storyboard Id
struct Storyboard {
    
    static let Ids = Storyboard()
    let LaunchViewController = "LaunchViewController"
    let DrawerController = "DrawerController"
    let WalkThroughPreviewController = "WalkThroughPreviewController"
    let PhoneNumberViewController = "PhoneNumberViewController"
    let PhoneNumverVerificationViewController = "PhoneNumverVerificationViewController"
    let HomePageViewController = "HomePageViewController"
    let ProfilePageViewController = "ProfilePageViewController"
    let yourTripsViewController = "yourTripsViewController"
    let YourTripsDetailViewController = "YourTripsDetailViewController"
    let PaymentViewController = "PaymentViewController"
    let AddCardViewController = "AddCardViewController"
 
    
}


//MARK:- XIB Cell Names

struct XIB {
    
    static let Names = XIB()
    let HomePageCarSelection = "HomePageCarSelection"
    let CarSelectionCollectionViewCell = "CarSelectionCollectionViewCell"
    let YourTripsTableViewCell = "YourTripsTableViewCell"
    let PaymentTableViewCell = "PaymentTableViewCell"
    let FevortiesTableViewCell = "FevortiesTableViewCell"
    let RideNowDetailViwe = "RideNowDetailView"
    let FareTableViewCell = "FareTableViewCell"
    let BookForSomeOneTableViewCell = "BookForSomeOneTableViewCell"
    let RideNowHeaderSection = "RideNowHeaderSection"
    let CouponTableViewCell = "CouponTableViewCell"
    let AddCardTableViewCell = "AddCardTableViewCell"
}




//MARK:- Notification

extension Notification.Name {
   public static let providers = Notification.Name("providers")
}



