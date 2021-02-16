
import UIKit

class ContactUsViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    public static var successMessage:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMenuButtonToNavigationBar()
        self.title = "Contact Us"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        if ContactUsViewController.successMessage == "" {
            
        }else{
            Modals.CreateAlert(title: "", message: ContactUsViewController.successMessage, ViewController: self)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            let device = UIDevice.modelName
            if device == "Simulator iPhone 6s"  ||
                device == "iPhone 6" ||
                device == "iPhone 6s" ||
                device == "iPhone 7" ||
                device == "iPhone 8" ||
                device == "Simulator iPhone 6s Plus" ||
                device == "iPhone 6 Plus" ||
                device == "iPhone 6s Plus" ||
                device == "iPhone 7 Plus" ||
                device == "iPhone 8 Plus" {
                return 135
            }else{
                return 150
            }
        }
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as! PhoneTableViewCell
            cell.lblTitle.text = "Phone"
            cell.lblTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.verticalView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.imgIcon.image = UIImage(named:"ImgCell")
            cell.imgIcon.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.cardView.borderWidth = 1.0
            cell.cardView.borderColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblPhone.font = UIFont(name: "copperplate-bold", size: 15)
            cell.lblPhone.text = LoginUser.getLEContactNo
                cell.selectedBackgroundView = UIView()
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell") as! PhoneTableViewCell
            cell.lblTitle.text = "Email"
             cell.lblTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.imgIcon.image = UIImage(named:"ImgEmail")
            cell.lblPhone.text = LoginUser.getLEContactEmail
             cell.imgIcon.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.verticalView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.cardView.borderWidth = 1.0
            cell.cardView.borderColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblPhone.font = UIFont(name: "copperplate-bold", size: 15)
            cell.lblPhone.textColor = UIColor.init(named: "colorGreen")
                cell.selectedBackgroundView = UIView()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLinksTableViewCell") as! SocialLinksTableViewCell
            cell.btnFacebook.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.btnTwitter.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.btnLinkedin.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let phoneStr = LoginUser.getLEContactNo
            let phone = phoneStr.replacingOccurrences(of: " ", with: "")
            if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else if indexPath.row == 1 {
           EmailAlertView.instance.showAlert()
        }
    }
}
