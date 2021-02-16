
import Foundation
import ObjectMapper

public class BookingCalendarModel : Mappable {
    
    public var __type : String!
    public var bookingId : Int!
    public var clientId : Int!
    public var bookingRef : String!
    public var bookingType : Int!
    public var clientNotes : String!
    public var appointmentDateDb : String!
    public var bookingDuration : Int!
    public var region : String!
    public var postCodeArea : String!
    public var status : Int!
    public var jobCancelledBy : String!
    public var jobCancelledDate : String!
    public var bookingMadeBy : String!
    public var createdDateTime : String!
    public var courtAssignment : Int!
    public var intAdditionalPayment : Int!
    public var jobSheetReturned : Int!
    public var jobSheetReturnedDate : String!
    public var jobSheetReceived : Int!
    public var jobSheetReceivedDate : String!
    public var jSReceivedOnline : Int!
    public var jSReceivedPost : Int!
    public var jSReceivedEmail : Int!
    public var jSReceivedFax : Int!
    public var jSLost : Int!
    public var jSNotReturnedByCutOff : Int!
    public var jSReceivedBy : String!
    public var jSReceivedDate : String!
    public var verbalReminder : Int!
    public var verbalReminderBy : String!
    public var verbalReminderDate : String!
    public var actualInterpreterTime : Int!
    public var actualDuration : Int!
    public var otherVenue : Int!
    public var estimatedIntPayment : Double!
    public var accountManager : String!
    public var venuePostCode : String!
    public var venueLat : Double!
    public var venueLong : Double!
    public var bookingLanguageId : Int!
    public var bookingLanguage : String!
    public var interpreterId : Int!
    public var interpreterFirstName : String!
    public var interpreterLastName : String!
    public var interpreterMobile1 : String!
    public var interpreterMobile2 : String!
    public var interpreterEmail : String!
    public var iDCardNo : String!
    public var rateType : String!
    public var companyName : String!
    public var cancellationTerms : Int!
    public var cancellationTermsNonSpoken : Int!
    public var mileageApplicableAfter : Int!
    public var additionalRatePer : String!
    public var travelTime2 : Int!
    public var mileage2 : Int!
    public var publicTransport : Double!
    public var otherPay : Double!
    public var approved : Int!
    public var paymentMade : Int!
    public var dontPayInterpreter : Int!
    public var paymentAccepted : Int!
    public var interpreterTotalPay : Double!
    public var totalMileage : Int!
    public var interpreterMileagePay : Double!
    public var interpreterTravelTimePay : Double!
    public var interpreterTravelExpensesPay : Double!
    public var interpreterParkingPay : Double!
    public var interpreterOtherPay : Double!
    public var interpreterPay : Double!
    public var queryStatus : String!
    public var addiPayAmount : String!
    public var lateCount : Int!
    public var dnaCount : Int!
    public var formName : String!
    public var description : String!
    public var isFeedbackForm : String!
    public var queryStatusString : String!
    public var isAssigned : Bool!
    public var interpreterAssignedName : String!
    public var bookingTypeLabel : String!
    public var bookingTypeUserLabel : String!
    public var isActive : Bool!
    public var bookingStatus : String!
    public var jobSheetReturnedString : String!
    public var jobSheetReturnedDateString : String!
    public var appointmentDateString : String!
    public var appointmentDateTimeUkFormatted : String!
    public var viewLink : String!
    public var downloadJobsheetLink : String!
    public var uploadJobsheetLink : String!
    public var jobSheetDownloadedString : String!
    public var jobSheetReceivedDateString : String!
    public var payemntLink : String!
    public var paymentQueryLink : String!
    public var timeRemaining : String!
    public var venuePostCodeString : String!
    public var getStatus : String!
    public var jobCancelledBYAndDateString : String!
    public var getReturnTime : String!
    public var appointmentDateUKFormatted : String!
    public var appointmentTimeUKFormatted : String!
    public var appointmentDate : String!
    
    
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
