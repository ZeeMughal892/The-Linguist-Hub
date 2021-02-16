
import UIKit
import RappleProgressHUD

class AbsenceViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    public static var absenceItems = [AbsenceItem]()
   // var refreshControl = UIRefreshControl()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Absence"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        self.loadAbsences()
       
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
         //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
          //     refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
          //     tableView.addSubview(refreshControl)
        
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddAbsence))

        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func AddAbsence()  {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AddAbsenceViewController") as! AddAbsenceViewController
        mainVC.modalPresentationStyle = .fullScreen
        AddAbsenceViewController.AVC = self
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
   // @objc func refresh(_ sender: AnyObject) {
   //        loadAbsences()
   // }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AbsenceViewController.absenceItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbsenceTableViewCell") as! AbsenceTableViewCell
        cell.lblFromDate.text = AbsenceViewController.absenceItems[indexPath.row].DateFromUkFormat
        cell.lblToDate.text = AbsenceViewController.absenceItems[indexPath.row].DateToUkFormat
        cell.lblReason.text = AbsenceViewController.absenceItems[indexPath.row].Reason
        cell.lblCanContact.text = AbsenceViewController.absenceItems[indexPath.row].GetInContact
        cell.headFrom.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headTo.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headCanContact.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headReason.textColor = UIColor.init(named: LoginUser.getThemeColor)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
            cell.selectedBackgroundView = UIView() 
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let hID = AbsenceViewController.absenceItems[indexPath.row].UniqueId
            AbsenceViewController.absenceItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.deleteAbsence(holidayId: hID)
        }
    }
    
    func deleteAbsence(holidayId: Int!){
        RappleActivityIndicatorView.startAnimating()
        let request = DeleteAbsenceRequest()
        request.idCardNo = LoginUser.getIdCardNo
        request.holidayId = holidayId
        ApiManager.api.DeleteAbsence(method: MethodTypes.Post.rawValue, url: ApiUrls.deleteAbsence, request: request, viewController: self).done { response in
            if response.d.Status != false {
                if response.d.List.count != 0 {
                    AbsenceViewController.absenceItems.removeAll()
                    AbsenceViewController.absenceItems.append(contentsOf: response.d.List)
                }else{
                    self.setupEmptyBackgroundView()
                }
                RappleActivityIndicatorView.stopAnimation()
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
    func loadAbsences(){
        RappleActivityIndicatorView.startAnimating()
        let request = LoadAbsenceRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.LoadAbsence(method: MethodTypes.Post.rawValue, url: ApiUrls.loadAbsence, request: request, viewController: self).done { response in
            if response.d.Status != false {
                if response.d.List.count == 0 {
                    self.setupEmptyBackgroundView()
                }else{
                    AbsenceViewController.absenceItems.removeAll()
                    AbsenceViewController.absenceItems.append(contentsOf: response.d.List)
                    self.tableView.reloadData()
                }
                RappleActivityIndicatorView.stopAnimation()
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
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "Absence")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "Absences"
        let bottomMessage = "You don't have any absence. All your absences will show up here."
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        AddAbsenceViewController.AVC = self  // Pass the value of VCA in instance of VCB while navigating through segue
    }
}
