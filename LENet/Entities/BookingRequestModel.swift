//
//  BookingRequestModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 27/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class BookingRequestModel : Mappable {
    public var __type : String!
    public var bookingId : Int!
    public var interpreterId : Int!
    public var clientId : Int!
    public var cancellationTerms : Int!
    public var bookingRef : String!
    public var appointmentDate : String!
    public var dateStamp : String!
    public var bookingDuration : Int!
    public var actualDuration : Int!
    public var bookingStatus : Int!
    public var jobCancelledBy : String!
    public var jobCancelledDate : String!
    public var serviceUserGender : String!
    public var otherVenue : Int!
    public var venuePostCode : String!
    public var venueDescription : String!
    public var venueAddressLine1 : String!
    public var venueAddressLine2 : String!
    public var venueAddressLine3 : String!
    public var venueAddressLine4 : String!
    public var venueAddressCounty : String!
    public var venueHomeAddressPostCode : String!
    public var homeVisitAddress : String!
    public var bookingLanguageId : Int!
    public var bookingLanguage : String!
    public var venueLat : Double!
    public var venueLong : Double!
    public var region : String!
    public var postCodeArea : String!
    public var iDCardNo : String!
    public var companyName : String!
    public var intGender : String!
    public var description : String!
    public var mileageApplicableAfter : Int!
    public var addiOther : Int!
    public var addiCongestion : Int!
    public var advancedIntsCount : Int!
    public var addiTravelTime : Int!
    public var addiPublicTransport : Int!
    public var distance : String!
    public var mileage : String!
    public var isActive : Bool!
    public var appointmentDateFormatted : String!
    public var appointmentDateUKFormatted : String!
    public var appointmentTimeUKFormatted : String!
    public var appointmentDateTimeUKFormatted : String!
    public var dueInDays : Int!
    public var dueInDaysLabel : String!
    public var isHomeVisit : String!
    public var venuePostCodeAnon : String!
    public var venuePostCodeFull : String!
    public var bookingDistance : Int!
    public var travelTime : Int!
    public var bookingDistanceDouble : Int!
    public var getBookingAddress : String!
    public var getParking : String!
    public var getCongestionCharge : String!
    public var getTravelTimePayable : String!
    public var getPublicTransport : String!

  
    required public init?(map: Map){}
    init(){}
    
    public  func mapping(map: Map) {

        __type <- map["__type"]
        bookingId <- map["BookingId"]
        interpreterId <- map["InterpreterId"]
        clientId <- map["ClientId"]
        cancellationTerms <- map["CancellationTerms"]
        bookingRef <- map["BookingRef"]
        appointmentDate <- map["AppointmentDate"]
        dateStamp <- map["DateStamp"]
        bookingDuration <- map["BookingDuration"]
        actualDuration <- map["ActualDuration"]
        bookingStatus <- map["BookingStatus"]
        jobCancelledBy <- map["JobCancelledBy"]
        jobCancelledDate <- map["JobCancelledDate"]
        serviceUserGender <- map["ServiceUserGender"]
        otherVenue <- map["OtherVenue"]
        venuePostCode <- map["VenuePostCode"]
        venueDescription <- map["VenueDescription"]
        venueAddressLine1 <- map["VenueAddressLine1"]
        venueAddressLine2 <- map["VenueAddressLine2"]
        venueAddressLine3 <- map["VenueAddressLine3"]
        venueAddressLine4 <- map["VenueAddressLine4"]
        venueAddressCounty <- map["VenueAddressCounty"]
        venueHomeAddressPostCode <- map["VenueHomeAddressPostCode"]
        homeVisitAddress <- map["HomeVisitAddress"]
        bookingLanguageId <- map["BookingLanguageId"]
        bookingLanguage <- map["BookingLanguage"]
        venueLat <- map["VenueLat"]
        venueLong <- map["VenueLong"]
        region <- map["Region"]
        postCodeArea <- map["PostCodeArea"]
        iDCardNo <- map["IDCardNo"]
        companyName <- map["CompanyName"]
        intGender <- map["IntGender"]
        description <- map["Description"]
        mileageApplicableAfter <- map["MileageApplicableAfter"]
        addiOther <- map["AddiOther"]
        addiCongestion <- map["AddiCongestion"]
        advancedIntsCount <- map["AdvancedIntsCount"]
        addiTravelTime <- map["AddiTravelTime"]
        addiPublicTransport <- map["AddiPublicTransport"]
        distance <- map["Distance"]
        mileage <- map["Mileage"]
        isActive <- map["IsActive"]
        appointmentDateFormatted <- map["AppointmentDateFormatted"]
        appointmentDateUKFormatted <- map["AppointmentDateUKFormatted"]
        appointmentTimeUKFormatted <- map["AppointmentTimeUKFormatted"]
        appointmentDateTimeUKFormatted <- map["AppointmentDateTimeUKFormatted"]
        dueInDays <- map["DueInDays"]
        dueInDaysLabel <- map["DueInDaysLabel"]
        isHomeVisit <- map["IsHomeVisit"]
        venuePostCodeAnon <- map["VenuePostCodeAnon"]
        venuePostCodeFull <- map["VenuePostCodeFull"]
        bookingDistance <- map["BookingDistance"]
        travelTime <- map["TravelTime"]
        bookingDistanceDouble <- map["BookingDistanceDouble"]
        getBookingAddress <- map["GetBookingAddress"]
        getParking <- map["GetParking"]
        getCongestionCharge <- map["GetCongestionCharge"]
        getTravelTimePayable <- map["GetTravelTimePayable"]
        getPublicTransport <- map["GetPublicTransport"]
    }

}
