//
//  D.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 27/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class LoginModel : Mappable {
    public var __type : String!
    public var ProfileImage : String!
    public var UserId : Int!
    public var IDCardNo : String!
    public var FirstName : String!
    public var LastName : String!
    public var UserName : String!
    public var Email : String!
    public var Result : Bool!
    public var Message : String!
    public var NoBookingsAvailable : String!
    public var TwoFACode : String!
    
    required public init?(map: Map){}
    init(){}
    
    public func mapping(map: Map) {
        __type <- map["__type"]
        ProfileImage <- map["ProfileImage"]
        UserId <- map["UserId"]
        IDCardNo <- map["IDCardNo"]
        FirstName <- map["FirstName"]
        LastName <- map["LastName"]
        UserName <- map["UserName"]
        Result <- map["Result"]
        Message <- map["Message"]
        Email <- map["Email"]
        NoBookingsAvailable <- map["NoBookingsAvailable"]
        TwoFACode <- map["TwoFACode"]
    }
}
