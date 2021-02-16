

import UIKit
import RappleProgressHUD

class BookingRequestsViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnDecline: UIButton!
    public var bookingItem = [BookingRequestModel]()
    var selectedIds = [String]()
    
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    //var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "My Requests"
        self.addMenuButtonToNavigationBar()
         btnView.isHidden = true
        
        self.loadBookingRequests()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
      //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
                   //tableView.addSubview(refreshControl)
            
        }
        //@objc func refresh(_ sender: AnyObject) {
       //        loadBookingRequests()
       // }
    
    @IBAction func actionSubmit(_ sender: Any) {
        let unique = Array(Set(selectedIds))
        if unique.isEmpty {
            Modals.CreateAlert(title: "Error", message: "No Booking Selected", ViewController: self)
        }else{
            let request = SubmitBookingRequest()
            request.idCardNo = LoginUser.getIdCardNo
            request.status = true
            request.bookingIDs = unique.joined(separator: ",")
            ApiManager.api.SubmitBookingReq(method: MethodTypes.Post.rawValue, url: ApiUrls.SubmitBookingRequests, request: request, viewController: self).done { response in
                if response.d.Status != false {
                    Modals.CreateAlert(title: "Submitted", message: response.d.Message, ViewController: self)
                    SearchBookingDetailsViewController.bookingRequest.description = nil
                    RappleActivityIndicatorView.stopAnimation()
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
    
    @IBAction func actionDecline(_ sender: Any) {
        let unique = Array(Set(selectedIds))        
        if unique.isEmpty {
            Modals.CreateAlert(title: "Error", message: "No Booking Selected", ViewController: self)
        }else{
            let request = SubmitBookingRequest()
            request.idCardNo = LoginUser.getIdCardNo
            request.status = false
            request.bookingIDs = unique.joined(separator: ",")
            ApiManager.api.SubmitBookingReq(method: MethodTypes.Post.rawValue, url: ApiUrls.SubmitBookingRequests, request: request, viewController: self).done { response in
                if response.d.Status != false {
                    Modals.CreateAlert(title: "Declined", message: response.d.Message, ViewController: self)
                     SearchBookingDetailsViewController.bookingRequest.description = nil
                    RappleActivityIndicatorView.stopAnimation()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let booking = bookingItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingRequestsTableViewCell", for: indexPath) as! BookingRequestsTableViewCell
        cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headLocation.textColor = UIColor.init(named: LoginUser.getThemeColor)       
        cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.btnCheck.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.delegate = self
        cell.setDetails(booking: booking)
        tableView.tableFooterView = UIView()
        cell.selectedBackgroundView = UIView()
        tableView.backgroundColor = .clear
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SearchBookingDetailsViewController") as! SearchBookingDetailsViewController
        SearchBookingDetailsViewController.bookingRequest = bookingItem[indexPath.row]
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    func loadBookingRequests(){
        RappleActivityIndicatorView.startAnimating()
        let request = BookingReqRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.BookingRequest(method: MethodTypes.Post.rawValue, url: ApiUrls.bookingRequests, request: request, viewController: self).done { response in
            if response.d.count != 0 {
                self.bookingItem.append(contentsOf: response.d)
                RappleActivityIndicatorView.stopAnimation()
                self.btnView.isHidden = false
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
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "booking")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "My Requests"
        let bottomMessage = "Here you can view the booking(s) you have been specifically requested for and you have the option to accept or decline"
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        btnView.isHidden = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension BookingRequestsViewController: BookingsRequestDelegate{
    func didTapMap(bookingItem: BookingRequestModel) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"LocationViewController") as! LocationViewController
        LocationViewController.lat = bookingItem.venueLat
        LocationViewController.lng = bookingItem.venueLong
        LocationViewController.address = bookingItem.venueAddressLine1 + " " + bookingItem.region + " " + bookingItem.venuePostCode
        mainVC.modalPresentationStyle = .fullScreen
       // self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
        
    }
    
    func didTapCheck(bookingId: Int, sender: UIButton) {
        if sender.currentImage == checkedImage
        {
            sender.setImage(uncheckedImage, for: .normal)
        }else{
            sender.setImage(checkedImage, for: .normal)
            selectedIds.append(String(bookingId))           
        }
    }
}
