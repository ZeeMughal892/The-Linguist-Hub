//
//  LogoutModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class LogoutModel : Mappable {
    public var __type : String!
    public var userId : Int!
    public var iDCardNo : String!
    public var firstName : String!
    public var lastName : String!
    public var userName : String!
    public var email : String!
    public var contactNo : String!
    public var qualification : String!
    public var bandRate : String!
    public var photo : String!
    public var password : String!
    public var region : String!
    public var postCodeArea : String!
    public var passExpiryDate : String!
    public var autoAssign : String!
    public var autoAssignRequest : String!
    public var userAddress : String!
    public var userLanguages : String!
    public var userLanguagesFrom : String!
    public var userLanguagesTo : String!
    public var bookingsComplete : Int!
    public var bookingsDidNotAttend : Int!
    public var bookingsCancelled : Int!
    public var bookingsLate : Int!
    public var cancelLess24 : Int!
    public var cancelMore24 : Int!
    public var cRB : String!
    public var isEmail : String!
    public var consentGiven : String!
    public var bookingCheckLater : String!
    public var mainCharges : String!
    public var mainChargesPer : String!
    public var additionalRate : String!
    public var additionalRatePer : String!
    public var mileage : String!
    public var mileagePer : String!
    public var travellingTime : String!
    public var travellingTimePer : String!
    public var totalHours : Int!
    public var totalWords : Int!
    public var totalComplaints : Int!
    public var isNis : Bool!
    public var isBankStaff : Bool!
    public var isFullTime : Bool!
    public var isBsl : Bool!
    public var fullName : String!
    public var excludedPCAs : String!
    public var postcodeOnly : String!
    public var homeVisitPolicyAgreed : String!
    public var homeVisitPolicyAgreedDate : String!
    public var gillickPolicyAgreed : String!
    public var gillickPolicyAgreedDate : String!
    public var mentalHealthPolicyAgreed : String!
    public var mentalHealthPolicyAgreedDate : String!
    public var workingLonePolicyAgreed : String!
    public var workingLonePolicyAgreedDate : String!
    public var mentalSafeguardPolicyAgreed : String!
    public var mentalSafeguardPolicyAgreedDate : String!
    public var coronaVirusPolicyAgreed : String!
    public var coronaVirusPolicyAgreedDate : String!

   
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {   

        __type <- map["__type"]
        userId <- map["UserId"]
        iDCardNo <- map["IDCardNo"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        userName <- map["UserName"]
        email <- map["Email"]
        contactNo <- map["ContactNo"]
        qualification <- map["Qualification"]
        bandRate <- map["BandRate"]
        photo <- map["Photo"]
        password <- map["Password"]
        region <- map["Region"]
        postCodeArea <- map["PostCodeArea"]
        passExpiryDate <- map["PassExpiryDate"]
        autoAssign <- map["AutoAssign"]
        autoAssignRequest <- map["AutoAssignRequest"]
        userAddress <- map["UserAddress"]
        userLanguages <- map["UserLanguages"]
        userLanguagesFrom <- map["UserLanguagesFrom"]
        userLanguagesTo <- map["UserLanguagesTo"]
        bookingsComplete <- map["BookingsComplete"]
        bookingsDidNotAttend <- map["BookingsDidNotAttend"]
        bookingsCancelled <- map["BookingsCancelled"]
        bookingsLate <- map["BookingsLate"]
        cancelLess24 <- map["CancelLess24"]
        cancelMore24 <- map["CancelMore24"]
        cRB <- map["CRB"]
        isEmail <- map["IsEmail"]
        consentGiven <- map["ConsentGiven"]
        bookingCheckLater <- map["BookingCheckLater"]
        mainCharges <- map["MainCharges"]
        mainChargesPer <- map["MainChargesPer"]
        additionalRate <- map["AdditionalRate"]
        additionalRatePer <- map["AdditionalRatePer"]
        mileage <- map["Mileage"]
        mileagePer <- map["MileagePer"]
        travellingTime <- map["TravellingTime"]
        travellingTimePer <- map["TravellingTimePer"]
        totalHours <- map["TotalHours"]
        totalWords <- map["TotalWords"]
        totalComplaints <- map["TotalComplaints"]
        isNis <- map["IsNis"]
        isBankStaff <- map["IsBankStaff"]
        isFullTime <- map["IsFullTime"]
        isBsl <- map["IsBsl"]
        fullName <- map["FullName"]
        excludedPCAs <- map["ExcludedPCAs"]
        postcodeOnly <- map["PostcodeOnly"]
        homeVisitPolicyAgreed <- map["HomeVisitPolicyAgreed"]
        homeVisitPolicyAgreedDate <- map["HomeVisitPolicyAgreedDate"]
        gillickPolicyAgreed <- map["GillickPolicyAgreed"]
        gillickPolicyAgreedDate <- map["GillickPolicyAgreedDate"]
        mentalHealthPolicyAgreed <- map["MentalHealthPolicyAgreed"]
        mentalHealthPolicyAgreedDate <- map["MentalHealthPolicyAgreedDate"]
        workingLonePolicyAgreed <- map["WorkingLonePolicyAgreed"]
        workingLonePolicyAgreedDate <- map["WorkingLonePolicyAgreedDate"]
        mentalSafeguardPolicyAgreed <- map["MentalSafeguardPolicyAgreed"]
        mentalSafeguardPolicyAgreedDate <- map["MentalSafeguardPolicyAgreedDate"]
        coronaVirusPolicyAgreed <- map["CoronaVirusPolicyAgreed"]
        coronaVirusPolicyAgreedDate <- map["CoronaVirusPolicyAgreedDate"]
    }

}
