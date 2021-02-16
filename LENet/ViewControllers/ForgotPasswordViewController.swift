
import UIKit
import RappleProgressHUD
import Alamofire

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var headMessage: UILabel!
    @IBOutlet weak var headID: UILabel!
    @IBOutlet weak var headEmail: UILabel!
    @IBOutlet weak var headPhone: UILabel!
    @IBOutlet weak var txtIdCardNo: customUITextField!
    @IBOutlet weak var txtEmail: customUITextField!
    @IBOutlet weak var txtPhone: customUITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headMessage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headID.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headEmail.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPhone.textColor = UIColor.init(named: LoginUser.getThemeColor)
        btnSubmit.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        btnLogin.setTitleColor(UIColor.init(named: LoginUser.getThemeColor), for: .normal)
       // txtIdCardNo.text = "61269"        txtEmail.text = "monika.wieczorek@empire-groupuk.com"        txtPhone.text = "07849018891"
        navigationController?.navigationBar.barTintColor = .systemBackground
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    @IBAction func actionSubmit(_ sender: Any) {
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
        if(txtPhone.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Phone Number" , ViewController: self)
            self.txtPhone.becomeFirstResponder()
        }else{
            RappleActivityIndicatorView.startAnimating()
            let request = ForgotPasswordRequest()
            request.idcardno = txtIdCardNo.text!
            request.email = txtEmail.text!
            request.phone = txtPhone.text!
            request.deviceId = UIDevice.current.identifierForVendor?.uuidString
            request.deviceType = "iOS"
            ApiManager.api.ForgotPassword(method: MethodTypes.Post.rawValue, url: ApiUrls.forgotPassword, request: request, viewController: self).done { response in
                if response.d.Status == true && response.d.Message != nil{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
                }else{
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
    @IBAction func actionLogin(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC,animated:true,completion:nil)
    }
}
