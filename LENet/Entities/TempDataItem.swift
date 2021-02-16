//
//  TempDataItem.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 30/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class TempDataItem : Mappable {
       var actualDuration : String!
       var actualInterpreterTime : String!
       var arrivalTime : String!
       var arriveOnTime : String!
       var bookingId : Int!
       var breakTime : String!
       var comments : String!
       var didPatientArrive : String!
       var dressAppropriately : String!
       var feedbackMethod : String!
       var finishTime : String!
       var howSatisfied : String!
       var interpreterArrived : String!
       var introduceThemselves : String!
       var isNextDay : Bool!
       var jSCompletedBy : String!
       var jSCompletedPosition : String!
       var miles : String!
       var preAssignmentBriefing : String!
       var professionalSignaturePath : String!
       var qFSubmitted : Bool!
       var returnedHome : String!
       var sameInterpreterFollowUp : String!
       var showGoodCustomerCare : String!
       var starRatingFromCustomer : String!
       var startTime : String!
       var userId : Int!
       var waitingTime : String!
       var wearLECard : String!

     required public init?(map: Map){}
       init(){}
       
    public  func mapping(map: Map) {
        actualDuration <- map["ActualDuration"]
        actualInterpreterTime <- map["ActualInterpreterTime"]
        arrivalTime <- map["ArrivalTime"]
        arriveOnTime <- map["ArriveOnTime"]
        bookingId <- map["BookingId"]
        breakTime <- map["BreakTime"]
        comments <- map["Comments"]
        didPatientArrive <- map["DidPatientArrive"]
        dressAppropriately <- map["DressAppropriately"]
        feedbackMethod <- map["FeedbackMethod"]
        finishTime <- map["FinishTime"]
        howSatisfied <- map["HowSatisfied"]
        interpreterArrived <- map["InterpreterArrived"]
        introduceThemselves <- map["IntroduceThemselves"]
        isNextDay <- map["IsNextDay"]
        jSCompletedBy <- map["JSCompletedBy"]
        jSCompletedPosition <- map["JSCompletedPosition"]
        miles <- map["Miles"]
        preAssignmentBriefing <- map["PreAssignmentBriefing"]
        professionalSignaturePath <- map["ProfessionalSignaturePath"]
        qFSubmitted <- map["QFSubmitted"]
        returnedHome <- map["ReturnedHome"]
        sameInterpreterFollowUp <- map["SameInterpreterFollowUp"]
        showGoodCustomerCare <- map["ShowGoodCustomerCare"]
        starRatingFromCustomer <- map["StarRatingFromCustomer"]
        startTime <- map["StartTime"]
        userId <- map["UserId"]
        waitingTime <- map["WaitingTime"]
        wearLECard <- map["WearLECard"]
    }
    
}
