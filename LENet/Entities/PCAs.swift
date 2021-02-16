//
//  PCAs.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 31/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class PCAs : Mappable {
    
    public var IsChecked : Bool!
    public var Name : String!
    
    required public init?(map: Map){}
    init(){}
    
    public func mapping(map: Map) {
        IsChecked <- map["IsChecked"]
        Name <- map["Name"]
    }
}
