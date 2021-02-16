//
//  SystemUpdatesModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 05/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class SystemUpdatesModel : Mappable {
    
    public var __type : String!
    public var Id : Int!
    public var IPhoneVersionNo : String!
    public var AndroidVersionNo : String!
    public var WebVersionNo : String!
    public var IssueDetails : String!
    public var DetailOfChanges : String!
    public var IssueDate : String!
    public var DateImplemented : String!
    public var DateImplementedUKFormatted : String!
    public var Created : String!
    public var CreatedBy : Int!
    public var VersionUpdateModule : Int!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        Id <- map["Id"]
        IPhoneVersionNo <- map["IPhoneVersionNo"]
        AndroidVersionNo <- map["AndroidVersionNo"]
        WebVersionNo <- map["WebVersionNo"]
        IssueDetails <- map["IssueDetails"]
        DetailOfChanges <- map["DetailOfChanges"]
        IssueDate <- map["IssueDate"]
        DateImplemented <- map["DateImplemented"]
        DateImplementedUKFormatted <- map["DateImplementedUKFormatted"]
        Created <- map["Created"]
        CreatedBy <- map["CreatedBy"]
        VersionUpdateModule <- map["VersionUpdateModule"]
        
    }
}
