//
//  AbsenceItem.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 02/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class AbsenceItem : Mappable {
    
    public var UniqueId : Int!
    public var InterpreterId : Int!
    public var DateFrom : String!
    public var DateTo : String!
    public var Reason : String!
    public var Namestamp : String!
    public var Datestamp : String!
    public var InContact : Bool!
    public var DateToUkFormat : String!
    public var DateFromUkFormat : String!
    public var DatestampUkFormat : String!
    public var GetInContact : String!
    
    required public init?(map: Map){}
    init(){}
    
    public func mapping(map: Map) {
        UniqueId <- map["UniqueId"]
        InterpreterId <- map["InterpreterId"]
        DateFrom <- map["DateFrom"]
        DateTo <- map["DateTo"]
        Reason <- map["Reason"]
        Namestamp <- map["Namestamp"]
        Datestamp <- map["Datestamp"]
        InContact <- map["InContact"]
        DateToUkFormat <- map["DateToUkFormat"]
        DateFromUkFormat <- map["DateFromUkFormat"]
        DatestampUkFormat <- map["DatestampUkFormat"]
        GetInContact <- map["GetInContact"]
    }
}
