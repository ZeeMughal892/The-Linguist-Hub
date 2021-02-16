

import UIKit
import SWRevealViewController

class BookingDetailsViewController: BaseViewController {
    @IBOutlet weak var s1: UIImageView!
    @IBOutlet weak var s2: UIImageView!
    @IBOutlet weak var s3: UIImageView!
    @IBOutlet weak var s4: UIImageView!
    @IBOutlet weak var s5: UIImageView!
    @IBOutlet weak var s6: UIImageView!
    @IBOutlet weak var s7: UIImageView!
    @IBOutlet weak var s8: UIImageView!
    
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var imgDesc: UIImageView!
    @IBOutlet weak var imgPay: UIImageView!
    @IBOutlet weak var headTravel: UILabel!
    @IBOutlet weak var headPay: UILabel!
    public static var bookingId:String!
    @IBOutlet weak var imgTravel: UIImageView!
    @IBOutlet weak var imgInter: UIImageView!
    @IBOutlet weak var headInterpret: UILabel!
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblDateTimeDay: PaddingLabel!
    @IBOutlet weak var lblLanguage: PaddingLabel!
    @IBOutlet weak var lblDuration: PaddingLabel!
    @IBOutlet weak var lblLocation: PaddingLabel!
    @IBOutlet weak var lblFirstHourRate: PaddingLabel!
    @IBOutlet weak var lblAdditionalTimeRPM: PaddingLabel!
    @IBOutlet weak var lblMileageRate: PaddingLabel!
    @IBOutlet weak var lblMileagePayable: PaddingLabel!
    @IBOutlet weak var lblTravelTimeApplicable: PaddingLabel!
    @IBOutlet weak var lblTravelTimeMin: PaddingLabel!
    @IBOutlet weak var lblTravelTimeCap: PaddingLabel!
    @IBOutlet weak var lblPublicTransport: PaddingLabel!
    @IBOutlet weak var lblParking: PaddingLabel!
    @IBOutlet weak var lblCongestionToll: PaddingLabel!
    @IBOutlet weak var lblTotalEstimatedPayment: PaddingLabel!
    public static var bookingItem = BookingModel()
    
    @IBOutlet weak var lblMessage: UILabel!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButtonToNavigationBar()
        self.title = "Booking Details"
        s1.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s2.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s3.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s4.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s5.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s6.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s7.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        s8.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        
        headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headInterpret.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headTravel.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPay.textColor = UIColor.init(named: LoginUser.getThemeColor)
        imgDesc.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        imgInter.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        imgTravel.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        imgPay.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        
        lblDescription.text = BookingDetailsViewController.bookingItem.description
        lblDateTimeDay.text = BookingDetailsViewController.bookingItem.appointmentDateUKFormatted + " " +
            BookingDetailsViewController.bookingItem.appointmentTimeUKFormatted + " " +
            BookingDetailsViewController.bookingItem.appointmentWeekDay
        lblLanguage.text = BookingDetailsViewController.bookingItem.bookingLanguage
        lblDuration.text = String(BookingDetailsViewController.bookingItem.bookingDuration!) + " Minutes"
        lblLocation.text = BookingDetailsViewController.bookingItem.venuePostCodeFull
        lblFirstHourRate.text = String(format: "£ %.2f", BookingDetailsViewController.bookingItem.mainCharges!)
        lblAdditionalTimeRPM.text = String(format: "£ %.2f", BookingDetailsViewController.bookingItem.additionalRate!)
        lblMileageRate.text = String(format: "£ %.2f", BookingDetailsViewController.bookingItem.mileage!)
        if(!(BookingDetailsViewController.bookingItem.mileageApplicableAfter == nil)){
            lblMileagePayable.text = String(BookingDetailsViewController.bookingItem.mileageApplicableAfter!) + " Miles"
        }
        if(!(BookingDetailsViewController.bookingItem.travelTimeApplicableAfter == nil)){
            lblTravelTimeMin.text = String(BookingDetailsViewController.bookingItem.travelTimeApplicableAfter!) + " Minutes"
        }
        //lblMileagePayable.text = String(BookingDetailsViewController.bookingItem.mileageApplicableAfter!) + " Miles"
//        lblTravelTimeMin.text = String(BookingDetailsViewController.bookingItem.travelTimeApplicableAfter!) + " Minutes"
        
        if BookingDetailsViewController.bookingItem.addiTravelTime == 0{
            lblTravelTimeApplicable.text = "No"
        }else{
            lblTravelTimeApplicable.text = "Yes"
        }
        if BookingDetailsViewController.bookingItem.addiCongestion == 0{
            lblCongestionToll.text = "No"
        }else{
            lblCongestionToll.text = "Yes"
        }
        if BookingDetailsViewController.bookingItem.addiPublicTransport == 0{
            lblPublicTransport.text = "No"
        }else{
            lblPublicTransport.text = "Yes"
        }
        if BookingDetailsViewController.bookingItem.addiOther == 0{
            lblParking.text = "No"
        }else{
            lblParking.text = "Yes"
        }
        if BookingDetailsViewController.bookingItem.travelTimeCap == "0"{
            lblTravelTimeCap.text = "N/A"
        }else{
            lblTravelTimeCap.text = BookingDetailsViewController.bookingItem.travelTimeCap
        }
        lblTotalEstimatedPayment.text = String(format: "£ %.2f", BookingDetailsViewController.bookingItem.totalEstimatedPay!)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
              navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
//    @IBAction func actionBack(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func actionView(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"LocationViewController") as! LocationViewController
        LocationViewController.lat = BookingDetailsViewController.bookingItem.venueLat
        LocationViewController.lng = BookingDetailsViewController.bookingItem.venueLong
        LocationViewController.address = BookingDetailsViewController.bookingItem.venueAddressLine1 + " " + BookingDetailsViewController.bookingItem.region + " " + BookingDetailsViewController.bookingItem.venuePostCode
        mainVC.modalPresentationStyle = .fullScreen
       // self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}

