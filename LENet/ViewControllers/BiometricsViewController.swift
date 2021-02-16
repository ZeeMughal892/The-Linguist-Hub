//
//  BiometricsViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 15/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import LocalAuthentication
import SWRevealViewController
import RappleProgressHUD

class BiometricsViewController: UIViewController {
    
    @IBOutlet weak var btnBiometric: UIButton!
    @IBOutlet weak var headID: UILabel!
    @IBOutlet weak var subHeadID: UILabel!
    @IBOutlet weak var btnLoginCredentials: UIButton!
    
    @IBOutlet weak var largeLeading: NSLayoutConstraint!
    @IBOutlet weak var largeTrailing: NSLayoutConstraint!
    @IBOutlet weak var largeTop: NSLayoutConstraint!
    @IBOutlet weak var smallTrailing: NSLayoutConstraint!
    @IBOutlet weak var largeBottom: NSLayoutConstraint!
    @IBOutlet weak var smallBottom: NSLayoutConstraint!
    @IBOutlet weak var smallTop: NSLayoutConstraint!
    @IBOutlet weak var smallLeading: NSLayoutConstraint!
    @IBOutlet weak var medBottom: NSLayoutConstraint!
    @IBOutlet weak var medLeading: NSLayoutConstraint!
    
    @IBOutlet weak var medTop: NSLayoutConstraint!
    @IBOutlet weak var medTrailing: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        btnBiometric.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        headID.textColor = UIColor.init(named: LoginUser.getThemeColor)       
        btnLoginCredentials.setTitleColor(UIColor.init(named: LoginUser.getThemeColor), for: .normal)
        authenticateUsingTouchID()
        let device = UIDevice.modelName
        if device == "Simulator iPhone 6s"  ||
            device == "iPhone 6" ||
            device == "iPhone 6s" ||
            device == "iPhone 7" ||
            device == "iPhone 8" {
            btnBiometric.setImage(UIImage(named: "touchid"), for: .normal)
            headID.text = "Log in with Touch ID"
            subHeadID.text = "Place your finger on the home button to login"
            
            largeTop.isActive = false
            largeBottom.isActive = false
            largeTrailing.isActive = false
            largeLeading.isActive = false
            
            medTop.isActive = false
            medBottom.isActive = false
            medTrailing.isActive = false
            medLeading.isActive = false
            
            smallTop.isActive = true
            smallBottom.isActive = true
            smallTrailing.isActive = true
            smallLeading.isActive = true
            
        }else if device == "Simulator iPhone 6s Plus" ||
            device == "iPhone 6 Plus" ||
            device == "iPhone 6s Plus" ||
            device == "iPhone 7 Plus" ||
            device == "iPhone 8 Plus"  {
            
            btnBiometric.setImage(UIImage(named: "touchid"), for: .normal)
            
            headID.text = "Log in with Touch ID"
            subHeadID.text = "Place your finger on the home button to login"
            
            
            largeTop.isActive = false
            largeBottom.isActive = false
            largeTrailing.isActive = false
            largeLeading.isActive = false
            
            medTop.isActive = true
            medBottom.isActive = true
            medTrailing.isActive = true
            medLeading.isActive = true
            
            smallTop.isActive = false
            smallBottom.isActive = false
            smallTrailing.isActive = false
            smallLeading.isActive = false
        }else if device == "Simulator iPhone 11 Pro" ||
            device == "iPhone 11 Pro" ||
            device == "iPhone XS"  ||
            device == "iPhone X"  {
            headID.text = "Log in with Face ID"
            btnBiometric.setImage(UIImage(named: "faceid"), for: .normal)
            subHeadID.text = "Please put your phone in front of your face to log in"
            largeTop.isActive = true
            largeBottom.isActive = true
            largeTrailing.isActive = true
            largeLeading.isActive = true
            
            medTop.isActive = false
            medBottom.isActive = false
            medTrailing.isActive = false
            medLeading.isActive = false
            
            smallTop.isActive = false
            smallBottom.isActive = false
            smallTrailing.isActive = false
            smallLeading.isActive = false
        }else if device == "Simulator iPhone 11" ||
            device == "iPhone 11" ||
            device == "iPhone XR"  {
            btnBiometric.setImage(UIImage(named: "faceid"), for: .normal)
            headID.text = "Log in with Face ID"
            subHeadID.text = "Please put your phone in front of your face to log in"
            largeTop.isActive = true
            largeBottom.isActive = true
            largeTrailing.isActive = true
            largeLeading.isActive = true
            
            medTop.isActive = false
            medBottom.isActive = false
            medTrailing.isActive = false
            medLeading.isActive = false
            
            smallTop.isActive = false
            smallBottom.isActive = false
            smallTrailing.isActive = false
            smallLeading.isActive = false
        }
        else if device == "Simulator iPhone 11 Pro Max" ||
            device == "iPhone 11 Pro Max" ||
            device == "iPhone XS Max"{
            btnBiometric.setImage(UIImage(named: "faceid"), for: .normal)
            headID.text = "Log in with Face ID"
            subHeadID.text = "Please put your phone in front of your face to log in"
            largeTop.isActive = true
            largeBottom.isActive = true
            largeTrailing.isActive = true
            largeLeading.isActive = true
            
            medTop.isActive = false
            medBottom.isActive = false
            medTrailing.isActive = false
            medLeading.isActive = false
            
            smallTop.isActive = false
            smallBottom.isActive = false
            smallTrailing.isActive = false
            smallLeading.isActive = false
        }
    }
    @IBAction func btnBiometric(_ sender: Any) {
        authenticateUsingTouchID()
    }
    
    func authenticateUsingTouchID(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Place your finger on the home button to log in"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        print("Authenticate Successful")
                        let request = LoginRequest()
                        request.idcardno = UserDefaults.standard.string(forKey:  "idCardNo")
                        request.email = UserDefaults.standard.string(forKey: "email")
                        request.password = UserDefaults.standard.string(forKey: "password")
                        request.deviceId = UIDevice.current.identifierForVendor?.uuidString
                        request.deviceType = "iPhone"
                        ApiManager.api.Login(method: MethodTypes.Post.rawValue, url: ApiUrls.loginUser, request: request, viewController: self!).done { response in
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
                                self!.loadProfile()
                            }else{
                                Modals.CreateAlert(title: "Login Failed", message: response.d.Message, ViewController: self!)
                                RappleActivityIndicatorView.stopAnimation()
                            }
                        }.catch
                            {
                                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self!)
                                RappleActivityIndicatorView.stopAnimation()
                        }
                        self?.loadBookingReminders()
                    }else{
                        if let error  = authenticationError {
                            self?.reportTouchIDError(error: error as NSError)
                        }
                    }
                }                
            }
        }else{
            Modals.CreateAlert(title: "Error", message: error!.localizedDescription, ViewController: self)
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
            
            LoginUser.addressLine1 = response.d.addressLine1
            LoginUser.addressLine2 = response.d.addressLine2
            LoginUser.addressLine3 = response.d.addressLine3
            LoginUser.addressLine4 = response.d.addressLine4
            LoginUser.postcode = response.d.userPostCode
            LoginUser.county = response.d.county
            LoginUser.country = response.d.country
            LoginUser.ratingsDetails = response.d.ratingsDetails
            LoginUser.themeColor = UserDefaults.standard.string(forKey: "themeColor")!
            
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
    func reportTouchIDError(error: NSError){
        switch  error.code {
        case LAError.authenticationFailed.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case LAError.passcodeNotSet.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case LAError.systemCancel.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case LAError.userCancel.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case kLAErrorBiometryNotEnrolled.hashValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case kLAErrorBiometryNotAvailable.hashValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case LAError.userFallback.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        case LAError.authenticationFailed.rawValue:
            Modals.CreateAlert(title: "Biometric Error", message: error.localizedDescription, ViewController: self)
        default:
            print(error.localizedDescription)
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
                //self.present(mainVC,animated:true,completion:nil)
                self.navigationController?.pushViewController(mainVC, animated: true)
            }else{
                /*
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
    @IBAction func actionLoginCredentials(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC,animated:true,completion:nil)
    }
}

