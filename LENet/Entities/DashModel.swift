//
//  DashModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 31/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class DashModel : Mappable {
    
    public var __type : String!
    public var List : [DashItem]!   
    public var Status : Bool!
    public var Message : String!
    public var Data : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {        
        __type <- map["__type"]
        List <- map["List"]
        Status <- map["Status"]
        Message <- map["Message"]
        Data <- map["Data"]
        
    }
}
