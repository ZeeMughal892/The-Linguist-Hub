
import UIKit
import RappleProgressHUD
import Alamofire

class ReportAnIssueViewController: BaseViewController,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var headFullName: UILabel!
    @IBOutlet weak var headSubject: UILabel!
    @IBOutlet weak var headReason: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtFullName: customUITextField!
    @IBOutlet weak var txtSubject: customUITextField!
    @IBOutlet weak var txtReason: customUITextView!
        
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMenuButtonToNavigationBar()
        self.title = "Report An Issue"
        
        lblMessage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headFullName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headSubject.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headReason.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        txtFullName.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtSubject.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        txtReason.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        
        txtFullName.delegate = self
        txtSubject.delegate = self
        txtReason.delegate = self
        self.HideKeyboard()
        btnSubmit.backgroundColor  = UIColor.init(named: LoginUser.getThemeColor)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func Keyboard(notification: Notification)
    {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    @IBAction func actionSubmit(_ sender: Any) {
        if (txtFullName.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Full Name" , ViewController: self)
            self.txtFullName.becomeFirstResponder()
        }else if (txtSubject.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Subject of Report" , ViewController: self)
            self.txtSubject.becomeFirstResponder()
        }else if (txtReason.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Your Message" , ViewController: self)
            self.txtReason.becomeFirstResponder()
        }else{
            RappleActivityIndicatorView.startAnimating()
            let request = ReportAnIssueRequest()
            request.IdCardNo = LoginUser.getIdCardNo
            request.Name = LoginUser.getFirstName + LoginUser.getLastName
            request.Subject = txtSubject.text
            request.Body = txtReason.text
            request.DeviceType = LoginUser.getDeviceType
            ApiManager.api.ReportAnIssue(method: MethodTypes.Post.rawValue, url: ApiUrls.reportAnIssue, request: request, viewController: self).done { response in
                if response.d.Status != false{
                    Modals.CreateAlert(title: "Successfull !!!", message: response.d.Message , ViewController: self)
                    self.txtFullName.text = ""
                    self.txtSubject.text = ""
                    self.txtReason.text = ""
                    RappleActivityIndicatorView.stopAnimation()
                }else{
                    Modals.CreateAlert(title: "Error!", message: response.d.Message , ViewController: self)
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
}
