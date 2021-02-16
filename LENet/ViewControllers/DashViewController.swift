
import UIKit
import SWRevealViewController
import RappleProgressHUD
import Alamofire
import FirebaseCrashlytics


class DashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnAlert: UIBarButtonItem!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    public var dashItems = [DashItem]()
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstLaunch() {
            let readMore = UIAlertAction(title: "Read More", style: .default,handler: {
                (action) in
                UIApplication.shared.open(URL(string: LoginUser.getNoticeBoardLink)!)
            })
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            readMore.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: LoginUser.getNoticeBoardTitle, message: LoginUser.getNoticeBoard, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(readMore)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
        let revealController = revealViewController()
        revealController?.panGestureRecognizer()
        revealController?.tapGestureRecognizer()
        loadDashboard()
        let device = UIDevice.modelName
        if device == "Simulator iPhone 6s"  || device == "Simulator iPhone 8"  ||
            device == "iPhone 6" ||
            device == "iPhone 6s" ||
            device == "iPhone 7" ||
            device == "iPhone 8" ||
            device == "Simulator iPhone 6s Plus" ||
            device == "iPhone 6 Plus" ||
            device == "iPhone 6s Plus" ||
            device == "iPhone 7 Plus" ||
            device == "iPhone 8 Plus" {
            if UserDefaults.standard.bool(forKey: "touchID") == false  {
                BiometricAlertView(biometric: "Touch ID")
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
            if UserDefaults.standard.bool(forKey: "faceID")  == false {
                BiometricAlertView(biometric: "Face ID")
            }
        }
                else if device == "Simulator iPhone 12 Pro Max" ||
                    device == "iPhone 12 Pro Max"
                {
                  
                }
        else{
            if UserDefaults.standard.bool(forKey: "touchID") == false  {
                BiometricAlertView(biometric: "Touch ID")
            }
        }
        btnMenu.target = revealViewController()     
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        btnMenu.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        btnAlert.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        lblWelcome.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
               tableView.addSubview(refreshControl)
        
    }
    @objc func refresh(_ sender: AnyObject) {
           loadDashboard()
        
}
func isFirstLaunch() -> Bool {
        if (!UserDefaults.standard.bool(forKey: "launched_before")) {
            UserDefaults.standard.set(true, forKey: "launched_before")
            return true
        }
        return false
    }
    func BiometricAlertView(biometric: String!){
        let readMore = UIAlertAction(title: "Enable", style: .default,handler: {
            (action) in
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ManageBiometricsViewController") as! ManageBiometricsViewController
            mainVC.modalPresentationStyle = .fullScreen
            ManageBiometricsViewController.check = "0"
            self.navigationController?.pushViewController(mainVC,animated:true)
        })
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        readMore.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        dismiss.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Enable \(biometric!)", message: "Enable your \(biometric!) to login without entering email and password", preferredStyle: UIAlertController.Style.alert)
        
        if biometric == "Touch ID"
        {
            let image = UIImage(named: "touchid")
            alert.addImage(image: image!)
        }else{
            let image = UIImage(named: "faceid")
            alert.addImage(image: image!)
        }
        alert.addAction(readMore)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashTableViewCell", for: indexPath) as! DashTableViewCell
        cell.lblTitle.text = dashItems[indexPath.row].Title
        cell.lblTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.lblValue.text = dashItems[indexPath.row].Value
        cell.imgIcon.image = UIImage(named: dashItems[indexPath.row].Icon)
        cell.imgIcon.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.verticalView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.lblValue.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.cardView.borderWidth = 1.0
        cell.cardView.borderColor = UIColor.init(named: LoginUser.getThemeColor)
       
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        cell.selectedBackgroundView = UIView()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:DashTableViewCell = tableView.cellForRow(at: indexPath) as! DashTableViewCell
        
        if cell.lblTitle.text! == "F2F BOOKINGS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Complete"
            AllBookingsViewController.type = "2"
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "STEL BOOKINGS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Complete"
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.type = "4"
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "TOTAL F2F HOURS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Hour"
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.type = "2"
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "TOTAL STEL HOURS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Hour"
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.type = "4"
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "LATE BOOKINGS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Late"
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.type = ""
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "CANCELLED BY CUSTOMER"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "Customer"
            AllBookingsViewController.type = ""
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "BOOKINGS DID NOT ATTEND"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.placeholderImage = cell.imgIcon.image
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.Title = "DNA"
            AllBookingsViewController.type = ""
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "NO OF COMPLAINTS"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AllBookingsViewController") as! AllBookingsViewController
            AllBookingsViewController.Title = "Complaint"
            AllBookingsViewController.headTitle = cell.lblTitle.text!
            AllBookingsViewController.placeholderImage = UIImage(named: "TotalComplaints")
            AllBookingsViewController.placeholderTitle = cell.lblTitle.text!
            AllBookingsViewController.type = ""
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
        if cell.lblTitle.text! == "DBS EXPIRY"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"DBSExpiryViewController") as! DBSExpiryViewController
            DBSExpiryViewController.headTitle = cell.lblTitle.text!
            DBSExpiryViewController.DBSValue = cell.lblValue.text!
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC,animated:true)
        }
    }
    
    func loadDashboard(){
        RappleActivityIndicatorView.startAnimating()
        let request = DashboardRequest()
        request.idcardno = LoginUser.getIdCardNo
        ApiManager.api.Dashboard(method: MethodTypes.Post.rawValue, url: ApiUrls.dashboard, request: request, viewController: self).done { response in
            if response.d.Status != false {
                self.dashItems.append(contentsOf: response.d.List)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
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

extension UIAlertController {
    func addImage(image: UIImage){
        let maxSize = CGSize(width: 300, height: 50)
        let imgSize = image.size
        var ratio: CGFloat!
        if imgSize.width > imgSize.height {
            ratio = maxSize.width / imgSize.width
        }else{
            ratio = maxSize.height / imgSize.height
        }
        let scaledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        var resizedImage = image.imageWithSize(scaledSize)
        resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -100, bottom: 0, right: 0))
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        imgAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
        self.addAction(imgAction)
    }
}
