
import UIKit
import RappleProgressHUD
import Alamofire
import WebKit
import EventKit

class BookingsCalendarViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMessage: PaddingLabel!
    var pdfUrl:URL!
    var webPreview : WKWebView!
    let eventStore :  EKEventStore = EKEventStore()
    public var bookingItem = [BookingCalendarModel]()
   // var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMenuButtonToNavigationBar()
        self.title = "Bookings Calendar"
        loadBookingCalendar()
       
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
       // refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
       // tableView.addSubview(refreshControl)
        
    }
  //  @objc func refresh(_ sender: AnyObject) {
   //     loadBookingCalendar()
   // }
    
    func loadBookingCalendar(){
        RappleActivityIndicatorView.startAnimating()
        let request = BookingCalendarRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.BookingCalendar(method: MethodTypes.Post.rawValue, url: ApiUrls.bookingCalendar, request: request, viewController: self).done { response in
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
    func setupEmptyBackgroundView() {
        let image = UIImage(named: "booking")!.withRenderingMode(.alwaysTemplate)
        let topMessage = "Bookings Calendar"
        let bottomMessage = "You don't have any assigned bookings. All your bookings will show up here."
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.lblMessage.isHidden = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
extension BookingsCalendarViewController:   UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingItem.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let booking = bookingItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingsCalendarTableViewCell") as! BookingsCalendarTableViewCell
        cell.headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.headDistance.textColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.btnCalendar.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        cell.delegate = self
        cell.setDetails(booking: booking)
        cell.selectedBackgroundView = UIView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SearchBookingDetailsViewController") as! SearchBookingDetailsViewController
        SearchBookingDetailsViewController.bookingCalendar = bookingItem[indexPath.row]
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "TheLinguistHub-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(fileName).pdf") {
                        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
                        PDFViewController.pdfUrl = url
                         PDFViewController.check = "0"
                        mainVC.modalPresentationStyle = .fullScreen
                        //self.present(mainVC, animated: true, completion: nil)
                        self.navigationController?.pushViewController(mainVC, animated: true)
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
    }
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("TheLinguistHub-\(fileName).pdf") {
                        status = true
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        return status
    }
    
}
extension BookingsCalendarViewController: BookingsCalendarDelegate{
    func didTapDownloadJobsheet(bookingRef: String) {
       RappleActivityIndicatorView.startAnimating()
        if pdfFileAlreadySaved(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef) == true {
            RappleActivityIndicatorView.startAnimating()
            let download = UIAlertAction(title: "Open Jobsheet", style: .default,handler: {
                (action) in
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
               // mainVC.modalPresentationStyle = .fullScreen
                self.showSavedPdf(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
                //self.present(mainVC, animated: true, completion: nil)
                //self.navigationController?.pushViewController(mainVC, animated: true)
            })
             let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            download.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: "PDF Already Downloaded !", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(download)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
             RappleActivityIndicatorView.stopAnimation()
        }else{
            RappleActivityIndicatorView.startAnimating()
            self.savePdf(urlString: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
            let download = UIAlertAction(title: "Open Jobsheet", style: .default,handler: {
                (action) in
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.showSavedPdf(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
               // self.present(mainVC, animated: true, completion: nil)
              //  self.navigationController?.pushViewController(mainVC, animated: true)
            })
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            download.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: "PDF Download Complete !", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(download)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
             RappleActivityIndicatorView.stopAnimation()
        }
        
    }
    func didTapAddToCalander(bookingObj: BookingCalendarModel) {
        eventStore.requestAccess(to: .event, completion: {(granted,error) in
            if granted && error == nil {
                let event:EKEvent = EKEvent(eventStore: self.eventStore)
                event.title = bookingObj.description
                event.notes = "Booking Reference : \(bookingObj.bookingRef!) \nBooking Language : \(bookingObj.bookingLanguage!) \nBooking Duration : \(bookingObj.bookingDuration!) Minutes \nVenue Postcode : \(bookingObj.venuePostCode!) \nCompany Name : \(bookingObj.companyName!)"
                event.isAllDay = false
                event.startDate = self.convertToDate(dateString:bookingObj.appointmentDateTimeUkFormatted!)
                event.endDate = event.startDate.addingTimeInterval(3600 as TimeInterval)
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                do{
                    let reminder = EKAlarm(relativeOffset: -7200)
                    event.addAlarm(reminder)
                    try self.eventStore.save(event, span: .thisEvent)
                    DispatchQueue.main.async {
                        Modals.CreateAlert(title: "Language Empire", message: "Event has been added on \(bookingObj.appointmentDateUKFormatted!)", ViewController: self)
                    }
                }catch let error as NSError{
                    print("error : \(error)")
                }
            }else{
                return
            }
        })
        let reminder: EKReminder = EKReminder(eventStore: eventStore)
        reminder.calendar = eventStore.defaultCalendarForNewReminders()
        let location: EKStructuredLocation = EKStructuredLocation(title: "Current Location")
        let alarm : EKAlarm = EKAlarm(relativeOffset: -7200)
        alarm.structuredLocation = location
        alarm.proximity = EKAlarmProximity.leave
        reminder.addAlarm(alarm)
        do{
            try eventStore.save(reminder, commit: true)
        }catch let error as NSError{
            print("error : \(error)")
        }
    }
    func convertToDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    func didTapMap(bookingItem: BookingCalendarModel) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"LocationViewController") as! LocationViewController
//        LocationViewController.lat = bookingItem.venueLat
//        LocationViewController.lng = bookingItem.venueLong
//        LocationViewController.address = bookingItem.description + " " + bookingItem.region + " " + bookingItem.venuePostCode
        mainVC.modalPresentationStyle = .fullScreen
       // self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}

