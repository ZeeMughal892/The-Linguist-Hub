

import UIKit
import SWRevealViewController
import RappleProgressHUD
import PromiseKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var txtIdCardNo: customUITextField!
    @IBOutlet weak var txtEmail: customUITextField!
    @IBOutlet weak var headID: UILabel!
    @IBOutlet weak var headMessage: UILabel!
    @IBOutlet weak var headEmail: UILabel!
    @IBOutlet weak var txtPassword: customUITextField!
    @IBOutlet weak var headPass: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFP: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtIdCardNo.becomeFirstResponder()
        txtIdCardNo.isEnabled = true
        txtEmail.isEnabled = true
        txtPassword.isEnabled = true
        
        headMessage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headID.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headEmail.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPass.textColor = UIColor.init(named: LoginUser.getThemeColor)
        btnLogin.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        btnFP.setTitleColor(UIColor.init(named: LoginUser.getThemeColor), for: .normal)
        //txtIdCardNo.text = "29833"        txtEmail.text = "jordan.s@virgin.net"        txtPassword.text = "Tallola23#"
        navigationController?.navigationBar.barTintColor = .systemBackground
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        //txtIdCardNo.text = "61269"        txtEmail.text = "monika.wieczorek@empire-groupuk.com"        txtPassword.text = "Mon123!"
    }    
    @IBAction func actionLogin(_ sender: Any) {
        let range = NSRange(location: 0, length: txtEmail.text!.count)
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        if(txtIdCardNo.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Id Card No" , ViewController: self)
            self.txtIdCardNo.becomeFirstResponder()
        }
        if (txtEmail.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Email Address" , ViewController: self)
            self.txtEmail.becomeFirstResponder()
        }else if  regex.firstMatch(in: txtEmail.text!, options: [], range: range) != nil{
        }else {
            Modals.CreateAlert(title: "", message:"Please Enter Valid Email Address" , ViewController: self)
            self.txtEmail.becomeFirstResponder()
        }
        if(txtPassword.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Password" , ViewController: self)
            self.txtPassword.becomeFirstResponder()
        }else{
            RappleActivityIndicatorView.startAnimating()
            let request = LoginRequest()
            request.idcardno = txtIdCardNo.text!
            request.email = txtEmail.text!
            request.password = txtPassword.text!
            request.deviceId = UIDevice.current.identifierForVendor?.uuidString
            request.deviceType = "iPhone"
            ApiManager.api.Login(method: MethodTypes.Post.rawValue, url: ApiUrls.loginUser, request: request, viewController: self).done { response in
                if response.d.Result != false{
                    LoginUser.password = request.password
                    LoginUser.email = request.email
                    LoginUser.emptyMessage = response.d.NoBookingsAvailable
                    LoginUser.deviceId = request.deviceId
                    LoginUser.deviceType = request.deviceType
                    LoginUser.userID = response.d.UserId
                    LoginUser.idCardNo = response.d.IDCardNo
                    LoginUser.twoFACode = response.d.TwoFACode
                    
                    UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                    UserDefaults.standard.set(LoginUser.userID, forKey: "userID")
                    UserDefaults.standard.set(LoginUser.password, forKey: "password")
                    UserDefaults.standard.set(LoginUser.email, forKey: "email")
                    UserDefaults.standard.set(LoginUser.idCardNo, forKey: "idCardNo")
                    UserDefaults.standard.set(LoginUser.deviceId, forKey: "deviceId")
                    UserDefaults.standard.set(LoginUser.deviceType, forKey: "deviceType")
                    UserDefaults.standard.set(LoginUser.emptyMessage, forKey: "emptyMessage")
                    //UserDefaults.standard.set(LoginUser.twoFACode, forKey: "TwoFACode")
                    self.loadProfile()
                }
                else{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    func loadProfile(){
        RappleActivityIndicatorView.startAnimating()
        let request = UserProfileRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.UserProfile(method: MethodTypes.Post.rawValue, url: ApiUrls.userProfile, request: request, viewController: self).done { response in            
            LoginUser.fullName = response.d.fullName
            LoginUser.userID = response.d.userId
            LoginUser.idCardNo = response.d.iDCardNo
            LoginUser.firstName = response.d.firstName
            LoginUser.lastName = response.d.lastName
            LoginUser.mobile = response.d.mobile
            LoginUser.profileImage = response.d.profileImage
            LoginUser.email = response.d.email
            LoginUser.lEContactEmail = response.d.lEContactEmail
            LoginUser.lEContactNo = response.d.lEContactNo
            LoginUser.noticeBoard = response.d.noticeBoard
            LoginUser.noticeBoardLink = response.d.noticeBoardLink
            LoginUser.noticeBoardTitle = response.d.noticeBoardTitle
            LoginUser.showSystemUpdates = response.d.showSystemUpdates
            LoginUser.isFullTime = response.d.isFullTime
            LoginUser.showJobSheet = response.d.showJobSheet
            LoginUser.isEmail = response.d.isEmail
            LoginUser.penaltyText = response.d.penaltyText
            LoginUser.qualification = response.d.qualification
            LoginUser.gender = response.d.gender
            LoginUser.themeColor = "colorLeftMenu"
            
            LoginUser.ratingsDetails = response.d.ratingsDetails
            LoginUser.addressLine1 = response.d.addressLine1
            LoginUser.addressLine2 = response.d.addressLine2
            LoginUser.addressLine3 = response.d.addressLine3
            LoginUser.addressLine4 = response.d.addressLine4
            LoginUser.postcode = response.d.userPostCode
            LoginUser.county = response.d.county
            LoginUser.country = response.d.country
            
            UserDefaults.standard.set(LoginUser.ratingsDetails, forKey: "ratingsDetails")
            UserDefaults.standard.set(LoginUser.userID, forKey: "userID")
            UserDefaults.standard.set(LoginUser.idCardNo, forKey: "idCardNo")
            UserDefaults.standard.set(LoginUser.firstName, forKey: "firstName")
            UserDefaults.standard.set(LoginUser.lastName, forKey: "lastName")
            UserDefaults.standard.set(LoginUser.profileImage, forKey: "profileImage")
            UserDefaults.standard.set(LoginUser.email, forKey: "email")
            UserDefaults.standard.set(LoginUser.mobile, forKey: "mobile")
            UserDefaults.standard.set(LoginUser.lEContactEmail, forKey: "lEContactEmail")
            UserDefaults.standard.set(LoginUser.lEContactNo, forKey: "lEContactNo")
            UserDefaults.standard.set(LoginUser.noticeBoard, forKey: "noticeBoard")
            UserDefaults.standard.set(LoginUser.noticeBoardLink, forKey: "noticeBoardLink")
            UserDefaults.standard.set(LoginUser.noticeBoardTitle, forKey: "noticeBoardTitle")
            UserDefaults.standard.set(LoginUser.showSystemUpdates, forKey: "showSystemUpdates")
            UserDefaults.standard.set(LoginUser.isFullTime, forKey: "isFullTime")
            UserDefaults.standard.set(LoginUser.showJobSheet, forKey: "showJobSheet")
            UserDefaults.standard.set(LoginUser.emptyMessage, forKey: "emptyMessage")
            UserDefaults.standard.set(LoginUser.penaltyText, forKey: "penaltyText")
            UserDefaults.standard.set(LoginUser.qualification, forKey: "qualification")
            UserDefaults.standard.set(LoginUser.isEmail, forKey: "isEmail")
            UserDefaults.standard.set(LoginUser.gender, forKey: "gender")
            UserDefaults.standard.set(LoginUser.themeColor, forKey: "themeColor")
            
            UserDefaults.standard.set(LoginUser.addressLine1, forKey: "addressLine1")
            UserDefaults.standard.set(LoginUser.addressLine2, forKey: "addressLine2")
            UserDefaults.standard.set(LoginUser.addressLine3, forKey: "addressLine3")
            UserDefaults.standard.set(LoginUser.addressLine4, forKey: "addressLine4")
            UserDefaults.standard.set(LoginUser.postcode, forKey: "postcode")
            UserDefaults.standard.set(LoginUser.county, forKey: "county")
            UserDefaults.standard.set(LoginUser.country, forKey: "country")
        
            self.loadBookingReminders()
            RappleActivityIndicatorView.stopAnimation()
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
        }
    }
    func loadBookingReminders(){
        let request = BookingRemindersRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.BookingReminders(method: MethodTypes.Post.rawValue, url: ApiUrls.bookingReminders, request: request, viewController: self).done { response in
            if response.d.count != 0 {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"BookingRemindersViewController") as! BookingRemindersViewController
                BookingRemindersViewController.bookingItems = response.d
                mainVC.modalPresentationStyle = .fullScreen
               // self.present(mainVC,animated:true,completion:nil)
                self.navigationController?.pushViewController(mainVC, animated: true)
            }else{/*
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC,animated:true,completion:nil)
 */
                let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.view.window?.rootViewController = sw

                let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                sw.pushFrontViewController(newFrontViewController, animated: true)
                
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
        }
    }
    @IBAction func actionForgotPassword(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ForgotPasswordViewController") as! ForgotPasswordViewController
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC,animated:true,completion:nil)
    }
}
