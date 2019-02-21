//
//  ResponseWS.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation

class ResponseWS {
    var list = [WSDevice]()
    
    init(array: [[String : AnyObject]] ) {
        list =  arrayFromDict(array: array )
    }
    
    func arrayFromDict ( array: [[String : AnyObject]] ) -> [WSDevice] {
        var deviceArray: [WSDevice] = []
        for item in array {
            let device = WSDevice.init(dictionary: item as! [String : AnyObject])
            deviceArray.append(device)
        }
        
        return deviceArray
        
    }
}

class WSDevice {
    
    var id: String?
    var name: String?
    var address: String?
    var strength: String?
    var createdAt: String?
    
    init(dictionary: [String: AnyObject]) {
        
        id          = dictionary["_id"] is NSNull ?         nil : dictionary["_id"] as! String? ?? ""
        name        = dictionary["name"] is NSNull ?        nil : dictionary["name"] as! String? ?? ""
        address     = dictionary["address"] is NSNull ?     nil : dictionary["address"] as! String? ?? ""
        strength    = dictionary["strength"] is NSNull ?    nil : dictionary["strength"] as! String? ?? ""
        createdAt   = dictionary["created_at"] is NSNull ?   nil : dictionary["created_at"] as! String? ?? ""
    }
    
}
