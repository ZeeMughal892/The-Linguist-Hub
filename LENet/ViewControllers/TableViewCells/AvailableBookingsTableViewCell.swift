//
//  AvailableBookingsTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 11/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD

protocol AvailableBookingDelegate {
    func didTapInterested(bookingId: Int)
    func didTapDecline(bookingId: Int)
    func didTapDetails(bookingItem: BookingModel)
}

class AvailableBookingsTableViewCell: UITableViewCell {
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headGender: UILabel!
    @IBOutlet weak var headPostcode: UILabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var headReq: UILabel!
    
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblDateTimeDay: UILabel!
    @IBOutlet weak var lblLanguage: PaddingLabel!
    @IBOutlet weak var lblGender: PaddingLabel!
    @IBOutlet weak var lblPostcode: PaddingLabel!
    @IBOutlet weak var lblDuration: PaddingLabel!
    @IBOutlet weak var lblRequestedGender: PaddingLabel!
        
    @IBOutlet weak var btnInterested: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    
    var bookingItem : BookingModel!
    var delegate: AvailableBookingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setDetails(booking: BookingModel){
        bookingItem = booking
        lblDescription.text = " " + booking.description
        lblLanguage.text = " " + booking.bookingLanguage
        lblDuration.text = " " + String(booking.bookingDuration) + " Minutes"
        lblGender.text = " " + booking.serviceUserGender
        lblRequestedGender.text = booking.intGender
        lblDateTimeDay.text = "Appointment Date : " + booking.appointmentDateUKFormatted + " " + booking.appointmentTimeUKFormatted + " " + booking.appointmentWeekDay
        lblPostcode.text = " " + booking.postCodeArea
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func actionInterested(_ sender: Any) {
        delegate?.didTapInterested(bookingId: bookingItem.bookingId)
    }
    @IBAction func actionDecline(_ sender: Any) {
        delegate?.didTapDecline(bookingId: bookingItem.bookingId)
    }
    @IBAction func actionDetails(_ sender: Any) {
        delegate?.didTapDetails(bookingItem: bookingItem)
    }
    
}
