
import UIKit
import SWRevealViewController
import Kingfisher
import RappleProgressHUD
import Cosmos

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var rightSmallView: UIView!
    @IBOutlet weak var bgHeader: UIView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblWelcome: PaddingLabel!
    @IBOutlet weak var lblVersionNumber: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgPro: NSLayoutConstraint!
    @IBOutlet weak var rightPlus: NSLayoutConstraint!
    
    @IBOutlet weak var imgPlus: NSLayoutConstraint!
    @IBOutlet weak var leftPlus: NSLayoutConstraint!
    @IBOutlet weak var rightPro: NSLayoutConstraint!
    @IBOutlet weak var leftPro: NSLayoutConstraint!
    @IBOutlet weak var img: NSLayoutConstraint!
    @IBOutlet weak var imgMax: NSLayoutConstraint!
    @IBOutlet weak var leftView: NSLayoutConstraint!
    @IBOutlet weak var leftMax: NSLayoutConstraint!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var stackMax: NSLayoutConstraint!
    @IBOutlet weak var viewMax: NSLayoutConstraint!
    @IBOutlet weak var rightView: NSLayoutConstraint!
    @IBOutlet weak var rightMax: NSLayoutConstraint!
    var menuNameArr:Array = [String]()
    var iconImage:Array = [UIImage]()
    
    @IBOutlet weak var ratingsView: CosmosView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        lblVersionNumber.text = LoginUser.getVersion
        lblVersionNumber.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        smallView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        rightSmallView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        bgHeader.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        let str = ApiUrls.imgProfile + LoginUser.profileImage
        if  URL(string: str) != nil
        {
            let resource = ImageResource(downloadURL: URL(string: str)!, cacheKey: str)
            self.imgProfile.kf.setImage(with: resource)
        }
        
//        let device = UIDevice.modelName
//        if device == "Simulator iPhone 6s"  || device == "Simulator iPhone 8"  ||
//            device == "iPhone 6" ||
//            device == "iPhone 6s" ||
//            device == "iPhone 7" ||
//            device == "iPhone 8" {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 48
//            imgProfile.clipsToBounds = true
//            ratingsView.settings.starSize = 20
//
//        }else if device == "Simulator iPhone 6s Plus" ||
//            device == "iPhone 6 Plus" ||
//            device == "iPhone 6s Plus" ||
//            device == "iPhone 7 Plus" ||
//            device == "Simulator iPhone 8 Plus"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 54
//            imgProfile.clipsToBounds = true
//
//            rightView.isActive = false
//            leftView.isActive = false
//            img.isActive = false
//            leftPlus.isActive = true
//            imgPlus.isActive = true
//            rightPlus.isActive = true
//
//
//        }else if device == "Simulator iPhone 11 Pro" ||
//            device == "iPhone 11 Pro" ||
//            device == "iPhone XS"  ||
//            device == "iPhone X"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 54
//            imgProfile.clipsToBounds = true
//
//            rightView.isActive = false
//            leftView.isActive = false
//            img.isActive = false
//            leftPro.isActive = true
//            imgPro.isActive = true
//            rightPro.isActive = true
//
//        }else if device == "Simulator iPhone 11" ||
//            device == "iPhone 11" ||
//            device == "iPhone XR" || device == "Simulator iPhone 12" ||
//            device == "Simulator iPhone 12 Pro" ||
//            device == "iPhone 12" || device == "iPhone 12 Pro"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 60
//            imgProfile.clipsToBounds = true
//
//            rightView.isActive = false
//            leftView.isActive = false
//            img.isActive = false
//            leftMax.isActive = true
//            imgMax.isActive = true
//            rightMax.isActive = true
//
//        }else if device == "Simulator iPhone 11 Pro Max" ||
//            device  == "iPhone 11 Pro Max" ||
//            device  == "iPhone XS Max" {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 60
//            imgProfile.clipsToBounds = true
//
//            rightView.isActive = false
//            leftView.isActive = false
//            img.isActive = false
//            leftMax.isActive = true
//            imgMax.isActive = true
//            rightMax.isActive = true
//        }else if device == "Simulator iPhone 12 Pro Max" ||
//                    device == "iPhone 12 Pro Max"
//        {
//        imgProfile.layer.borderWidth = 5.0
//        imgProfile.layer.masksToBounds = false
//        imgProfile.layer.borderColor = UIColor.white.cgColor
//        imgProfile.layer.cornerRadius = 60
//        imgProfile.clipsToBounds = true
//
//        rightView.isActive = false
//        leftView.isActive = false
//        img.isActive = false
//        leftMax.isActive = true
//        imgMax.isActive = true
//        rightMax.isActive = true
//    }else if device == "iPhone 12 mini" ||
//                device == "Simulator iPhone 12 mini"{
//
//        imgProfile.layer.borderWidth = 5.0
//        imgProfile.layer.masksToBounds = false
//        imgProfile.layer.borderColor = UIColor.white.cgColor
//        imgProfile.layer.cornerRadius = 54
//        imgProfile.clipsToBounds = true
//
//        rightView.isActive = false
//        leftView.isActive = false
//        img.isActive = false
//        leftPlus.isActive = true
//        imgPlus.isActive = true
//        rightPlus.isActive = true
//
//    }
        self.lblWelcome.text = LoginUser.getFirstName + " " + LoginUser.getLastName
        
        
        if LoginUser.getIdCardNo == "89808"
        {   
            menuNameArr = ["Dashboard",
                           "Available Bookings",
                           "Booking Calendar",
                           "E-Signature Upload",
                           "My Requests",
                           "TI Pin",
                           "My Profile",
                           "Contact Us",
                           "Settings",
                           "Report An Issue",
                           "Help Us Improve",
                           "Logout"]
            iconImage = [UIImage(named: "IcoDash")!,
                         UIImage(named: "IcoAvailableBookings")!,
                         UIImage(named: "IcoBookingCalendar")!,
                         UIImage(named: "IcoElectronicSignature")!,
                         UIImage(named: "IcoBookingRequest")!,
                         UIImage(named: "IcoPin")!,
                         UIImage(named: "IcoProfile")!,
                         UIImage(named: "IcoContactUs")!,
                         UIImage(named: "IcoSettings")!,
                         UIImage(named: "ImgReport")!,
                         UIImage(named: "IcoImprove")!,
                         UIImage(named: "IcoLogout")!]
        }else{
            menuNameArr = ["Dashboard",
                           "Available Bookings",
                           "Booking Calendar",
                           "E-Signature Upload",
                           "My Requests",
                           "My Profile",
                           "Contact Us",
                           "Settings",
                           "Report An Issue",
                           "Help Us Improve",
                           "Logout"]
            iconImage = [UIImage(named: "IcoDash")!,
                         UIImage(named: "IcoAvailableBookings")!,
                         UIImage(named: "IcoBookingCalendar")!,
                         UIImage(named: "IcoElectronicSignature")!,
                         UIImage(named: "IcoBookingRequest")!,
                         UIImage(named: "IcoProfile")!,
                         UIImage(named: "IcoContactUs")!,
                         UIImage(named: "IcoSettings")!,
                         UIImage(named: "ImgReport")!,
                         UIImage(named: "IcoImprove")!,
                         UIImage(named: "IcoLogout")!]
        }
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        
        let ratings = LoginUser.getRatingsDetails.split{$0 == ","}.map(String.init)
        ratingsView.rating = Double(ratings[0])!
        ratingsView.text = "\(ratings[0]) (\(ratings[1]) Reviews)"
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.layer.borderWidth = 5.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds = true
    }
    @IBAction func actionImgBtn(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController =  mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell") as! LeftMenuTableViewCell
        cell.imgMenu.image = iconImage[indexPath.row]
        cell.imgMenu.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.lblMenuItem.text! = menuNameArr[indexPath.row]
        cell.lblMenuItem.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemBackground
        let backgroundView = UIImageView(image: UIImage(named: "ImgSelectedRow"))
        backgroundView.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        backgroundView.contentMode = .left
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let cell:LeftMenuTableViewCell = tableView.cellForRow(at: indexPath) as! LeftMenuTableViewCell
        
        if cell.lblMenuItem.text! == "Dashboard"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Available Bookings"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "AvailableBookingsViewController") as! AvailableBookingsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Booking Calendar"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "BookingsCalendarViewController") as! BookingsCalendarViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "E-Signature Upload"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "ESignatureUploadViewController") as! ESignatureUploadViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "My Requests"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "BookingRequestsViewController") as! BookingRequestsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "TI Pin"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "TIPinViewController") as! TIPinViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "My Profile"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Contact Us"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Settings"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Report An Issue"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "ReportAnIssueViewController") as! ReportAnIssueViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Help Us Improve"
        {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController =  mainStoryboard.instantiateViewController(withIdentifier: "HelpUsImproveViewController") as! HelpUsImproveViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuItem.text! == "Logout"
        {
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
            mainVC.modalPresentationStyle = .fullScreen
           self.present(mainVC, animated: true, completion: nil)
            /*
            RappleActivityIndicatorView.startAnimating()
            let request = LogoutRequest()
            request.idcardno = LoginUser.getIdCardNo
            request.email = LoginUser.getEmail
            request.mobile = LoginUser.getMobile
            request.surname = LoginUser.getLastName
            request.deviceId = LoginUser.getDeviceId
            request.deviceType = LoginUser.getDeviceType
            ApiManager.api.LogOut(method: MethodTypes.Post.rawValue, url: ApiUrls.logoutUser, request: request, viewController: self).done {
                response in
              
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set("", forKey: "userID")
                UserDefaults.standard.set("", forKey: "firstName")
                UserDefaults.standard.set("", forKey: "lastName")
                UserDefaults.standard.set("", forKey: "profileImage")
                UserDefaults.standard.set("", forKey: "mobile")
                UserDefaults.standard.set("", forKey: "lEContactEmail")
                UserDefaults.standard.set("", forKey: "lEContactNo")
                UserDefaults.standard.set("", forKey: "noticeBoard")
                UserDefaults.standard.set("", forKey: "noticeBoardLink")
                UserDefaults.standard.set("", forKey: "noticeBoardTitle")
                UserDefaults.standard.set("", forKey: "showSystemUpdates")
                UserDefaults.standard.set("", forKey: "isFullTime")
                UserDefaults.standard.set("", forKey: "showJobSheet")
                UserDefaults.standard.set("", forKey: "emptyMessage")
                UserDefaults.standard.set("", forKey: "TwoFACode")
                UserDefaults.standard.set("", forKey: "deviceId")
                UserDefaults.standard.set("", forKey: "deviceType")
                UserDefaults.standard.set("", forKey: "emptyMessage")
               
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
            }
        }*/
    }
         
    }
    
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
