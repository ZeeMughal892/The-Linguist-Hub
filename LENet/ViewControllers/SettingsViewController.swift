
import UIKit
import RappleProgressHUD
import LabelSwitch

class SettingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuNameArr:Array = [String]()
    var iconImage:Array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.addMenuButtonToNavigationBar()
        self.title = "Settings"
        
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
            if LoginUser.isFullTime == true{
                menuNameArr = ["PCA",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!]
            }else{
                menuNameArr = ["PCA",
                               "Absence",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "IcoAbsence")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!
                ]
            }
            
        }else if device == "Simulator iPhone 11" ||
            device == "iPhone 11" ||
            device == "iPhone XR" ||
            device == "Simulator iPhone 11 Pro" ||
            device == "iPhone 11 Pro" ||
            device == "iPhone XS"  ||
            device == "iPhone X" ||
            device == "iPhone 12 mini" ||
            device == "Simulator iPhone 12 mini" ||
            device == "Simulator iPhone 11 Pro Max" ||
            device == "iPhone 11 Pro Max" ||
            device == "iPhone XS Max"{
            if LoginUser.isFullTime == true{
                menuNameArr = ["PCA",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!]
            }else{
                menuNameArr = ["PCA",
                               "Absence",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "IcoAbsence")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!
                ]
            }
        }
                else if device == "Simulator iPhone 12 Pro Max" ||
                    device == "iPhone 12 Pro Max"
                {
                  
                }
        else{
            
            if LoginUser.isFullTime == true{
                menuNameArr = ["PCA",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!]
            }else{
                menuNameArr = ["PCA",
                               "Absence",
                               "Manage Touch ID",
                               "Change Theme Color"]
                iconImage = [UIImage(named: "IcoPCA")!,
                             UIImage(named: "IcoAbsence")!,
                             UIImage(named: "touchid")!,
                             UIImage(named: "IcoTheme")!
                ]
            }
        }
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if indexPath.row == 4 && LoginUser.isFullTime == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
            cell.img.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblTitle.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        }else if indexPath.row == 3 && LoginUser.isFullTime == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
            cell.img.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblTitle.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
            cell.imgMenu.image = iconImage[indexPath.row]
            cell.imgMenu.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblMenuItem.text! = menuNameArr[indexPath.row]
            cell.lblMenuItem.textColor = UIColor.init(named: LoginUser.getThemeColor)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear           
            cell.selectedBackgroundView = UIView()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
            let _:NotificationTableViewCell = tableView.cellForRow(at: indexPath) as! NotificationTableViewCell
            
        }else{
            let cell:SettingsTableViewCell = tableView.cellForRow(at: indexPath) as! SettingsTableViewCell
            if cell.lblMenuItem.text! == "Absence"
            {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AbsenceViewController") as! AbsenceViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
            if cell.lblMenuItem.text! == "Manage Touch ID"
            {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ManageBiometricsViewController") as! ManageBiometricsViewController
                ManageBiometricsViewController.check = "1"
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
            if cell.lblMenuItem.text! == "Manage Face ID"
            {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ManageBiometricsViewController") as! ManageBiometricsViewController
                mainVC.modalPresentationStyle = .fullScreen
                ManageBiometricsViewController.check = "1"
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
            if cell.lblMenuItem.text! == "PCA"
            {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PCAViewController") as! PCAViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
            if cell.lblMenuItem.text! == "Change Theme Color" {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ChangeThemeColorViewController") as! ChangeThemeColorViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }    
}

