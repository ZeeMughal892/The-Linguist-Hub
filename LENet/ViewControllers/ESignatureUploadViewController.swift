

import UIKit
import RappleProgressHUD

class ESignatureUploadViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    public var bookingToday = [UploadJobsheetModel]()
    //public var bookingPrevious = [UploadJobsheetModel]()
    var refreshControl = UIRefreshControl()
    
    //let headerTitles = ["Today", "Previous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "E-Signature Upload"
        self.addMenuButtonToNavigationBar()
        self.loadUploadJobsheet()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named:LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    
        
    }
    
    func filterBookings(list: [UploadJobsheetModel]){
        for i in 0...list.count - 1 {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let result = formatter.string(from: date)
            if list[i].appointmentDateUKFormatted == result {
                bookingToday.append(list[i])
            }else{
               // bookingPrevious.append(list[i])
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return bookingToday.count
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
             let cell = tableView.dequeueReusableCell(withIdentifier: "ESignatureUploadTableViewCell", for: indexPath) as! ESignatureUploadTableViewCell
            let booking = bookingToday[indexPath.row]
            let request = GetTempDataRequest()
            request.BookingId = booking.bookingId
            ApiManager.api.GetTempData(method: MethodTypes.Post.rawValue, url: ApiUrls.getDisplayTempUploadJobSheet, request: request, viewController: self).done { response in
                if response.d.Status != false && response.d.Data != nil {
                    cell.btnUploadSignature.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.lblView.isHidden = false
                    cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headDate.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.setDetails(booking: booking)
                    cell.delegate = self
                    cell.selectedBackgroundView = UIView()
                    tableView.tableFooterView = UIView()
                    tableView.backgroundColor = .clear
                }else{
                    cell.btnUploadSignature.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.lblView.isHidden = true
                    cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headDate.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
                    cell.setDetails(booking: booking)
                    cell.delegate = self
                    cell.selectedBackgroundView = UIView()
                    tableView.tableFooterView = UIView()
                    tableView.backgroundColor = .clear
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "Error!", message: error.localizedDescription, ViewController: self)
            }
            return cell
    }
    func loadUploadJobsheet(){
        RappleActivityIndicatorView.startAnimating()
        let request = GetUploadJobsheetRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.GetUploadJobsheet(method: MethodTypes.Post.rawValue, url: ApiUrls.getUploadJobsheet, request: request, viewController: self).done { response in
            if response.d.Status != false && response.d.BookingList.count != 0{
                RappleActivityIndicatorView.stopAnimation()
                self.filterBookings(list: response.d.BookingList)
                self.tableView.reloadData()
            }else{
                self.setupEmptyBackgroundView()
                RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "Error!", message: error.localizedDescription, ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
        }
    }
    
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "signature")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "No Jobsheet Available"
        let bottomMessage = "You don't have any jobsheets for today upload. All your jobsheets will show up here."
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
extension ESignatureUploadViewController : ESignatureUploadDelegate {
    func didTapUpload(bookingItem: UploadJobsheetModel) {
        let request = GetTempDataRequest()
        request.BookingId = bookingItem.bookingId
        ApiManager.api.GetTempData(method: MethodTypes.Post.rawValue, url: ApiUrls.getDisplayTempUploadJobSheet, request: request, viewController: self).done { response in
            if response.d.Status != true && response.d.Data == nil {
                JobsheetInfoRequestModel.BookingId = bookingItem.bookingId
                JobsheetInfoRequestModel.idCardNo = LoginUser.getIdCardNo
                UploadJobsheetWizard1ViewController.bookingStartTime = bookingItem.appointmentTimeUKFormatted
                UploadJobsheetWizard1ViewController.duration = bookingItem.bookingDuration
                UploadJobsheetWizard3ViewController.bookingStartTime = bookingItem.appointmentTimeUKFormatted
                UploadJobsheetWizard3ViewController.duration = bookingItem.bookingDuration
                UploadJobsheetWizard1ViewController.clientId = bookingItem.clientId
                UploadJobsheetWizard3ViewController.bookingLanguage = bookingItem.bookingLanguage
                UploadJobsheetWizard3ViewController.rateType = bookingItem.rateType
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard1ViewController") as! UploadJobsheetWizard1ViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }else{
                if bookingItem.bookingLanguage.contains("*") || bookingItem.rateType == "Band 5"{
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard4ViewController") as! UploadJobsheetWizard4ViewController
                    JobsheetInfoRequestModel.BookingId = bookingItem.bookingId
                    JobsheetInfoRequestModel.idCardNo = LoginUser.getIdCardNo
                    UploadJobsheetWizard1ViewController.bookingStartTime = bookingItem.appointmentTimeUKFormatted
                    UploadJobsheetWizard1ViewController.duration = bookingItem.bookingDuration
                    UploadJobsheetWizard1ViewController.clientId = bookingItem.clientId
                    UploadJobsheetWizard3ViewController.bookingLanguage = bookingItem.bookingLanguage
                    UploadJobsheetWizard3ViewController.rateType = bookingItem.rateType
                    mainVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }else if UploadJobsheetWizard1ViewController.clientId == 514 ||
                    UploadJobsheetWizard1ViewController.clientId == 512 ||
                    UploadJobsheetWizard1ViewController.clientId == 565 ||
                    UploadJobsheetWizard1ViewController.clientId == 940 ||
                    UploadJobsheetWizard1ViewController.clientId == 941 ||
                    UploadJobsheetWizard1ViewController.clientId == 942 ||
                    UploadJobsheetWizard1ViewController.clientId == 567 ||
                    UploadJobsheetWizard1ViewController.clientId == 513 ||
                    UploadJobsheetWizard1ViewController.clientId == 566 ||
                    UploadJobsheetWizard1ViewController.clientId == 943 ||
                    UploadJobsheetWizard1ViewController.clientId == 944 ||
                    UploadJobsheetWizard1ViewController.clientId == 939 ||
                    UploadJobsheetWizard1ViewController.clientId == 531  {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard6ViewController") as! UploadJobsheetWizard6ViewController
                    mainVC.modalPresentationStyle = .fullScreen
                    JobsheetInfoRequestModel.BookingId = bookingItem.bookingId
                    JobsheetInfoRequestModel.idCardNo = LoginUser.getIdCardNo
                    UploadJobsheetWizard1ViewController.bookingStartTime = bookingItem.appointmentTimeUKFormatted
                    UploadJobsheetWizard1ViewController.duration = bookingItem.bookingDuration
                    UploadJobsheetWizard1ViewController.clientId = bookingItem.clientId
                    UploadJobsheetWizard3ViewController.bookingLanguage = bookingItem.bookingLanguage
                    UploadJobsheetWizard3ViewController.rateType = bookingItem.rateType
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }else{
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard7ViewController") as! UploadJobsheetWizard7ViewController
                    JobsheetInfoRequestModel.OtherExpenses = ""
                    JobsheetInfoRequestModel.PublicTransportCost = ""
                    JobsheetInfoRequestModel.TravelTime = ""
                    JobsheetInfoRequestModel.TyneTunnel = ""
                    JobsheetInfoRequestModel.BookingId = bookingItem.bookingId
                    JobsheetInfoRequestModel.idCardNo = LoginUser.getIdCardNo
                    UploadJobsheetWizard1ViewController.bookingStartTime = bookingItem.appointmentTimeUKFormatted
                    UploadJobsheetWizard1ViewController.duration = bookingItem.bookingDuration
                    UploadJobsheetWizard1ViewController.clientId = bookingItem.clientId
                    UploadJobsheetWizard3ViewController.bookingLanguage = bookingItem.bookingLanguage
                    UploadJobsheetWizard3ViewController.rateType = bookingItem.rateType
                    mainVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "Error!", message: error.localizedDescription, ViewController: self)
        }
    }
}
