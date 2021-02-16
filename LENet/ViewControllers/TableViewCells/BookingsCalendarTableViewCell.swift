//
//  BookingsCalendarTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 17/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
protocol BookingsCalendarDelegate {
    func didTapDownloadJobsheet(bookingRef: String)
    func didTapAddToCalander(bookingObj: BookingCalendarModel)
    func didTapMap(bookingItem: BookingCalendarModel)
}
class BookingsCalendarTableViewCell: UITableViewCell {
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var headRef: UILabel!
    @IBOutlet weak var headDistance: UILabel!
    @IBOutlet weak var btnView: UIButton!
    
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDateTimeDay: UILabel!
    @IBOutlet weak var lblReference: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblEstimatedDistance: UILabel!
    @IBOutlet weak var btnDownloadJobSheet: UIButton!
    @IBOutlet weak var btnAddToCalendar: UIButton!
    
    @IBOutlet weak var btnCalendar: UIButton!
    
    var bookingItem : BookingCalendarModel!
    var delegate: BookingsCalendarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setDetails(booking: BookingCalendarModel){
        bookingItem = booking
        lblDescription.text = " " + booking.description
        lblLanguage.text = " " + booking.bookingLanguage
        lblDuration.text = " " + String(booking.bookingDuration!) + " Minutes"
        lblDateTimeDay.text = " " + booking.appointmentDateUKFormatted
        lblReference.text = " " +  booking.bookingRef
        lblDateTimeDay.text =  "Appointment Date : " + String(booking.appointmentDateTimeUkFormatted!)
        if booking.venuePostCode == ""{
            lblEstimatedDistance.text = " " + "NA"
        }else{
            lblEstimatedDistance.text = " " + booking.venuePostCode
        }
    }
    
    @IBAction func actionDownloadJobsheet(_ sender: Any) {
        delegate?.didTapDownloadJobsheet(bookingRef: bookingItem.bookingRef!)
    }
    @IBAction func actionAddToCalander(_ sender: Any) {
        delegate?.didTapAddToCalander(bookingObj: bookingItem)
    }
    @IBAction func actionMapClick(_ sender: Any) {
          delegate?.didTapMap(bookingItem: bookingItem)
    }
    
    
}
