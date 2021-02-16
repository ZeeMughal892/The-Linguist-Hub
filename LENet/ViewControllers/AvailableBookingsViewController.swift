

import UIKit
import SWRevealViewController
import RappleProgressHUD
import LabelSwitch

enum scopeAvailable:Int {
    case requestedUser = 0
    case postcode = 1
}
class AvailableBookingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var lblMessage: PaddingLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnView: UIView!
    public var bookingItem = [BookingModel]()
    public var bookingSwitch = [BookingModel]()
    var gender:String = ""
    @IBOutlet weak var viewSwitch: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    public var lstFilteredBookings : [BookingModel] = []
    public var lstFilteredSwitchBookings : [BookingModel] = []
    var labelSwitch = LabelSwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Bookings"
        self.addMenuButtonToNavigationBar()
        let ls = LabelSwitchConfig(text: "YES",
                                   textColor: .systemBackground,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)

        let rs = LabelSwitchConfig(text: "NO",
                                   textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: .systemBackground)
      
        let device = UIDevice.modelName
              if device == "Simulator iPhone 6s"  ||
                  device == "Simulator iPhone 8"  ||
                  device == "iPhone 6" ||
                  device == "iPhone 6s" ||
                  device == "iPhone 7" ||
                  device == "iPhone 8" {
                  labelSwitch = LabelSwitch(center: .init(x: 20, y: 32), leftConfig: ls, rightConfig: rs)
              }else if device == "Simulator iPhone 6s Plus" ||
                  device == "Simulator iPhone 8 Plus" ||
                  device == "iPhone 6 Plus" ||
                  device == "iPhone 6s Plus" ||
                  device == "iPhone 7 Plus" ||
                  device == "iPhone 8 Plus"  {

                labelSwitch = LabelSwitch(center: .init(x: 24, y: 32), leftConfig: ls, rightConfig: rs)

              }else if device == "Simulator iPhone 11 Pro" ||
                  device == "iPhone 11 Pro" ||
                  device == "iPhone XS"  ||
                  device == "iPhone X" ||
                  device == "iPhone 12 mini" ||
                 device == "Simulator iPhone 12 mini"{
                     labelSwitch = LabelSwitch(center: .init(x: 24, y: 32), leftConfig: ls, rightConfig: rs)
              }else if device == "Simulator iPhone 11" ||
                  device == "iPhone 11" ||
                  device == "iPhone XR"   {
                   labelSwitch = LabelSwitch(center: .init(x: 22, y: 32), leftConfig: ls, rightConfig: rs)
              }
              else if device == "Simulator iPhone 11 Pro Max" ||
                  device == "iPhone 11 Pro Max" ||
                  device == "iPhone XS Max"{
                   labelSwitch = LabelSwitch(center: .init(x: 24, y: 36), leftConfig: ls, rightConfig: rs)
              }else if device == "Simulator iPhone 12 Pro" ||
                        device == "iPhone 12 Pro"
                    {
                      labelSwitch = LabelSwitch(center: .init(x: 22, y: 32), leftConfig: ls, rightConfig: rs)
                    }
              else if device == "Simulator iPhone 12" ||
                  device == "iPhone 12"  {
                   labelSwitch = LabelSwitch(center: .init(x: 22, y: 32), leftConfig: ls, rightConfig: rs)
              }
              else if device == "Simulator iPhone 12 Pro Max" ||
                  device == "iPhone 12 Pro Max"
              {
                labelSwitch = LabelSwitch(center: .init(x: 24, y: 36), leftConfig: ls, rightConfig: rs)
              }
              else if device == "iPhone 12 mini" ||
                 device == "Simulator iPhone 12 mini"{
                     labelSwitch = LabelSwitch(center: .init(x: 24, y: 32), leftConfig: ls, rightConfig: rs)
              }
        
        labelSwitch.circleShadow = true
        labelSwitch.fullSizeTapEnabled = true
        labelSwitch.layer.borderWidth = 1.0
        labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        labelSwitch.delegate = self
        //labelSwitch.frame = CGRect(x: viewSwitch.bounds.origin.x, y: viewSwitch.bounds.origin.y, width: viewSwitch.bounds.size.width, height: viewSwitch.bounds.size.height)
       viewSwitch.addSubview(labelSwitch)
        
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.scopeButtonTitles = ["Requested Gender", "Postcode"]
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        searchController.searchBar.selectedScopeButtonIndex = 0
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        //refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
       // tableView.addSubview(refreshControl)
        
        let revealController = revealViewController()
        revealController?.panGestureRecognizer()
        revealController?.tapGestureRecognizer()
      
        gender =  UserDefaults.standard.string(forKey: "gender")!
        
        if (gender == "Female") {
            lblMessage.text = "Show Bookings for Female Non-English Speakers Only"
        }else{
            lblMessage.text = "Show Bookings for Male Non-English Speakers Only"
        }
        self.loadAvailableBookings()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
  //  @objc func refresh(_ sender: AnyObject) {
  //      loadAvailableBookings()
  //  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isFiltering && bookingItem.count != 0 && labelSwitch.curState == .R{
            return bookingSwitch.count
        }
        else if isFiltering && bookingItem.count != 0 && labelSwitch.curState == .L {
            return lstFilteredBookings.count
        }
        else if isFiltering && bookingItem.count != 0 && labelSwitch.curState == .R {
            return lstFilteredSwitchBookings.count
        }
        else{
            return bookingItem.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if labelSwitch.curState == .R {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableBookingsTableViewCell") as! AvailableBookingsTableViewCell
            if isFiltering {
                let filteredBooking = lstFilteredSwitchBookings[indexPath.row]
                cell.setDetails(booking: filteredBooking)
            }else{
                let booking = bookingSwitch[indexPath.row]
                cell.setDetails(booking: booking)
            }
            cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headPostcode.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headGender.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headReq.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.btnDetails.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.delegate = self
            
            tableView.backgroundColor = .clear
            tableView.tableFooterView = UIView()
            cell.selectedBackgroundView = UIView()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableBookingsTableViewCell") as! AvailableBookingsTableViewCell
            if isFiltering {
                let filteredBooking = lstFilteredBookings[indexPath.row]
                cell.setDetails(booking: filteredBooking)
            }else{
                let booking = bookingItem[indexPath.row]
                cell.setDetails(booking: booking)
            }
            cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headPostcode.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headGender.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.headReq.textColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.btnDetails.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.delegate = self
            
            tableView.backgroundColor = .clear
            tableView.tableFooterView = UIView()
            cell.selectedBackgroundView = UIView()
            return cell
        }
    }
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    func filterTableView(scope:Int, text: String, switchState: LabelSwitchState) {
        if switchState == .R {
            switch scope {
            case scopeAvailable.requestedUser.rawValue:
                lstFilteredSwitchBookings = bookingSwitch.filter({(bookings: BookingModel) -> Bool in
                    return bookings.intGender.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            case scopeAvailable.postcode.rawValue:
                lstFilteredSwitchBookings = bookingSwitch.filter({(bookings: BookingModel) -> Bool in
                    return bookings.postCodeArea.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            default:
                print(scope)
            }
        }else{
            switch scope {
            case scopeAvailable.requestedUser.rawValue:
                lstFilteredBookings = bookingItem.filter({(bookings: BookingModel) -> Bool in
                    return bookings.intGender.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            case scopeAvailable.postcode.rawValue:
                lstFilteredBookings = bookingItem.filter({(bookings: BookingModel) -> Bool in
                    return bookings.postCodeArea.lowercased().contains(text.lowercased())
                })
                self.tableView.reloadData()
            default:
                print(scope)
            }
        }
    }
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "booking")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "Available Bookings"
        let bottomMessage = "You don't have any available bookings. All your bookings will show up here."
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.btnView.isHidden = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
        Modals.CreateAlert(title: "Attention !!!", message: LoginUser.getEmptyMessage, ViewController: self)
    }   
    func loadAvailableBookings(){
        RappleActivityIndicatorView.startAnimating()
        let request = AvailableBookingRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.AvailableBooking(method: MethodTypes.Post.rawValue, url: ApiUrls.availableBooking, request: request, viewController: self).done { response in
            if response.d.count != 0 {
                self.bookingItem.append(contentsOf: response.d)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }
            else{
                self.setupEmptyBackgroundView()
                RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
        }
    }
}

extension AvailableBookingsViewController : AvailableBookingDelegate{
    func didTapInterested(bookingId: Int) {
        RappleActivityIndicatorView.startAnimating()
        let request = InterestRequest()
        request.userId  = LoginUser.getUserID
        request.idCardNo = LoginUser.getIdCardNo
        request.bookingId = bookingId
        ApiManager.api.SaveInterest(method: MethodTypes.Post.rawValue, url: ApiUrls.saveInterest, request: request, viewController: self).done { response in
            if response.d.Status != false {
                Modals.CreateAlert(title: "", message: "Your Interest has been Registered! You Will Receive Confirmation Shortly.", ViewController: self)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }
            else{
                self.setupEmptyBackgroundView()
                RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
        }
    }
    
    func didTapDecline(bookingId: Int) {
        let btnYes = UIAlertAction(title: "Yes", style: .default,handler: {
            (action) in
            RappleActivityIndicatorView.startAnimating()
            let request = InterestRequest()
            request.userId  = LoginUser.getUserID
            request.idCardNo = LoginUser.getIdCardNo
            request.bookingId = bookingId
            ApiManager.api.DeclineInterest(method: MethodTypes.Post.rawValue, url: ApiUrls.declineInterest, request: request, viewController: self).done { response in
                if response.d.Status != false  {
                    Modals.CreateAlert(title: "", message: "You Delined the Booking", ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
                    self.tableView.reloadData()
                }
                else{
                    self.setupEmptyBackgroundView()
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
            }
        })
        let btnNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
        btnYes.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        btnNo.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Confirmation", message: "Are You Sure You Want to Decline this Booking?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(btnYes)
        alert.addAction(btnNo)
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapDetails(bookingItem: BookingModel) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"BookingDetailsViewController") as! BookingDetailsViewController
        BookingDetailsViewController.bookingItem = bookingItem
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}
extension AvailableBookingsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty && labelSwitch.curState == .L {
            lstFilteredBookings = bookingItem
            self.tableView.reloadData()
        }
        else if searchText.isEmpty && labelSwitch.curState == .R{
            lstFilteredSwitchBookings = bookingSwitch
            self.tableView.reloadData()
        }
        else{
            if labelSwitch.curState == .R{
                filterTableView(scope: searchBar.selectedScopeButtonIndex, text: searchText,switchState: .R)
            }else{
                filterTableView(scope: searchBar.selectedScopeButtonIndex, text: searchText, switchState: .L)
            }
        }
    }
}

extension AvailableBookingsViewController : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
            tableView.reloadData()
        case .R:
          for i in  0...bookingItem.count - 1 {
              let bookingModel: BookingModel = bookingItem[i]
              let serviceUserGender = bookingModel.serviceUserGender
              if serviceUserGender != nil && serviceUserGender == gender {
                  bookingSwitch.append(bookingModel)
              }
          }
          tableView.reloadData()
        }
    }
}
