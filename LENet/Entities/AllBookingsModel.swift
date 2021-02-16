//
//  BookingsModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 04/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class AllBookingsModel : Mappable {
    
    public var __type : String!
    public var BookingList : [AllBookings]!    
    public var BookingDnaList : [AllBookings]!
    public var BookingLateList : [AllBookings]!
    public var CompliantList : [Compliant]!
    public var Status : Bool!
    public var Message : String!
    public var Data : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        BookingList <- map["BookingList"]
        BookingDnaList <- map["BookingDnaList"]
        BookingLateList <- map["BookingLateList"]
        CompliantList <- map["CompliantList"]
        Status <- map["Status"]
        Message <- map["Message"]
        Data <- map["Data"]
        
    }
}
