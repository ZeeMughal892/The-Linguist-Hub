

import UIKit
import RappleProgressHUD
import Kingfisher
import Cosmos

class UserProfileViewController: BaseViewController  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headID: UILabel!
    @IBOutlet weak var headFullName: UILabel!
    @IBOutlet weak var headEmail: UILabel!
    @IBOutlet weak var headContact: UILabel!
    @IBOutlet weak var headGender: UILabel!
    @IBOutlet weak var headAddress: UILabel!
    @IBOutlet weak var bgHeader: UIView!
    @IBOutlet weak var lblWelcomeMessage: PaddingLabel!
    @IBOutlet weak var txtIDCardNumber: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
   
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtPostalAddress: UITextView!
    
    public static var addressLine1:String = ""
    public static var addressLine2:String = ""
    public static var addressLine3:String = ""
    public static var addressLine4:String = ""
    public static var userPostCode:String = ""
    public static var county:String = ""
    public static var country:String = ""
    
    @IBOutlet weak var imgProfile: UIImageView!
    var imagePicker = UIImagePickerController()
    
    var textView = UITextView(frame: CGRect.zero)
    
    @IBOutlet weak var ratingView: CosmosView!
    
    
    @IBOutlet weak var smallLeft: NSLayoutConstraint!
    @IBOutlet weak var smallRight: NSLayoutConstraint!
    @IBOutlet weak var smallCenter: NSLayoutConstraint!
    
    @IBOutlet weak var plusLeft: NSLayoutConstraint!
    @IBOutlet weak var plusCenter: NSLayoutConstraint!
    @IBOutlet weak var plusRight: NSLayoutConstraint!
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Profile"
        self.addMenuButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        self.HideKeyboard()
        
        bgHeader.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        txtIDCardNumber.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtFullName.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtEmailAddress.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtContactNumber.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtGender.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtPostalAddress.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        
        headID.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headFullName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headEmail.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headContact.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headGender.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headAddress.textColor = UIColor.init(named: LoginUser.getThemeColor)
      
        
        self.loadProfile()
        let str = ApiUrls.imgProfile + LoginUser.profileImage
        let url = URL(string: str)!
        
        let resource = ImageResource(downloadURL: url, cacheKey: str)
        self.imgProfile.kf.setImage(with: resource)
        
//        let device = UIDevice.modelName
//        if device == "Simulator iPhone 6s"  ||
//            device == "Simulator iPhone 8"  ||
//            device == "iPhone 6" ||
//            device == "iPhone 6s" ||
//            device == "iPhone 7" ||
//            device == "iPhone 8" {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 60
//            imgProfile.clipsToBounds = true
//
//            smallLeft.isActive = true
//            smallRight.isActive = true
//            smallCenter.isActive = true
//
//            plusLeft.isActive = false
//            plusCenter.isActive = false
//            plusRight.isActive = false
//        }else if device == "Simulator iPhone 6s Plus" ||
//            device == "Simulator iPhone 8 Plus" ||
//            device == "iPhone 6 Plus" ||
//            device == "iPhone 6s Plus" ||
//            device == "iPhone 7 Plus" ||
//            device == "iPhone 8 Plus"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 60
//            imgProfile.clipsToBounds = true
//
//            smallLeft.isActive = false
//            smallRight.isActive = false
//            smallCenter.isActive = false
//
//            plusLeft.isActive = true
//            plusCenter.isActive = true
//            plusRight.isActive = true
//
//        }else if device == "Simulator iPhone 11 Pro" ||
//            device == "iPhone 11 Pro" ||
//            device == "iPhone XS"  ||
//            device == "iPhone X"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 56
//            imgProfile.clipsToBounds = true
//            smallLeft.isActive = false
//            smallRight.isActive = false
//            smallCenter.isActive = false
//
//            plusLeft.isActive = true
//            plusCenter.isActive = true
//            plusRight.isActive = true
//        }else if device == "Simulator iPhone 11" ||
//            device == "iPhone 11" ||
//            device == "iPhone XR" || device == "Simulator iPhone 12" ||
//            device == "Simulator iPhone 12 Pro" ||
//           device == "iPhone 12" || device == "iPhone 12 Pro"   {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 70
//            imgProfile.clipsToBounds = true
//            smallLeft.isActive = false
//            smallRight.isActive = false
//            smallCenter.isActive = false
//
//            plusLeft.isActive = true
//            plusCenter.isActive = true
//            plusRight.isActive = true
//        }
//        else if device == "Simulator iPhone 11 Pro Max" ||
//            device == "iPhone 11 Pro Max" ||
//            device == "iPhone XS Max"{
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 75
//            imgProfile.clipsToBounds = true
//            smallLeft.isActive = false
//            smallRight.isActive = false
//            smallCenter.isActive = false
//
//            plusLeft.isActive = true
//            plusCenter.isActive = true
//            plusRight.isActive = true
//        }
//        else if device == "Simulator iPhone 12 Pro Max" ||
//                    device == "iPhone 12 Pro Max"
//        {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 85
//            imgProfile.clipsToBounds = true
//            smallLeft.isActive = false
//            smallRight.isActive = false
//            smallCenter.isActive = false
//
//            plusLeft.isActive = true
//            plusCenter.isActive = true
//            plusRight.isActive = true
//    }else if device == "iPhone 12 mini" ||
//                device == "Simulator iPhone 12 mini"{
//
//        imgProfile.layer.borderWidth = 5.0
//        imgProfile.layer.masksToBounds = false
//        imgProfile.layer.borderColor = UIColor.white.cgColor
//        imgProfile.layer.cornerRadius = 75
//        imgProfile.clipsToBounds = true
//        smallLeft.isActive = false
//        smallRight.isActive = false
//        smallCenter.isActive = false
//
//        plusLeft.isActive = true
//        plusCenter.isActive = true
//        plusRight.isActive = true
//
//    }
        
        let ratings = LoginUser.getRatingsDetails.split{$0 == ","}.map(String.init)
        ratingView.rating = Double(ratings[0])!
        ratingView.text = "\(ratings[0]) (\(ratings[1]) Reviews)"
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor)]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.layer.borderWidth = 5.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds = true
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Udpate", style: UIBarButtonItem.Style.plain, target: self, action: #selector(updateProfile))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func updateProfile()  {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile1ViewController") as! UpdateProfile1ViewController
        mainVC.modalPresentationStyle = .fullScreen
        //self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func loadProfile(){
        RappleActivityIndicatorView.startAnimating()
        let request = UserProfileRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.UserProfile(method: MethodTypes.Post.rawValue, url: ApiUrls.userProfile, request: request, viewController: self).done { response in
            self.txtFullName.text = response.d.fullName
            self.txtContactNumber.text = response.d.mobile
            self.txtGender.text = response.d.gender
            self.txtEmailAddress.text = response.d.email
            self.txtIDCardNumber.text = response.d.iDCardNo
            self.txtPostalAddress.text = response.d.getUserAddress
            self.lblWelcomeMessage.text = self.lblWelcomeMessage.text!  + " " + response.d.fullName!
            RappleActivityIndicatorView.stopAnimation()
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
        }
    }
}

public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }()
}

