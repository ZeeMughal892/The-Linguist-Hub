//
//  SearchBookingDetailsViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 18/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class SearchBookingDetailsViewController: BaseViewController {
    
    public static var bookingItem = AllBookings()
    public static var complaintItem = Compliant()
    @IBOutlet weak var lblDesc: PaddingLabel!
    @IBOutlet weak var lblRef: PaddingLabel!
    @IBOutlet weak var lblDateTime: PaddingLabel!
    @IBOutlet weak var lblClientNotes: PaddingLabel!
    @IBOutlet weak var lblLanguage: PaddingLabel!
    @IBOutlet weak var lblVenuePostcode: PaddingLabel!
    @IBOutlet weak var lblDistance: PaddingLabel!
    @IBOutlet weak var lblBookingType: PaddingLabel!
    @IBOutlet weak var lblActualInterpretingTime: PaddingLabel!
    @IBOutlet weak var lblActualDuration: PaddingLabel!
    @IBOutlet weak var lblCompanyName: PaddingLabel!
    @IBOutlet weak var lblMileagePay: PaddingLabel!
    @IBOutlet weak var lblTravelTimePay: PaddingLabel!
    @IBOutlet weak var lblAdditionalRatePerMin: PaddingLabel!
    @IBOutlet weak var lblEstimatedPayment: PaddingLabel!
    
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var headRef: UILabel!
    @IBOutlet weak var headDateTime: UILabel!
    @IBOutlet weak var headClientNotes: UILabel!
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headVenuePostcode: UILabel!
    @IBOutlet weak var headDistance: UILabel!
    @IBOutlet weak var headBookingType: UILabel!
    @IBOutlet weak var headActualInterpretingTime: UILabel!
    @IBOutlet weak var headActualDuration: UILabel!
    @IBOutlet weak var headCompanyName: UILabel!
    @IBOutlet weak var headMileagePay: UILabel!
    @IBOutlet weak var headTravelTimePay: UILabel!
    @IBOutlet weak var headAdditionalRatePerMin: UILabel!
    @IBOutlet weak var headEstimatedPayment: UILabel!
    
    @IBOutlet weak var viewClientNotes: UIView!
    @IBOutlet weak var viewDistance: UIView!
    @IBOutlet weak var viewBookingType: UIView!
    @IBOutlet weak var viewActualInterpreter: UIView!
    
    public static var bookingCalendar = BookingCalendarModel()
    public static var bookingRequest = BookingRequestModel()
    public static var bookingReminder = BookingRemindersModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButtonToNavigationBar()
        self.title = "Details"
        
        headDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headDateTime.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headClientNotes.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headLanguage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headVenuePostcode.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headDistance.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headBookingType.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headActualInterpretingTime.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headActualDuration.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headCompanyName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headMileagePay.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headTravelTimePay.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headAdditionalRatePerMin.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headEstimatedPayment.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        if SearchBookingDetailsViewController.bookingItem.description != nil{
            lblDesc.text = SearchBookingDetailsViewController.bookingItem.description
            lblRef.text = SearchBookingDetailsViewController.bookingItem.bookingRef
            lblDateTime.text = SearchBookingDetailsViewController.bookingItem.appointmentDateTimeUkFormatted
            lblClientNotes.text = SearchBookingDetailsViewController.bookingItem.clientNotes
            lblLanguage.text = SearchBookingDetailsViewController.bookingItem.bookingLanguage
            lblVenuePostcode.text = SearchBookingDetailsViewController.bookingItem.venuePostCode
            lblDistance.text = String(SearchBookingDetailsViewController.bookingItem.totalMileage) + " Miles"
            lblBookingType.text = SearchBookingDetailsViewController.bookingItem.bookingTypeLabel
            lblActualInterpretingTime.text = String(SearchBookingDetailsViewController.bookingItem.actualInterpreterTime) + " Minutes"
            lblActualDuration.text = String(SearchBookingDetailsViewController.bookingItem.actualDuration) + " Minutes"
            lblCompanyName.text = SearchBookingDetailsViewController.bookingItem.companyName
            lblMileagePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingItem.interpreterMileagePay)
            lblTravelTimePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingItem.interpreterTravelTimePay)
            lblAdditionalRatePerMin.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingItem.additionalRatePer)
            lblEstimatedPayment.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingItem.estimatedIntPayment)
        }
        else if SearchBookingDetailsViewController.bookingCalendar.description != nil {
            lblDesc.text = SearchBookingDetailsViewController.bookingCalendar.description
            lblRef.text = SearchBookingDetailsViewController.bookingCalendar.bookingRef
            lblDateTime.text = SearchBookingDetailsViewController.bookingCalendar.appointmentDateTimeUkFormatted
            lblClientNotes.text = SearchBookingDetailsViewController.bookingCalendar.clientNotes
            lblLanguage.text = SearchBookingDetailsViewController.bookingCalendar.bookingLanguage
            lblVenuePostcode.text = SearchBookingDetailsViewController.bookingCalendar.venuePostCode
            lblDistance.text = String(SearchBookingDetailsViewController.bookingCalendar.totalMileage) + " Miles"
            lblBookingType.text = SearchBookingDetailsViewController.bookingCalendar.bookingTypeLabel
            lblActualInterpretingTime.text = String(SearchBookingDetailsViewController.bookingCalendar.actualInterpreterTime) + " Minutes"
            lblActualDuration.text = String(SearchBookingDetailsViewController.bookingCalendar.actualDuration) + " Minutes"
            lblCompanyName.text = SearchBookingDetailsViewController.bookingCalendar.companyName
            lblMileagePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingCalendar.interpreterMileagePay)
            lblTravelTimePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingCalendar.interpreterTravelTimePay)
            lblAdditionalRatePerMin.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingCalendar.additionalRatePer)
            lblEstimatedPayment.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingCalendar.estimatedIntPayment)
        }
        else if SearchBookingDetailsViewController.bookingReminder.description != nil{
            lblDesc.text = SearchBookingDetailsViewController.bookingReminder.description
            lblRef.text = SearchBookingDetailsViewController.bookingReminder.bookingRef
            lblDateTime.text = SearchBookingDetailsViewController.bookingReminder.appointmentDateTimeUkFormatted
            lblClientNotes.text = SearchBookingDetailsViewController.bookingReminder.clientNotes
            lblLanguage.text = SearchBookingDetailsViewController.bookingReminder.bookingLanguage
            lblVenuePostcode.text = SearchBookingDetailsViewController.bookingReminder.venuePostCode
            lblDistance.text = String(SearchBookingDetailsViewController.bookingReminder.totalMileage) + " Miles"
            lblBookingType.text = SearchBookingDetailsViewController.bookingReminder.bookingTypeLabel
            lblActualInterpretingTime.text = String(SearchBookingDetailsViewController.bookingReminder.actualInterpreterTime) + " Minutes"
            lblActualDuration.text = String(SearchBookingDetailsViewController.bookingReminder.actualDuration) + " Minutes"
            lblCompanyName.text = SearchBookingDetailsViewController.bookingReminder.companyName
            lblMileagePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingReminder.interpreterMileagePay)
            lblTravelTimePay.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingReminder.interpreterTravelTimePay)
            lblAdditionalRatePerMin.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingReminder.additionalRatePer)
            lblEstimatedPayment.text = String(format: "£ %.2f",SearchBookingDetailsViewController.bookingReminder.estimatedIntPayment)
        }
        else if SearchBookingDetailsViewController.bookingRequest.description != nil{
            lblDesc.text = SearchBookingDetailsViewController.bookingRequest.description
            lblRef.text = SearchBookingDetailsViewController.bookingRequest.bookingRef
            lblDateTime.text = SearchBookingDetailsViewController.bookingRequest.appointmentDateTimeUKFormatted
            headClientNotes.text = "Venue Description"
            lblClientNotes.text = SearchBookingDetailsViewController.bookingRequest.venueDescription
            lblLanguage.text = SearchBookingDetailsViewController.bookingRequest.bookingLanguage
            lblVenuePostcode.text = SearchBookingDetailsViewController.bookingRequest.venuePostCode
            headDistance.text = "Service User Gender"
            lblDistance.text = SearchBookingDetailsViewController.bookingRequest.serviceUserGender
            lblBookingType.text = SearchBookingDetailsViewController.bookingRequest.getBookingAddress
            headBookingType.text = "Booking Address"
            lblActualInterpretingTime.text = SearchBookingDetailsViewController.bookingRequest.isHomeVisit
            headActualInterpretingTime.text = "Home Visit"
            lblActualDuration.text = String(SearchBookingDetailsViewController.bookingRequest.actualDuration) + " Minutes"
            lblCompanyName.text = SearchBookingDetailsViewController.bookingRequest.companyName
            
            lblMileagePay.text = String(format: "£ %.2f")
            lblTravelTimePay.text = String(format: "£ %.2f")
            lblAdditionalRatePerMin.text = String(format: "£ %.2f")
            lblEstimatedPayment.text = String(format: "£ %.2f")
        }
        else{}
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        // Do any additional setup after loading the view.
    }
    override func addBackButtonToNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.leftBarButton =  UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionBack))
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    @objc func actionBack(){
        SearchBookingDetailsViewController.bookingRequest = BookingRequestModel.init()
        SearchBookingDetailsViewController.bookingReminder = BookingRemindersModel.init()
        SearchBookingDetailsViewController.bookingCalendar = BookingCalendarModel.init()
        SearchBookingDetailsViewController.bookingItem = AllBookings.init()
        self.navigationController?.popViewController(animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
