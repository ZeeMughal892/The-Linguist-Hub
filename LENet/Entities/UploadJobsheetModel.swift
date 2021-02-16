//
//  UploadJobsheetModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 07/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//


import Foundation
import ObjectMapper

public class UploadJobsheetModel : Mappable {
    var __type : String!
    var bookingId : Int!
    var clientId : Int!
    var bookingRef : String!
    var bookingType : Int!
    var clientNotes : String!
    var appointmentDateDb : String!
    var bookingDuration : Int!
    var region : String!
    var postCodeArea : String!
    var status : Int!
    var jobCancelledBy : String!
    var jobCancelledDate : String!
    var bookingMadeBy : String!
    var createdDateTime : String!
    var courtAssignment : Int!
    var intAdditionalPayment : Int!
    var jobSheetReturned : Int!
    var jobSheetReturnedDate : String!
    var jobSheetReceived : Int!
    var jobSheetReceivedDate : String!
    var jSReceivedOnline : Int!
    var jSReceivedPost : Int!
    var jSReceivedEmail : Int!
    var jSReceivedFax : Int!
    var jSLost : Int!
    var jSNotReturnedByCutOff : Int!
    var jSReceivedBy : String!
    var jSReceivedDate : String!
    var verbalReminder : Int!
    var verbalReminderBy : String!
    var verbalReminderDate : String!
    var actualInterpreterTime : Int!
    var actualDuration : Int!
    var otherVenue : Int!
    var estimatedIntPayment : Double!
    var accountManager : String!
    var venuePostCode : String!
    var venueLat : Double!
    var venueLong : Double!
    var bookingLanguageId : Int!
    var bookingLanguage : String!
    var interpreterId : Int!
    var interpreterFirstName : String!
    var interpreterLastName : String!
    var interpreterMobile1 : String!
    var interpreterMobile2 : String!
    var interpreterEmail : String!
    var iDCardNo : String!
    var rateType : String!
    var companyName : String!
    var cancellationTerms : Int!
    var cancellationTermsNonSpoken : Int!
    var mileageApplicableAfter : Int!
    var additionalRatePer : String!
    var travelTime2 : Int!
    var mileage2 : Int!
    var publicTransport : Double!
    var otherPay : Double!
    var approved : Int!
    var paymentMade : Int!
    var dontPayInterpreter : Int!
    var paymentAccepted : Int!
    var interpreterTotalPay : Double!
    var totalMileage : Int!
    var interpreterMileagePay : Double!
    var interpreterTravelTimePay : Double!
    var interpreterTravelExpensesPay : Double!
    var interpreterParkingPay : Double!
    var interpreterOtherPay : Double!
    var interpreterPay : Double!
    var queryStatus : String!
    var addiPayAmount : String!
    var lateCount : Int!
    var dnaCount : Int!
    var formName : String!
    var description : String!
    var isFeedbackForm : String!
    var queryStatusString : String!
    var isAssigned : Bool!
    var interpreterAssignedName : String!
    var bookingTypeLabel : String!
    var bookingTypeUserLabel : String!
    var isActive : Bool!
    var bookingStatus : String!
    var jobSheetReturnedString : String!
    var jobSheetReturnedDateString : String!
    var appointmentDateString : String!
    var appointmentDateTimeUkFormatted : String!
    var viewLink : String!
    var downloadJobsheetLink : String!
    var uploadJobsheetLink : String!
    var jobSheetDownloadedString : String!
    var jobSheetReceivedDateString : String!
    var payemntLink : String!
    var paymentQueryLink : String!
    var timeRemaining : String!
    var venuePostCodeString : String!
    var getStatus : String!
    var jobCancelledBYAndDateString : String!
    var getReturnTime : String!
    var appointmentDateUKFormatted : String!
    var appointmentTimeUKFormatted : String!
    var appointmentDate : String!

     required public init?(map: Map){}
       init(){}
       
       public  func mapping(map: Map) {

        __type <- map["__type"]
        bookingId <- map["BookingId"]
        clientId <- map["ClientId"]
        bookingRef <- map["BookingRef"]
        bookingType <- map["BookingType"]
        clientNotes <- map["ClientNotes"]
        appointmentDateDb <- map["AppointmentDateDb"]
        bookingDuration <- map["BookingDuration"]
        region <- map["Region"]
        postCodeArea <- map["PostCodeArea"]
        status <- map["Status"]
        jobCancelledBy <- map["JobCancelledBy"]
        jobCancelledDate <- map["JobCancelledDate"]
        bookingMadeBy <- map["BookingMadeBy"]
        createdDateTime <- map["CreatedDateTime"]
        courtAssignment <- map["CourtAssignment"]
        intAdditionalPayment <- map["IntAdditionalPayment"]
        jobSheetReturned <- map["JobSheetReturned"]
        jobSheetReturnedDate <- map["JobSheetReturnedDate"]
        jobSheetReceived <- map["JobSheetReceived"]
        jobSheetReceivedDate <- map["JobSheetReceivedDate"]
        jSReceivedOnline <- map["JSReceivedOnline"]
        jSReceivedPost <- map["JSReceivedPost"]
        jSReceivedEmail <- map["JSReceivedEmail"]
        jSReceivedFax <- map["JSReceivedFax"]
        jSLost <- map["JSLost"]
        jSNotReturnedByCutOff <- map["JSNotReturnedByCutOff"]
        jSReceivedBy <- map["JSReceivedBy"]
        jSReceivedDate <- map["JSReceivedDate"]
        verbalReminder <- map["VerbalReminder"]
        verbalReminderBy <- map["VerbalReminderBy"]
        verbalReminderDate <- map["VerbalReminderDate"]
        actualInterpreterTime <- map["ActualInterpreterTime"]
        actualDuration <- map["ActualDuration"]
        otherVenue <- map["OtherVenue"]
        estimatedIntPayment <- map["EstimatedIntPayment"]
        accountManager <- map["AccountManager"]
        venuePostCode <- map["VenuePostCode"]
        venueLat <- map["VenueLat"]
        venueLong <- map["VenueLong"]
        bookingLanguageId <- map["BookingLanguageId"]
        bookingLanguage <- map["BookingLanguage"]
        interpreterId <- map["InterpreterId"]
        interpreterFirstName <- map["InterpreterFirstName"]
        interpreterLastName <- map["InterpreterLastName"]
        interpreterMobile1 <- map["InterpreterMobile1"]
        interpreterMobile2 <- map["InterpreterMobile2"]
        interpreterEmail <- map["InterpreterEmail"]
        iDCardNo <- map["IDCardNo"]
        rateType <- map["RateType"]
        companyName <- map["CompanyName"]
        cancellationTerms <- map["CancellationTerms"]
        cancellationTermsNonSpoken <- map["CancellationTermsNonSpoken"]
        mileageApplicableAfter <- map["MileageApplicableAfter"]
        additionalRatePer <- map["AdditionalRatePer"]
        travelTime2 <- map["TravelTime2"]
        mileage2 <- map["Mileage2"]
        publicTransport <- map["PublicTransport"]
        otherPay <- map["OtherPay"]
        approved <- map["Approved"]
        paymentMade <- map["PaymentMade"]
        dontPayInterpreter <- map["DontPayInterpreter"]
        paymentAccepted <- map["PaymentAccepted"]
        interpreterTotalPay <- map["InterpreterTotalPay"]
        totalMileage <- map["TotalMileage"]
        interpreterMileagePay <- map["InterpreterMileagePay"]
        interpreterTravelTimePay <- map["InterpreterTravelTimePay"]
        interpreterTravelExpensesPay <- map["InterpreterTravelExpensesPay"]
        interpreterParkingPay <- map["InterpreterParkingPay"]
        interpreterOtherPay <- map["InterpreterOtherPay"]
        interpreterPay <- map["InterpreterPay"]
        queryStatus <- map["QueryStatus"]
        addiPayAmount <- map["AddiPayAmount"]
        lateCount <- map["LateCount"]
        dnaCount <- map["DnaCount"]
        formName <- map["FormName"]
        description <- map["Description"]
        isFeedbackForm <- map["IsFeedbackForm"]
        queryStatusString <- map["QueryStatusString"]
        isAssigned <- map["IsAssigned"]
        interpreterAssignedName <- map["InterpreterAssignedName"]
        bookingTypeLabel <- map["BookingTypeLabel"]
        bookingTypeUserLabel <- map["BookingTypeUserLabel"]
        isActive <- map["IsActive"]
        bookingStatus <- map["BookingStatus"]
        jobSheetReturnedString <- map["JobSheetReturnedString"]
        jobSheetReturnedDateString <- map["JobSheetReturnedDateString"]
        appointmentDateString <- map["AppointmentDateString"]
        appointmentDateTimeUkFormatted <- map["AppointmentDateTimeUkFormatted"]
        viewLink <- map["ViewLink"]
        downloadJobsheetLink <- map["DownloadJobsheetLink"]
        uploadJobsheetLink <- map["UploadJobsheetLink"]
        jobSheetDownloadedString <- map["JobSheetDownloadedString"]
        jobSheetReceivedDateString <- map["JobSheetReceivedDateString"]
        payemntLink <- map["PayemntLink"]
        paymentQueryLink <- map["PaymentQueryLink"]
        timeRemaining <- map["TimeRemaining"]
        venuePostCodeString <- map["VenuePostCodeString"]
        getStatus <- map["GetStatus"]
        jobCancelledBYAndDateString <- map["JobCancelledBYAndDateString"]
        getReturnTime <- map["GetReturnTime"]
        appointmentDateUKFormatted <- map["AppointmentDateUKFormatted"]
        appointmentTimeUKFormatted <- map["AppointmentTimeUKFormatted"]
        appointmentDate <- map["AppointmentDate"]
    }

}
