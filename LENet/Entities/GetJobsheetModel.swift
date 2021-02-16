//
//  GetJobsheetModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class GetJobsheetModel : Mappable {
    
    public var __type : String!
    public var BookingList : [UploadJobsheetModel]!
    public var Status : Bool!
    public var Message : String!
    public var Data : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        BookingList <- map["BookingList"]
        Status <- map["Status"]
        Message <- map["Message"]
        Data <- map["Data"]
        
    }
}
