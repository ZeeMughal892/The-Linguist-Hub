//
//  DashboardItem.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 31/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class DashItem : Mappable {
    
    public var ColorCode : String!
    public var Title : String!
    public var Description : String!
    public var Value : String!
    public var Icon : String!
    
    required public init?(map: Map){}
    init(){}
    
    public func mapping(map: Map) {
        ColorCode <- map["ColorCode"]
        Title <- map["Title"]
        Description <- map["Description"]
        Value <- map["Value"]
        Icon <- map["Icon"]
    }
}
