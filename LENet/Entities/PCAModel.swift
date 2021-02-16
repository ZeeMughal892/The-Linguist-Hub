//
//  PCAModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 31/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class PCAModel : Mappable {
    
    public var __type : String!
    public var ListSurroundingPCAs : [PCAs]!
    public var PostcodeOnly : Int!
    public var Status : Bool!
    public var Message : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        ListSurroundingPCAs <- map["ListSurroundingPCAs"]
        PostcodeOnly <- map["PostcodeOnly"]
        Status <- map["Status"]
        Message <- map["Message"]
       
        
    }
}
