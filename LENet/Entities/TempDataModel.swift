//
//  TempDataModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 30/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class TempDataModel : Mappable {
    
    public var __type : String!
    public var JobSheetList : [TempDataItem]!
    public var Status : Bool!
    public var Message : String!
    public var Data : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        JobSheetList <- map["JobSheetList"]
        Status <- map["Status"]
        Message <- map["Message"]
        Data <- map["Data"]
        
    }
}
