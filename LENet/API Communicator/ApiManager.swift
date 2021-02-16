
import Foundation
import PromiseKit
import AlamofireObjectMapper
import RappleProgressHUD
import Alamofire


class ApiManager{
    static let api = ApiManager()
    private init(){
    }
    ///Login
    func Login(method:String,url:String,request:LoginRequest,viewController:UIViewController) -> Promise<LoginResponse> {
        var obj = LoginResponse();
        let parameter = [
            "idcardno": request.idcardno!,
            "email": request.email!,
            "password": request.password!,
            "deviceId": request.deviceId!,
            "deviceType": request.deviceType!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<LoginResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<LoginResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///LogOut
    func LogOut(method:String,url:String,request:LogoutRequest,viewController:UIViewController) -> Promise<LogoutResponse> {
        var obj = LogoutResponse();
        let parameter = [
            "idcardno": request.idcardno!,
            "email": request.email!,
            "mobile": request.mobile!,
            "surname": request.surname!,
            "deviceId": request.deviceId!,
            "deviceType": request.deviceType!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<LogoutResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<LogoutResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Forgot Password
    func ForgotPassword(method:String,url:String,request:ForgotPasswordRequest,viewController:UIViewController) -> Promise<ForgotPasswordResponse> {
        var obj = ForgotPasswordResponse();
        let parameter = [
            "idcardno": request.idcardno!,
            "email": request.email!,
            "phone": request.phone!,
            "deviceId": request.deviceId!,
            "deviceType": request.deviceType!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<ForgotPasswordResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<ForgotPasswordResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Resend Code
    func ResendCode(method:String,url:String,request:ResendCodeRequest,viewController:UIViewController) -> Promise<ResendCodeResponse> {
        var obj = ResendCodeResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<ResendCodeResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<ResendCodeResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Dashboard
    func Dashboard(method:String,url:String,request:DashboardRequest,viewController:UIViewController) -> Promise<DashboardResponse> {
        var obj = DashboardResponse();
        let parameter = [
            "idCardNo": request.idcardno!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<DashboardResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<DashboardResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Dashboard Bookings List
    func AllBookings(method:String,url:String,request:AllBookingsRequest,viewController:UIViewController) -> Promise<AllBookingsResponse> {
        var obj = AllBookingsResponse();
        let parameter = [
            "IdCardNo": request.IdCardNo!,
            "Title": request.Title!,
            "Type": request.type!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<AllBookingsResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<AllBookingsResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Bookings Reminders
    func BookingReminders(method:String,url:String,request:BookingRemindersRequest,viewController:UIViewController) -> Promise<BookingRemindersResponse> {
        var obj = BookingRemindersResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<BookingRemindersResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<BookingRemindersResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Update Reminders
    func UpdateReminders(method:String,url:String,request:UpdateRemindersRequest,viewController:UIViewController) -> Promise<UpdateRemindersResponse> {
        var obj = UpdateRemindersResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "bookingCSV" : request.bookingCSV!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateRemindersResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateRemindersResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Later Reminders
    func LaterReminders(method:String,url:String,request:UpdateRemindersRequest,viewController:UIViewController) -> Promise<UpdateRemindersResponse> {
        var obj = UpdateRemindersResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateRemindersResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateRemindersResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Available Bookings
    func AvailableBooking(method:String,url:String,request:AvailableBookingRequest,viewController:UIViewController) -> Promise<AvailableBookingResponse> {
        var obj = AvailableBookingResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<AvailableBookingResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<AvailableBookingResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Save Interest
    func SaveInterest(method:String,url:String,request:InterestRequest,viewController:UIViewController) -> Promise<InterestResponse> {
        var obj = InterestResponse();
        let parameter = [
            "userId": request.userId!,
            "idCardNo": request.idCardNo!,
            "bookingId": request.bookingId!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<InterestResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<InterestResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Decline Interest
    func DeclineInterest(method:String,url:String,request:InterestRequest,viewController:UIViewController) -> Promise<InterestResponse> {
        var obj = InterestResponse();
        let parameter = [
            "userId": request.userId!,
            "idCardNo": request.idCardNo!,
            "bookingId": request.bookingId!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<InterestResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<InterestResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Booking Calendar
    func BookingCalendar(method:String,url:String,request:BookingCalendarRequest,viewController:UIViewController) -> Promise<BookingCalendarResponse> {
        var obj = BookingCalendarResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<BookingCalendarResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<BookingCalendarResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Booking Requests
    func BookingRequest(method:String,url:String,request:BookingReqRequest,viewController:UIViewController) -> Promise<BookingRequestResponse> {
        var obj = BookingRequestResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<BookingRequestResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<BookingRequestResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Submit Booking Requests
    func SubmitBookingReq(method:String,url:String,request:SubmitBookingRequest,viewController:UIViewController) -> Promise<SubmitBookingResponse> {
        var obj = SubmitBookingResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "status": request.status!,
            "bookingIDs": request.bookingIDs!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<SubmitBookingResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<SubmitBookingResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Upload Jobsheet
    func GetUploadJobsheet(method:String,url:String,request:GetUploadJobsheetRequest,viewController:UIViewController) -> Promise<GetUploadJobsheetResponse> {
        var obj = GetUploadJobsheetResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<GetUploadJobsheetResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<GetUploadJobsheetResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Load Data For Jobsheet
    func GetTempData(method:String,url:String,request:GetTempDataRequest,viewController:UIViewController) -> Promise<GetTempDataResponse> {
        var obj = GetTempDataResponse();
        let parameter = [
            "BookingId": request.BookingId!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<GetTempDataResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<GetTempDataResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Upload Jobsheet Information
    func UploadJobsheetInfo(method:String,url:String,request:UploadJobsheetInfoRequest,viewController:UIViewController) -> Promise<UploadJobsheetInfoResponse> {
        var obj = UploadJobsheetInfoResponse();
        let parameter = [
            "BookingId": request.BookingId!,
            "IdCardNo": request.IdCardNo!,
            "JSSignedBy": request.JSSignedBy!,
            "JSPosition": request.JSPosition!,
            "Comments": request.Comments!,
            "IsFBNS": request.IsFBNS!,
            "ArriveOnTime": request.ArriveOnTime!,
            "Intro": request.Intro!,
            "WearLECard": request.WearLECard!,
            "PreAssignment": request.PreAssignment!,
            "CustomerCare": request.CustomerCare!,
            "Dress": request.Dress!,
            "Satisfied": request.Satisfied!,
            "ClientArrive": request.ClientArrive!,
            "ArrivalTime": request.ArrivalTime!,
            "StartTime": request.StartTime!,
            "WaitingTime": request.WaitingTime!,
            "BreakTime": request.BreakTime!,
            "IsNextDay": request.IsNextDay!,
            "FinishTime": request.FinishTime!,
            "Mileage": request.Mileage!,
            "TravelTime": request.TravelTime!,
            "PublicTransportCost": request.PublicTransportCost!,
            "OtherExpenses": request.OtherExpenses!,
            "ProfessionalSignature": request.ProfessionalSignature!,
            "InterpreterSignature": request.InterpreterSignature!,
            "WantSameInterpreter": request.WantSameInterpreter!,
            "InterpreterArrived": request.InterpreterArrived!,
            "Miles": request.Miles!,
            "ReturnedHome": request.ReturnedHome!,          
            "TyneTunnel": request.TyneTunnel!,
            "UploadYourInvoice": request.UploadYourInvoice!,
            "UploadYourInvoiceExt": request.UploadYourInvoiceExt!,
            "UploadPublicTransportReceipts": request.UploadPublicTransportReceipts!,
            "UploadPublicTransportReceiptsExt": request.UploadPublicTransportReceiptsExt!,
            "StarRatingFromCustomer": request.StarRatingFromCustomer!,
            "StarRatingFromInterpreter": request.StarRatingFromInterpreter!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UploadJobsheetInfoResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UploadJobsheetInfoResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Customer Jobsheet Information
    func CustomerJobsheetInfo(method:String,url:String,request:CustomerJobsheetInfoRequest,viewController:UIViewController) -> Promise<CustomerJobsheetInfoResponse> {
        var obj = CustomerJobsheetInfoResponse();
        let parameter = [
            "BookingId": request.BookingId!,
            "IdCardNo": request.IdCardNo!,
            "JSSignedBy": request.JSSignedBy!,
            "JSPosition": request.JSPosition!,
            "Comments": request.Comments!,
            "IsFBNS": request.IsFBNS!,
            "ArriveOnTime": request.ArriveOnTime!,
            "Intro": request.Intro!,
            "WearLECard": request.WearLECard!,
            "PreAssignment": request.PreAssignment!,
            "CustomerCare": request.CustomerCare!,
            "Dress": request.Dress!,
            "Satisfied": request.Satisfied!,
            "ClientArrive": request.ClientArrive!,
            "ArrivalTime": request.ArrivalTime!,
            "StartTime": request.StartTime!,
            "WaitingTime": request.WaitingTime!,
            "BreakTime": request.BreakTime!,
            "IsNextDay": request.IsNextDay!,
            "FinishTime": request.FinishTime!,
            "ProfessionalSignature": request.ProfessionalSignature!,
            "WantSameInterpreter": request.WantSameInterpreter!,
            "InterpreterArrived": request.InterpreterArrived!,
            "Miles": request.Miles!,
            "ReturnedHome": request.ReturnedHome!,
            "StarRatingFromCustomer": request.StarRatingFromCustomer!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<CustomerJobsheetInfoResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<CustomerJobsheetInfoResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Feedback
    func Feedback(method:String,url:String,request:FeedbackRequest,viewController:UIViewController) -> Promise<FeedbackResponse> {
        var obj = FeedbackResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "feedback": request.feedback!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<FeedbackResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<FeedbackResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Get Show Pin
    func GetShowPin(method:String,url:String,request:GetShowPinRequest,viewController:UIViewController) -> Promise<GetShowPinResponse> {
        var obj = GetShowPinResponse();
        let parameter = [
            "IdCardNo": request.IdCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<GetShowPinResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<GetShowPinResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Get PCA
    func GetPCA(method:String,url:String,request:GetPCARequest,viewController:UIViewController) -> Promise<GetPCAResponse> {
        var obj = GetPCAResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<GetPCAResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<GetPCAResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Update PCA
    func UpdatePCA(method:String,url:String,request:UpdatePCARequest,viewController:UIViewController) -> Promise<UpdatePCAResponse> {
        var obj = UpdatePCAResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "excludedPca": request.excludedPca,
            "postcodeOnly": request.postcodeOnly!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdatePCAResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdatePCAResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Contact Us
    func ContactUs(method:String,url:String,request:ContactUsRequest,viewController:UIViewController) -> Promise<ContactUsResponse> {
        var obj = ContactUsResponse();
        let parameter = [
            "IdCardNo": request.IdCardNo!,
            "Email": request.Email!,
            "Category": request.Category!,
            "Message": request.Message!,
            "DeviceType": request.DeviceType!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<ContactUsResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<ContactUsResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Help Us Improve
    func HelpUsImprove(method:String,url:String,request:HelpUsImproveRequest,viewController:UIViewController) -> Promise<HelpUsImproveResponse> {
        var obj = HelpUsImproveResponse();
        let parameter = [
            "IdCardNo": request.IdCardNo!,
            "Email": request.Email!,
            "Message": request.Message!,
            "DeviceType": request.DeviceType!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<HelpUsImproveResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<HelpUsImproveResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Load User Profile
    func UserProfile(method:String,url:String,request:UserProfileRequest,viewController:UIViewController) -> Promise<UserProfileResponse> {
        var obj = UserProfileResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UserProfileResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UserProfileResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Update User Profile
    func UpdateUserProfile(method:String,url:String,request:UpdateUserProfileRequest,viewController:UIViewController) -> Promise<UpdateUserProfileResponse> {
        var obj = UpdateUserProfileResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!,
            "FirstName" : request.FirstName!,
            "LastName" : request.LastName!,
            "Qualification" : request.Qualification!,
            "ProfileImage" : request.ProfileImage!,
            "Type" : request.type!,
            "AddressLine1" : request.AddressLine1!,
            "AddressLine2" : request.AddressLine2!,
            "AddressLine3" : request.AddressLine3!,
            "AddressLine4" : request.AddressLine4!,
            "UserPostCode" : request.UserPostCode!,
            "County" : request.County!,
            "Country" : request.Country!,
            "Gender" : request.Gender!,
            "Reason" : request.Reason!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateUserProfileResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateUserProfileResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Load Absence
    func LoadAbsence(method:String,url:String,request:LoadAbsenceRequest,viewController:UIViewController) -> Promise<LoadAbsenceResponse> {
        var obj = LoadAbsenceResponse();
        let parameter = [
            "idCardNo": request.idCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<LoadAbsenceResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<LoadAbsenceResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Create Absence
    func CreateAbsence(method:String,url:String,request:CreateAbsenceRequest,viewController:UIViewController) -> Promise<CreateAbsenceResponse> {
        var obj = CreateAbsenceResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "dateFrom": request.dateFrom!,
            "dateTo": request.dateTo!,
            "reason": request.reason!,
            "inContact": request.inContact!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<CreateAbsenceResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<CreateAbsenceResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Delete Absence
    func DeleteAbsence(method:String,url:String,request:DeleteAbsenceRequest,viewController:UIViewController) -> Promise<DeleteAbsenceResponse> {
        var obj = DeleteAbsenceResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "holidayId": request.holidayId!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<DeleteAbsenceResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<DeleteAbsenceResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Email Notification
    func EmailNotification(method:String,url:String,request:EmailNotificationRequest,viewController:UIViewController) -> Promise<EmailNotificationResponse> {
        var obj = EmailNotificationResponse();
        let parameter = [
            "idCardNo": request.idCardNo!,
            "value": request.value!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<EmailNotificationResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<EmailNotificationResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Get System Updates
    func GetSystemUpdates(method:String,url:String,request:GetSystemUpdatesRequest,viewController:UIViewController) -> Promise<GetSystemUpdatesResponse> {
        var obj = GetSystemUpdatesResponse();
        let parameter = [
            "mobile": request.mobile!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<GetSystemUpdatesResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<GetSystemUpdatesResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Report An Issue
    func ReportAnIssue(method:String,url:String,request:ReportAnIssueRequest,viewController:UIViewController) -> Promise<ReportAnIssueResponse> {
        var obj = ReportAnIssueResponse();
        let parameter = [
            "IdCardNo": request.IdCardNo!,
            "Name": request.Name!,
            "Subject": request.Subject!,
            "Body": request.Body!,
            "DeviceType": request.DeviceType!,
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<ReportAnIssueResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<ReportAnIssueResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Update Name Addresss
    func UpdateNameAddress(method:String,url:String,request:UpdateNameAddressRequest,viewController:UIViewController) -> Promise<UpdateNameAddressResponse> {
        var obj = UpdateNameAddressResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!,
            "FirstName":request.FirstName!,
            "LastName": request.LastName!,
            "NameProofFile": request.NameProofFile!,
            "NameProofFileExt": request.NameProofFileExt!,
            "ProfileImage": request.ProfileImage!,
            "AddressLine1": request.AddressLine1!,
            "AddressLine2": request.AddressLine2!,
            "AddressLine3": request.AddressLine3!,
            "AddressLine4": request.AddressLine4!,
            "UserPostCode":request.UserPostCode!,
            "County": request.County!,
            "Country": request.Country!,
            "AddressProofFile": request.AddressProofFile!,
            "AddressProofFileExt": request.AddressProofFileExt!,
            "Reason": request.Reason!,
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateNameAddressResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateNameAddressResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Update Email
    func UpdateEmail(method:String,url:String,request:UpdateEmailRequest,viewController:UIViewController) -> Promise<UpdateEmailResponse> {
        var obj = UpdateEmailResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!,
            "Email": request.Email!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateEmailResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateEmailResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Update Phone
    func UpdatePhone(method:String,url:String,request:UpdatePhoneRequest,viewController:UIViewController) -> Promise<UpdatePhoneResponse> {
        var obj = UpdatePhoneResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdatePhoneResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdatePhoneResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    
    ///Update Email Confirm
    func UpdateEmailConfirm(method:String,url:String,request:UpdateEmailConfirmRequest,viewController:UIViewController) -> Promise<UpdateEmailConfirmResponse> {
        var obj = UpdateEmailConfirmResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!,
            "NewEmail": request.NewEmail!,
            "AuthConfirm": request.AuthConfirm!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdateEmailConfirmResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdateEmailConfirmResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
    ///Update Phone Confirm
    func UpdatePhoneConfirm(method:String,url:String,request:UpdatePhoneConfirmRequest,viewController:UIViewController) -> Promise<UpdatePhoneConfirmResponse> {
        var obj = UpdatePhoneConfirmResponse();
        let parameter = [
            "IDCardNo": request.IDCardNo!,
            "NewMobile": request.NewMobile!,
            "AuthConfirm": request.AuthConfirm!
        ] as [String : Any]
        let header = ["Content-Type": "application/json"]
        return Promise<UpdatePhoneConfirmResponse> {
            seal in
            Alamofire.request(url,method: .post, parameters:parameter,encoding: JSONEncoding.default,headers: header).responseObject { (response : DataResponse<UpdatePhoneConfirmResponse>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        obj = data
                        seal.fulfill(obj)
                        break
                    }
                case .failure(_):
                    if let alamoError = response.result.error{
                        RappleActivityIndicatorView.stopAnimation()
                        seal.reject(alamoError as Error)
                        break
                    }
                }
            }
        }
    }
}
