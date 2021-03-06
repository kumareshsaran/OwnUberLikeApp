//
//  ApiList.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

//Http Method Types

enum HttpType : String{
    
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

// Status Code

enum StatusCode : Int {
    
    case notreachable = 0
    case success = 200
    case multipleResponse = 300
    case unAuthorized = 401
    case notFound = 404
    case ServerError = 500
    
}



enum Base : String{
  
    case signup = ""
    
    
    
    init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? .signup
    }
    
    static func valueFor(Key : String?)->Base{
        
        guard let key = Key else {
            return Base.signup
        }
        
        //        for val in iterateEnum(Base.self) where val.rawValue == key {
        //            return val
        //        }
        
        if let base = Base(rawValue: key) {
            return base
        }
        
        return Base.signup
        
    }
}
