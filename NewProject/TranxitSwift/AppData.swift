//
//  AppData.swift
//  User
//
//  Created by CSS on 10/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

let AppName = "Kal Cabs"
let googleMapKey = "AIzaSyCgoZk9_bfeFYXXG93StvOVzHWJKjbjw1I"
let appSecretKey = "Uu0pWOiNHukAFOZfQSLsMkgqUyG8d8dMEN9LQbSw"
let appClientId = 2

let defaultMapLocation = LocationCoordinate(latitude: 13.009245, longitude: 80.212929)
//let locationApi = "https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@"
let baseUrl = "https://staging.kaltaxi.com/"//"https://kaltaxi.com/"//"https://schedule.tranxit.co/"    http://104.248.237.66/phpmyadmin

let requestCheckInterval : TimeInterval = 5
var deviceTokenString = ""

