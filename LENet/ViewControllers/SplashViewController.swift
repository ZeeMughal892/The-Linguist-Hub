
import UIKit
import SWRevealViewController
import RappleProgressHUD

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lblVersionNumber: UILabel!
    @IBOutlet weak var lblAppTitle: UILabel!
    @IBOutlet weak var lblCopyright: UILabel!
    var pin:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lblAppTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
        lblCopyright.textColor = UIColor.init(named: LoginUser.getThemeColor)
        lblVersionNumber.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        if LoginUser.getVersion == ""{
            getSystemUpdates()
        }else{
            lblVersionNumber.text = LoginUser.getVersion
        } 
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true && self.pin == ""{
                let request = LoginRequest()
                request.idcardno = UserDefaults.standard.string(forKey:  "idCardNo")
                request.email = UserDefaults.standard.string(forKey: "email")
                request.password = UserDefaults.standard.string(forKey: "password")
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
                        self.pin = response.d.TwoFACode
                        
                        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                        UserDefaults.standard.set(LoginUser.userID, forKey: "userID")
                        UserDefaults.standard.set(LoginUser.idCardNo, forKey: "idCardNo")
                        UserDefaults.standard.set(LoginUser.deviceId, forKey: "deviceId")
                        UserDefaults.standard.set(LoginUser.deviceType, forKey: "deviceType")
                        UserDefaults.standard.set(LoginUser.emptyMessage, forKey: "emptyMessage")
                    }else{
                        Modals.CreateAlert(title: "Login Failed", message: response.d.Message, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                    }
                }.catch
                    {
                        error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                }
                LoginUser.idCardNo = UserDefaults.standard.string(forKey: "idCardNo")!
                LoginUser.noticeBoard = UserDefaults.standard.string(forKey: "noticeBoard")!
                LoginUser.noticeBoardTitle = UserDefaults.standard.string(forKey: "noticeBoardTitle")!
                LoginUser.noticeBoardLink = UserDefaults.standard.string(forKey: "noticeBoardLink")!
                LoginUser.profileImage = UserDefaults.standard.string(forKey: "profileImage")!
                LoginUser.firstName = UserDefaults.standard.string(forKey: "firstName")!
                LoginUser.lastName = UserDefaults.standard.string(forKey: "lastName")!
                LoginUser.email = UserDefaults.standard.string(forKey: "email")!
                LoginUser.lEContactNo = UserDefaults.standard.string(forKey: "lEContactNo")!
                LoginUser.lEContactEmail = UserDefaults.standard.string(forKey: "lEContactEmail")!
                LoginUser.emptyMessage = UserDefaults.standard.string(forKey: "emptyMessage")!
                LoginUser.gender = UserDefaults.standard.string(forKey: "gender")!
                LoginUser.deviceId = UserDefaults.standard.string(forKey: "deviceId")!
                LoginUser.deviceType = UserDefaults.standard.string(forKey: "deviceType")!
                LoginUser.mobile = UserDefaults.standard.string(forKey: "mobile")!
                LoginUser.isEmail = UserDefaults.standard.integer(forKey: "isEmail")
                LoginUser.penaltyText = UserDefaults.standard.string(forKey: "penaltyText")!
                LoginUser.qualification = UserDefaults.standard.string(forKey: "qualification")!
                
                LoginUser.addressLine1 = UserDefaults.standard.string(forKey: "addressLine1")!
                LoginUser.addressLine2 = UserDefaults.standard.string(forKey: "addressLine2")!
                LoginUser.addressLine3 = UserDefaults.standard.string(forKey: "addressLine3")!
                LoginUser.addressLine4 = UserDefaults.standard.string(forKey: "addressLine4")!
                LoginUser.postcode = UserDefaults.standard.string(forKey: "postcode")!
                LoginUser.county = UserDefaults.standard.string(forKey: "county")!
                LoginUser.country = UserDefaults.standard.string(forKey: "country")!
                LoginUser.ratingsDetails = UserDefaults.standard.string(forKey: "ratingsDetails")!
                
                if UserDefaults.standard.bool(forKey: "touchID") == true || UserDefaults.standard.bool(forKey: "faceID") == true {
                    ///Code for Biometrics
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"BiometricsViewController") as! BiometricsViewController
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC,animated:true,completion:nil)
                }else{
                    self.loadBookingReminders()
                }
            }
            else if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true && self.pin != "" {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"VerificationScreenViewController") as! VerificationScreenViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC,animated:true,completion:nil)
            }else if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == false && (UserDefaults.standard.bool(forKey: "touchID") == true || UserDefaults.standard.bool(forKey: "faceID") == true) {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"BiometricsViewController") as! BiometricsViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC,animated:true,completion:nil)                
            }
            else{
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC,animated:true,completion:nil)
            }
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
   
    func getSystemUpdates(){
        RappleActivityIndicatorView.startAnimating()
        let request = GetSystemUpdatesRequest()
        request.mobile = "iOS"
        ApiManager.api.GetSystemUpdates(method: MethodTypes.Post.rawValue, url: ApiUrls.getSystemUpdates, request: request, viewController: self).done { response in
            self.lblVersionNumber.text = "Version " + response.d[0].IPhoneVersionNo
            LoginUser.version = self.lblVersionNumber.text!
            UserDefaults.standard.set(LoginUser.version, forKey: "version")
            RappleActivityIndicatorView.stopAnimation()
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
        }
    }
}
