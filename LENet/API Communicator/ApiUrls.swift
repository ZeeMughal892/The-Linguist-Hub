
import Foundation
import Alamofire

public class Connnectivity  {
    class var isInternetConnected : Bool {
        let connected = NetworkReachabilityManager()!.isReachable
        return connected;
    }
}

public struct ApiUrls {
    
    //static let localUrl = "http://192.168.18.24/MobileAPIs/ServicePortal.asmx/"
    static let baseUrl = "https://secure.language-empire.net/v2sp/MobileAPIs/ServicePortal.asmx/"
    static let imgProfile = "https://secure.language-empire.net"
    static let jobsheetDownload = "http://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx"
    
    static let logoutUser = "\(ApiUrls.baseUrl)Logout"
    static let loginUser = "\(ApiUrls.baseUrl)LoginV3"
    static let forgotPassword = "\(ApiUrls.baseUrl)ForgotPassword"
    static let resendCode = "\(ApiUrls.baseUrl)ResendCode"
    
    ///Dashboard
    static let dashboard = "\(ApiUrls.baseUrl)DashboardStats"
    ///Dashboard Bookings List
    static let allBookings = "\(ApiUrls.baseUrl)LoadAllBooking"
    
    ///Available Booking Page Calls
    static let availableBooking = "\(ApiUrls.baseUrl)CurrentBookings"
    static let saveInterest = "\(ApiUrls.baseUrl)SaveInterest"
    static let declineInterest = "\(ApiUrls.baseUrl)DeclineInterest"
    
    ///Booking Reminders
    static let bookingReminders = "\(ApiUrls.baseUrl)LoadBookingAttendance"
    static let updateReminders = "\(ApiUrls.baseUrl)UpdateAttendance"
    static let laterReminders = "\(ApiUrls.baseUrl)Later"
    
    ///Booking Calander
    static let bookingCalendar = "\(ApiUrls.baseUrl)BookingCalendar"
    ///Booking Requests
    static let bookingRequests = "\(ApiUrls.baseUrl)BookingPendingRequests"
    static let SubmitBookingRequests = "\(ApiUrls.baseUrl)ProcessBookingPendingRequests"
    
    //Get Show Pin
     static let getShowPin = "\(ApiUrls.baseUrl)GetShowPin"
    
    ///Upload Jobsheet E-Signature
    static let getUploadJobsheet = "\(ApiUrls.baseUrl)GetUploadBookingJobsheets"
    static let uploadJobSheetInformation = "\(ApiUrls.baseUrl)UploadJobSheetInformation"
    
    ///Temp Jobsheet Info
    static let getDisplayTempUploadJobSheet = "\(ApiUrls.baseUrl)GetDisplayTempUploadJobSheet"
    static let insertTempJobSheetInformation = "\(ApiUrls.baseUrl)TempJobSheetInformation"
    
    static let feedback = "\(ApiUrls.baseUrl)SendFeedback"
    static let reportAnIssue = "\(ApiUrls.baseUrl)ReportAnIssue"
    
    ///Settings
    static let getPCA = "\(ApiUrls.baseUrl)GetPCASetting"
    static let updatePCA = "\(ApiUrls.baseUrl)UpdatePCASetting"
    
    ///User Profile
    static let userProfile = "\(ApiUrls.baseUrl)Profile"
    static let updateUserProfile = "\(ApiUrls.baseUrl)RequestForProfileDataChange"
    static let UpdateNameAddress = "\(ApiUrls.baseUrl)UpdateNameAddress"
   
    static let updateEmail = "\(ApiUrls.baseUrl)UpdateEmail"
    static let updateEmailConfirm = "\(ApiUrls.baseUrl)UpdateEmailConfirm"

    static let updatePhone = "\(ApiUrls.baseUrl)UpdateMobile"
    static let updatePhoneConfirm = "\(ApiUrls.baseUrl)UpdateMobileConfirm"
    
    
    static let loadAbsence = "\(ApiUrls.baseUrl)LoadHolidays"
    static let createAbsence = "\(ApiUrls.baseUrl)CreateHoliday"
    static let deleteAbsence = "\(ApiUrls.baseUrl)DeleteHoliday"
    static let updateEmailNotification = "\(ApiUrls.baseUrl)UpdateEmailSetting"
    
    ///System Updates
    static let getSystemUpdates = "\(ApiUrls.baseUrl)GetVersionUpdateViewModel"
    static let helpUsImprove = "\(ApiUrls.baseUrl)HelpUsImprove"
    static let contactUs = "\(ApiUrls.baseUrl)ContactUs"
    
}
