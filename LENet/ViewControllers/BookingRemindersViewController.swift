

import UIKit
import RappleProgressHUD
import Alamofire
import EventKit
import WebKit
import SWRevealViewController

class BookingRemindersViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
 
    public static var bookingItems = [BookingRemindersModel]()
    
    var destinationURLForFile:URL!
    var webPreview : WKWebView!
    let eventStore :  EKEventStore = EKEventStore()
    
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var selectedIds = [String]()
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Reminders"
        self.addMenuButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
      /*
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        dismiss.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Important Notice!", message: LoginUser.getPenaltyText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)*/
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    override func addBackButtonToNavigationBar() {
        self.leftBarButton = UIBarButtonItem(title: "Later", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionLater))
        self.leftBarButton?.tintColor = UIColor.systemRed
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    @objc func actionLater()  {
        RappleActivityIndicatorView.startAnimating()
        let request = UpdateRemindersRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.LaterReminders(method: MethodTypes.Post.rawValue, url: ApiUrls.laterReminders, request: request, viewController: self).done { response in
            if response.d.Status != false {
                /*
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
                SearchBookingDetailsViewController.bookingReminder.description = nil
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC,animated:true,completion:nil)
 */
                let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.view.window?.rootViewController = sw

                let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                SearchBookingDetailsViewController.bookingReminder.description = nil
                sw.pushFrontViewController(newFrontViewController, animated: true)
                RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
        }
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Confirm", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionConfirm))

        self.rightBarButton?.tintColor = UIColor.systemGreen
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionConfirm()  {
        RappleActivityIndicatorView.startAnimating()
       let unique = Array(Set(selectedIds))
       let request = UpdateRemindersRequest()
       request.idCardNo = LoginUser.getIdCardNo
       request.bookingCSV = unique.joined(separator: ",")
       ApiManager.api.UpdateReminders(method: MethodTypes.Post.rawValue, url: ApiUrls.updateReminders, request: request, viewController: self).done { response in
           if response.d.Status != false {
               /*
               let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
               SearchBookingDetailsViewController.bookingReminder.description = nil
               mainVC.modalPresentationStyle = .fullScreen
               self.present(mainVC,animated:true,completion:nil)
*/
               let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
               self.view.window?.rootViewController = sw

               let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
               let newFrontViewController = UINavigationController.init(rootViewController:desController)
               SearchBookingDetailsViewController.bookingReminder.description = nil
               sw.pushFrontViewController(newFrontViewController, animated: true)
               
               RappleActivityIndicatorView.stopAnimation()
           }
       }.catch
           {
               error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
       }
   }
    
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
    }
//    }
//    @IBAction func actionLater(_ sender: Any) {
//        RappleActivityIndicatorView.startAnimating()
//        let request = UpdateRemindersRequest()
//        request.idCardNo = LoginUser.getIdCardNo
//        ApiManager.api.LaterReminders(method: MethodTypes.Post.rawValue, url: ApiUrls.laterReminders, request: request, viewController: self).done { response in
//            if response.d.Status != false {
//                /*
//                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
//                SearchBookingDetailsViewController.bookingReminder.description = nil
//                mainVC.modalPresentationStyle = .fullScreen
//                self.present(mainVC,animated:true,completion:nil)
// */
//                let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//                self.view.window?.rootViewController = sw
//
//                let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//                let newFrontViewController = UINavigationController.init(rootViewController:desController)
//                SearchBookingDetailsViewController.bookingReminder.description = nil
//                sw.pushFrontViewController(newFrontViewController, animated: true)
//                RappleActivityIndicatorView.stopAnimation()
//            }
//        }.catch
//            {
//                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingRemindersViewController.bookingItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if BookingRemindersViewController.bookingItems[indexPath.row].getStatus != "Active" {
            let booking = BookingRemindersViewController.bookingItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemindersCancelledTableViewCell", for: indexPath) as! RemindersCancelledTableViewCell
            cell.headDescription.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headReference.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headLanguage.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headDuration.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.delegate = self
            cell.setDetails(booking: booking)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
            return cell
        }else{
            let booking = BookingRemindersViewController.bookingItems[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingRemindersTableViewCell", for: indexPath) as! BookingRemindersTableViewCell
            cell.headDesc.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headReference.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headLanguage.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headPostcode.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.headDuration.textColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.btnCalendar.backgroundColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.btnCheck.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
            cell.delegate = self
            cell.setDetails(booking: booking)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SearchBookingDetailsViewController") as! SearchBookingDetailsViewController
        SearchBookingDetailsViewController.bookingReminder = BookingRemindersViewController.bookingItems[indexPath.row]
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
                        self.navigationController?.pushViewController(mainVC, animated: true)
//                        self.present(mainVC, animated: true, completion: nil)
                        
                    }
                }
            } catch {
                print("could not locate jobsheet file !!!!!!!")
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

extension BookingRemindersViewController: BookingRemindersDelegate{
    
    func didTapMap(bookingItem: BookingRemindersModel) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"LocationViewController") as! LocationViewController
        LocationViewController.lat = bookingItem.venueLat
        LocationViewController.lng = bookingItem.venueLong
        LocationViewController.address = bookingItem.description + " " + bookingItem.region + " " + bookingItem.venuePostCode
        mainVC.modalPresentationStyle = .fullScreen
       // self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func didTapDownloadJobsheet(bookingRef: String) {
        RappleActivityIndicatorView.startAnimating()
        if pdfFileAlreadySaved(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef) == true {
            RappleActivityIndicatorView.startAnimating()
            let download = UIAlertAction(title: "Open Jobsheet", style: .default,handler: {
                (action) in
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.showSavedPdf(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
//                self.present(mainVC, animated: true, completion: nil)
               // self.navigationController?.pushViewController(mainVC, animated: true)
            })
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            download.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: "Jobsheet Already Downloaded !", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(download)
            alert.addAction(dismiss)
            RappleActivityIndicatorView.stopAnimation()
            self.present(alert, animated: true, completion: nil)
        }else{
             RappleActivityIndicatorView.startAnimating()
            self.savePdf(urlString: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
            let download = UIAlertAction(title: "Open Jobsheet", style: .default,handler: {
                (action) in
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
                mainVC.modalPresentationStyle = .fullScreen
                self.showSavedPdf(url: "https://secure.language-empire.net/v2sp/booking/downloadjobsheet.aspx?bookingref=\(bookingRef)&idcardno=\(LoginUser.getIdCardNo)&secret=LenetMobileApps", fileName: bookingRef)
               // self.present(mainVC, animated: true, completion: nil)
               // self.navigationController?.pushViewController(mainVC, animated: true)
            })
             let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            download.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: "Jobsheet Download Complete !", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(download)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
             RappleActivityIndicatorView.stopAnimation()
        }
        
    }
    
    func didTapAddToCalander(bookingObj: BookingRemindersModel) {
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
    
    func didTapCheck(bookingId: Int, sender: UIButton) {
        if sender.currentImage == checkedImage
        {
            sender.setImage(uncheckedImage, for: .normal)
        }else{
            sender.setImage(checkedImage, for: .normal)
            selectedIds.append(String(bookingId))
            print(bookingId)
        }
    }
    func convertToDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
}
extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
