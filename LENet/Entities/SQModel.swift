//
//  SQModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 07/08/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class SQModel : Mappable {
    
    public var __type : String!
    public var SecurityQuestion1 : String!
    public var SecurityQuestion1Answer : String!
    public var SecurityQuestion2 : String!
    public var SecurityQuestion2Answer : String!
    public var SecurityQuestion3 : String!
    public var SecurityQuestion3Answer : String!
    public var Status : Bool!
    public var Message : String!
    public var Data : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        SecurityQuestion1 <- map["SecurityQuestion1"]
        SecurityQuestion1Answer <- map["SecurityQuestion1Answer"]
        SecurityQuestion2 <- map["SecurityQuestion2"]
        SecurityQuestion2Answer <- map["SecurityQuestion2Answer"]
        SecurityQuestion3 <- map["SecurityQuestion3"]
        SecurityQuestion3Answer <- map["SecurityQuestion3Answer"]
        Status <- map["Status"]
        Message <- map["Message"]
        Data <- map["Data"]
        
    }
}
