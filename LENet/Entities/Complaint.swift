//
//  Complaint.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class Compliant : Mappable {
    public var complaintMadeBy : String!
    public var complaintDate : String!
    public var bookingRef : String!
    public var natureOfComplaintDetails : String!
    public var identifyComplaintBreach : String!
    public var responseDetails : String!
    public var apologiseBy : String!
    public var apologiseDate : String!
    public var responseUpdatedBy : String!
    public var responseUpdatedDate : String!
    public var complaintDateToUKFormate : String!
    public var apologiseDateToUKFormate : String!
    public var responseUpdatedDateToUKFormate : String!

    required public init?(map: Map){}
       init(){}
       
       public func mapping(map: Map) {
        complaintMadeBy <- map["ComplaintMadeBy"]
        complaintDate <- map["ComplaintDate"]
        bookingRef <- map["BookingRef"]
        natureOfComplaintDetails <- map["NatureOfComplaintDetails"]
        identifyComplaintBreach <- map["IdentifyComplaintBreach"]
        responseDetails <- map["ResponseDetails"]
        apologiseBy <- map["ApologiseBy"]
        apologiseDate <- map["ApologiseDate"]
        responseUpdatedBy <- map["ResponseUpdatedBy"]
        responseUpdatedDate <- map["ResponseUpdatedDate"]
        complaintDateToUKFormate <- map["ComplaintDateToUKFormate"]
        apologiseDateToUKFormate <- map["ApologiseDateToUKFormate"]
        responseUpdatedDateToUKFormate <- map["ResponseUpdatedDateToUKFormate"]
    }

}
