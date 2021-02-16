//
//  BookingRequestsTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

protocol BookingsRequestDelegate {
    func didTapMap(bookingItem: BookingRequestModel)
    func didTapCheck(bookingId: Int, sender: UIButton)
}

class BookingRequestsTableViewCell: UITableViewCell {
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headLocation: UILabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var headRef: UILabel!
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDateTimeDay: UILabel!
    @IBOutlet weak var lblReference: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPostcode: UILabel!
    
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    
    var bookingItem : BookingRequestModel!
    var delegate: BookingsRequestDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDetails(booking: BookingRequestModel){
        bookingItem = booking
      
        lblDescription.text = " " + booking.description
        lblDateTimeDay.text =  "Appointment Date : \(booking.appointmentDateUKFormatted!) \(booking.appointmentTimeUKFormatted!)"  
        lblReference.text = " " + booking.bookingRef
        lblLanguage.text = " " + booking.bookingLanguage
        lblDuration.text = " " + String(booking.bookingDuration!) + " Minutes"
        lblPostcode.text = " " + booking.postCodeArea        
       }
       
    @IBAction func actionCheck(_ sender: Any) {
        delegate?.didTapCheck(bookingId: bookingItem.bookingId, sender: btnCheck)
    }
    @IBAction func actionMapClick(_ sender: Any) {
        delegate?.didTapMap(bookingItem: bookingItem)
    }
}
