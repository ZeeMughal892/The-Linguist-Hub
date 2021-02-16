//
//  BookingModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 02/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//


import Foundation
import ObjectMapper

public class BookingModel : Mappable {
    public var __type : String!
    public var bookingId : Int!
    public var interpreterId : Int!
    public var clientId : Int!
    public var bookingRef : String!
    public var appointmentDate : String!
    public var dateStamp : String!
    public var bookingDuration : Int!
    public var bookingStatus : Int!
    public var jobCancelledBy : String!
    public var serviceUserGender : String!
    public var otherVenue : Int!
    public var venuePostCode : String!
    public var venueDescription : String!
    public var venueAddressLine1 : String!
    public var venueHomeAddressPostCode : String!
    public var bookingLanguageId : Int!
    public var bookingLanguage : String!
    public var venueLat : Double!
    public var venueLong : Double!
    public var region : String!
    public var postCodeArea : String!
    public var iDCardNo : String!
    public var interestsCount : Int!
    public var latestInterest : String!
    public var oneWaySMS : Int!
    public var twoWaySMS : Int!
    public var twoWayAutoSMS : Int!
    public var manualEmail : Int!
    public var companyName : String!
    public var intGender : String!
    public var description : String!
    public var isActive : Bool!
    public var appointmentDateFormatted : String!
    public var appointmentDateUKFormatted : String!
    public var appointmentTimeUKFormatted : String!
    public var dueInDays : Int!
    public var dueInDaysLabel : String!
    public var isHomeVisit : String!
    public var venuePostCodeAnon : String!
    public var venuePostCodeFull : String!
    public var interestsLink : String!
    public var availablityLink : String!
    public var bookingLink : String!
    public var latestInterestDate : String!
    public var latestInterestSortDate : String!
    public var bookingDistance : Int!
    public var bookingDistanceDouble : Int!
    public var estimatedPayment : String!
    public var appointmentWeekDay : String!
    public var mainCharges : Double!
    public var additionalRate : Double!
    public var mileage : Double!
    public var addiTravelTime : Int!
    public var travellingTime : Double!
    public var addiPublicTransport : Int!
    public var addiOther : Int!
    public var addiCongestion : Int!
    public var totalEstimatedPay : Double!
    public var mileageApplicableAfter : Int!
    public var travelTimeApplicableAfter : String!
    public var travelTimeCap : String!
    
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {
        __type <- map["__type"]
        bookingId <- map["BookingId"]
        interpreterId <- map["InterpreterId"]
        clientId <- map["ClientId"]
        bookingRef <- map["BookingRef"]
        appointmentDate <- map["AppointmentDate"]
        dateStamp <- map["DateStamp"]
        bookingDuration <- map["BookingDuration"]
        bookingStatus <- map["BookingStatus"]
        jobCancelledBy <- map["JobCancelledBy"]
        serviceUserGender <- map["ServiceUserGender"]
        otherVenue <- map["OtherVenue"]
        venuePostCode <- map["VenuePostCode"]
        venueDescription <- map["VenueDescription"]
        venueAddressLine1 <- map["VenueAddressLine1"]
        venueHomeAddressPostCode <- map["VenueHomeAddressPostCode"]
        bookingLanguageId <- map["BookingLanguageId"]
        bookingLanguage <- map["BookingLanguage"]
        venueLat <- map["VenueLat"]
        venueLong <- map["VenueLong"]
        region <- map["Region"]
        postCodeArea <- map["PostCodeArea"]
        iDCardNo <- map["IDCardNo"]
        interestsCount <- map["InterestsCount"]
        latestInterest <- map["LatestInterest"]
        oneWaySMS <- map["OneWaySMS"]
        twoWaySMS <- map["TwoWaySMS"]
        twoWayAutoSMS <- map["TwoWayAutoSMS"]
        manualEmail <- map["ManualEmail"]
        companyName <- map["CompanyName"]
        intGender <- map["IntGender"]
        description <- map["Description"]
        isActive <- map["IsActive"]
        appointmentDateFormatted <- map["AppointmentDateFormatted"]
        appointmentDateUKFormatted <- map["AppointmentDateUKFormatted"]
        appointmentTimeUKFormatted <- map["AppointmentTimeUKFormatted"]
        dueInDays <- map["DueInDays"]
        dueInDaysLabel <- map["DueInDaysLabel"]
        isHomeVisit <- map["IsHomeVisit"]
        venuePostCodeAnon <- map["VenuePostCodeAnon"]
        venuePostCodeFull <- map["VenuePostCodeFull"]
        interestsLink <- map["InterestsLink"]
        availablityLink <- map["AvailablityLink"]
        bookingLink <- map["BookingLink"]
        latestInterestDate <- map["LatestInterestDate"]
        latestInterestSortDate <- map["LatestInterestSortDate"]
        bookingDistance <- map["BookingDistance"]
        bookingDistanceDouble <- map["BookingDistanceDouble"]
        estimatedPayment <- map["EstimatedPayment"]
        appointmentWeekDay <- map["AppointmentWeekDay"]
        mainCharges <- map["MainCharges"]
        additionalRate <- map["AdditionalRate"]
        mileage <- map["Mileage"]
        addiTravelTime <- map["AddiTravelTime"]
        travellingTime <- map["TravellingTime"]
        addiPublicTransport <- map["AddiPublicTransport"]
        addiOther <- map["AddiOther"]
        addiCongestion <- map["AddiCongestion"]
        totalEstimatedPay <- map["TotalEstimatedPay"]
        travelTimeApplicableAfter <- map["travelTimeApplicableAfter"]
        travelTimeCap <- map["travelTimeCap"]
    }

}
