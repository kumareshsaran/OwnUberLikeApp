//
//  Profile.swift
//  User
//
//  Created by CSS on 07/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

class Profile : JSONSerializable {
    
    var id : Int?
    var first_name : String?
    var last_name : String?
    var email : String?
    var mobile : String?
    var picture : String?
    var device_token : String?
    var access_token : String?
    var currency : String?
//    var wallet_balance : Float?
    var wallet_balance : Double?

    var sos : String?
    var outstation_content : String?
    var rental_content : String?
    var emergency_contact1 : String?
    var emergency_contact2 : String?
    
    required init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        first_name = try? values.decode(String.self, forKey: .first_name)
        last_name = try? values.decode(String.self, forKey: .last_name)
        email = try? values.decode(String.self, forKey: .email)
        picture = try? values.decode(String.self, forKey: .picture)
        device_token = try? values.decode(String.self, forKey: .device_token)
        access_token = try? values.decode(String.self, forKey: .access_token)
        currency = try? values.decode(String.self, forKey: .currency)
        sos = try? values.decode(String.self, forKey: .sos)
        wallet_balance = try? values.decode(Double.self, forKey: .wallet_balance)
        outstation_content = try? values.decode(String.self, forKey: .outstation_content)
        rental_content = try? values.decode(String.self, forKey: .rental_content)
        emergency_contact1 = try values.decode(String.self, forKey: .emergency_contact1)
        emergency_contact2 = try values.decode(String.self, forKey: .emergency_contact2)


        if let mobileInt = try? values.decode(Int.self, forKey: .mobile) {
         mobile = "\(mobileInt)"
        } else {
         mobile = try? values.decode(String.self, forKey: .mobile)
        }

    }
    init() {
    }
    
}


struct requestObj1 : JSONSerializable {
    
    var id : Int?
    var first_name : String?
    var last_name : String?
    var email : String?
}
struct requestObj2 : JSONSerializable {
    
    var mobile : String?
    var picture : String?
    var device_token : String?
    var access_token : String?
    var currency : String?
}
struct requestObj3 : JSONSerializable {
    
    var wallet_balance : Double?
    var sos : String?
    var outstation_content : String?
    var rental_content : String?
    var emergency_contact1 : String?
    var emergency_contact2 : String?
}
