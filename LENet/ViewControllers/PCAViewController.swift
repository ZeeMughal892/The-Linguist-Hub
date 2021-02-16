
import UIKit
import RappleProgressHUD

class PCAViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnShowPCA: UIButton!
    @IBOutlet weak var checkView: UIStackView!
//    @IBOutlet weak var btnUpdate: UIBarButtonItem!
//    @IBOutlet weak var btnBack: UIBarButtonItem!
    public var lstResults = [PCAs]()
    public var PCAList = [PCAs]()
    var PostcodeOnly: Int!
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    var UnSelectedTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PCA"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        btnShowPCA.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        self.getPCASettings()
        tableView.reloadData()
               
        if PCAList.count == 0{
           self.setupEmptyBackgroundView()
        }
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
               navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Udpate", style: UIBarButtonItem.Style.plain, target: self, action: #selector(updateProfile))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func updateProfile()  {
        RappleActivityIndicatorView.startAnimating()
        let request = UpdatePCARequest()
        request.idCardNo = LoginUser.getIdCardNo
        request.excludedPca = UnSelectedTitles
        request.postcodeOnly = self.PostcodeOnly
        ApiManager.api.UpdatePCA(method: MethodTypes.Post.rawValue, url: ApiUrls.updatePCA, request: request, viewController: self).done { response in
            if response.d.Status != false {
                Modals.CreateAlert(title: "", message: "PCA Settings Updated", ViewController: self)
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
    @IBAction func actionShowPCA(_ sender: Any) {
        if btnShowPCA.currentImage == checkedImage{
            PostcodeOnly = 0
            btnShowPCA.setImage(uncheckedImage, for: .normal)
        }else{
            PostcodeOnly = 1
            btnShowPCA.setImage(checkedImage, for: .normal)
        }
    }   
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstResults.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pca = lstResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PCATableViewCell") as! PCATableViewCell
        cell.btnCheck.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.setDetails(pca: pca)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        cell.selectedBackgroundView = UIView()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:PCATableViewCell = tableView.cellForRow(at: indexPath) as! PCATableViewCell
        //let pca = PCAList[indexPath.row]
        if cell.btnCheck.currentImage == checkedImage
        {
            cell.btnCheck.setImage(uncheckedImage, for: .normal)
        }else{
            cell.btnCheck.setImage(checkedImage, for: .normal)
        }
    }
    func getPCASettings(){
        RappleActivityIndicatorView.startAnimating()
        let request = GetPCARequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.GetPCA(method: MethodTypes.Post.rawValue, url: ApiUrls.getPCA, request: request, viewController: self).done { response in
            if response.d.Status != false {
                self.lstResults.append(contentsOf: response.d.ListSurroundingPCAs)
                self.PostcodeOnly = response.d.PostcodeOnly
                if self.PostcodeOnly == 0 {
                    self.btnShowPCA.setImage(self.uncheckedImage, for: .normal)
                }else{
                    self.btnShowPCA.setImage(self.checkedImage, for: .normal)
                }
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }
            else{
                Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                self.setupEmptyBackgroundView()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
        }
    }
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "IcoPCA")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "PCA"
        let bottomMessage = "No PCA Available"
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
extension PCAViewController : PCADelegate {
    func didTapBtnCheck(PCAName: String, PCAIsChecked: Bool) {
        if PCAIsChecked == false {
            UnSelectedTitles.append(PCAName)
        }
    }
}
