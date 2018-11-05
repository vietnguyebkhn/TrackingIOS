//
//  EventDataVO.swift
//  VTAM
//
//  Created by Fate on 11/5/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

import Foundation

class  EventDataVO{
    var property = ""
    var value = ""
    
    
    init(data: [String: AnyObject]) {
        property = data["property"] as? String ?? ""
        value = data["value"] as? String ?? ""
    }
    
    func toJsonString() -> [String : Any] {
        var parameters =  [String : Any]()
        
        parameters["property"] = property
        parameters["value"] = value
        
        return parameters
    }
}
