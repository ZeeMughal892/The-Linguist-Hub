//
//  UserProfileModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 06/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//


import Foundation
import ObjectMapper

public class UserProfileModel : Mappable {
    public var __type : String!
    public var userId : Int!
    public var iDCardNo : String!
    public var firstName : String!
    public var lastName : String!
    public var email : String!
    public var gender : String!
    public var mobile : String!
    public var region : String!
    public var postCodeArea : String!
    public var isActive : Int!
    public var status : Int!
    public var password : String!
    public var photo : String!
    public var isEmail : Int!
    public var nis : Int!
    public var bankStaff : Int!
    public var qualification : String!
    public var rateType : String!
    public var fullTIme : Int!
    public var latitude : Double!
    public var longitude : Double!
    public var addressLine1 : String!
    public var addressLine2 : String!
    public var addressLine3 : String!
    public var addressLine4 : String!
    public var userPostCode : String!
    public var county : String!
    public var country : String!
    public var languageIdList : String!
    public var vettingLevel : String!
    public var expiryDate : String!
    public var bslInt : Int!
    public var bookingsComplete : Int!
    public var excludedPCA : String!
    public var postcodeOnly : Int!
    public var bookingCheckLater : String!
    public var ratesOfPayAgreed : Int!
    public var mainCharges : String!
    public var autoAssign : Int!
    public var autoAssignRequest : Int!
    public var chargesMainCharges : String!
    public var additionalRate : String!
    public var travellingTime : String!
    public var mileage : String!
    public var isDbsIca : Bool!
    public var isNis : Bool!
    public var isNisBankStaff : Bool!
    public var qualificationCheck : Bool!
    public var qualificationCheckMessage : String!
    public var dbsFailMessage : String!
    public var fullName : String!
    public var getUserAddress : String!
    public var isLogin : Bool!
    public var policeClients : String!
    public var showMessageAfterLoginOnMobile : Bool!
    public var messageAfterLoginOnMobile : String!
    public var userPostCodeShort : String!
    public var allowLater : Bool!
    public var hasPenalty : Bool!
    public var isBankStaff : Bool!
    public var isRemindersPending : Bool!
    public var bandRate : String!
    public var penaltyText : String!
    public var profileImage : String!
    public var locationEnabled : Bool!
    public var locationIntervalInMinutes : Int!
    public var lEContactNo : String!
    public var lEContactEmail : String!
    public var showSystemUpdates : Bool!
    public var noticeBoard : String!
    public var noticeBoardTitle : String!
    public var showJobSheet : Bool!
    public var noticeBoardLink : String!
    public var isFullTime : Bool!
    public var ratingsDetails : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {        
        __type <- map["__type"]
        userId <- map["UserId"]
        iDCardNo <- map["IDCardNo"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
        email <- map["Email"]
        gender <- map["Gender"]
        mobile <- map["Mobile"]
        region <- map["Region"]
        postCodeArea <- map["PostCodeArea"]
        isActive <- map["IsActive"]
        status <- map["Status"]
        password <- map["Password"]
        photo <- map["Photo"]
        isEmail <- map["IsEmail"]
        nis <- map["Nis"]
        bankStaff <- map["BankStaff"]
        qualification <- map["Qualification"]
        rateType <- map["RateType"]
        fullTIme <- map["FullTIme"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        addressLine1 <- map["AddressLine1"]
        addressLine2 <- map["AddressLine2"]
        addressLine3 <- map["AddressLine3"]
        addressLine4 <- map["AddressLine4"]
        userPostCode <- map["UserPostCode"]
        county <- map["County"]
        country <- map["Country"]
        languageIdList <- map["LanguageIdList"]
        vettingLevel <- map["VettingLevel"]
        expiryDate <- map["ExpiryDate"]
        bslInt <- map["BslInt"]
        bookingsComplete <- map["BookingsComplete"]
        excludedPCA <- map["ExcludedPCA"]
        postcodeOnly <- map["PostcodeOnly"]
        bookingCheckLater <- map["BookingCheckLater"]
        ratesOfPayAgreed <- map["RatesOfPayAgreed"]
        mainCharges <- map["MainCharges"]
        autoAssign <- map["AutoAssign"]
        autoAssignRequest <- map["AutoAssignRequest"]
        chargesMainCharges <- map["ChargesMainCharges"]
        additionalRate <- map["AdditionalRate"]
        travellingTime <- map["TravellingTime"]
        mileage <- map["Mileage"]
        isDbsIca <- map["IsDbsIca"]
        isNis <- map["IsNis"]
        isNisBankStaff <- map["IsNisBankStaff"]
        qualificationCheck <- map["QualificationCheck"]
        qualificationCheckMessage <- map["QualificationCheckMessage"]
        dbsFailMessage <- map["DbsFailMessage"]
        fullName <- map["FullName"]
        getUserAddress <- map["GetUserAddress"]
        isLogin <- map["IsLogin"]
        policeClients <- map["PoliceClients"]
        showMessageAfterLoginOnMobile <- map["ShowMessageAfterLoginOnMobile"]
        messageAfterLoginOnMobile <- map["MessageAfterLoginOnMobile"]
        userPostCodeShort <- map["UserPostCodeShort"]
        allowLater <- map["AllowLater"]
        hasPenalty <- map["HasPenalty"]
        isBankStaff <- map["IsBankStaff"]
        isRemindersPending <- map["IsRemindersPending"]
        bandRate <- map["BandRate"]
        penaltyText <- map["PenaltyText"]
        profileImage <- map["ProfileImage"]
        locationEnabled <- map["LocationEnabled"]
        locationIntervalInMinutes <- map["LocationIntervalInMinutes"]
        lEContactNo <- map["LEContactNo"]
        lEContactEmail <- map["LEContactEmail"]
        showSystemUpdates <- map["ShowSystemUpdates"]
        noticeBoard <- map["NoticeBoard"]
        noticeBoardTitle <- map["NoticeBoardTitle"]
        showJobSheet <- map["ShowJobSheet"]
        noticeBoardLink <- map["NoticeBoardLink"]
        isFullTime <- map["IsFullTime"]
        ratingsDetails <- map["RatingsDetails"]
    }

}
