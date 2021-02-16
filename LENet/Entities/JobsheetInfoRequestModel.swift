//
//  JobsheetInfoRequestModel.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 13/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation

public class JobsheetInfoRequestModel {
    
    static var BookingId: Int!
    static var idCardNo = ""
    static var JSSignedBy = ""
    static var JSPosition = ""
    static var Comments = ""
    static var IsFBNS = false
    static var ArriveOnTime = ""
    static var Intro = ""
    static var WearLECard = ""
    static var PreAssignment = ""
    static var CustomerCare = ""
    static var Dress = ""
    static var Satisfied = ""
    static var ClientArrive = ""
    static var ArrivalTime = ""
    static var StartTime = ""
    static var WaitingTime = ""
    static var BreakTime = ""
    static var IsNextDay = false
    static var FinishTime = ""
    static var Mileage = ""
    static var TravelTime = ""
    static var PublicTransportCost = ""
    static var OtherExpenses = ""
    static var ProfessionalSignature = ""
    static var InterpreterSignature = ""
    static var WantSameInterpreter = ""
    static var InterpreterArrived = ""
    static var Miles = ""
    static var ReturnedHome = ""
    static var TyneTunnel = ""
    static var UploadYourInvoice = ""
    static var UploadYourInvoiceExt = ""
    static var UploadPublicTransportReceipts = ""
    static var UploadPublicTransportReceiptsExt = ""
    static var StarRatingFromCustomer = ""
    static var StarRatingFromInterpreter = ""
    
    
    class var getTyneTunnel : String {
        return TyneTunnel
    }
    
    
    class var getStarRatingFromCustomer : String {
        return StarRatingFromCustomer
    }
    class var getStarRatingFromInterpreter : String {
        return StarRatingFromInterpreter
    }
    
    class var getUploadYourInvoice : String {
        return UploadYourInvoice
    }
    class var getUploadYourInvoiceExt : String {
         return UploadYourInvoiceExt
    }
    class var getUploadPublicTransportReceipts : String {
         return UploadPublicTransportReceipts
    }
    class var getUploadPublicTransportReceiptsExt : String {
         return UploadPublicTransportReceiptsExt
    }    
    class var getBookingId : Int {
         return BookingId
    }
    class var getIdCardNo : String {
        return idCardNo
    }
    class var getJSSignedBy : String {
        return JSSignedBy
    }
    class var getJSPosition : String {
        return JSPosition
    }
    class var getComments : String {
        return Comments
    }
    class var getIsFBNS : Bool {
        return IsFBNS
    }
    class var getArriveOnTime : String {
        return ArriveOnTime
    }
    class var getIntro : String {
        return Intro
    }
    class var getWearLECard : String {
        return WearLECard
    }
    class var getPreAssignment : String {
        return PreAssignment
    }
    class var getCustomerCare : String {
        return CustomerCare
    }
    class var getDress : String {
        return Dress
    }
    class var getSatisfied : String {
        return Satisfied
    }
    class var getClientArrive : String {
        return ClientArrive
    }
    class var getArrivalTime : String {
        return ArrivalTime
    }
    class var getStartTime : String {
        return StartTime
    }
    class var getWaitingTime : String {
        return WaitingTime
    }
    class var getBreakTime : String {
        return BreakTime
    }
    class var getIsNextDay : Bool {
        return IsNextDay
    }
    class var getFinishTime : String {
        return FinishTime
    }
    class var getMileage : String {
        return Mileage
    }
    class var getTravelTime : String {
        return TravelTime
    }
    class var getPublicTransportCost : String {
        return PublicTransportCost
    }
    class var getOtherExpenses : String {
        return OtherExpenses
    }
    class var getProfessionalSignature : String {
        return ProfessionalSignature
    }
    class var getInterpreterSignature : String {
        return InterpreterSignature
    }
    class var getWantSameInterpreter : String {
        return WantSameInterpreter
    }
    class var getInterpreterArrived : String {
        return InterpreterArrived
    }
    class var getMiles : String {
        return Miles
    }
    class var getReturnedHome : String {
        return ReturnedHome
    }
}
