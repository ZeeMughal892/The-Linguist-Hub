//
//  RemindersCancelledTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class RemindersCancelledTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCancelled: UILabel!
    @IBOutlet weak var lblDuration: PaddingLabel!
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblLanguage: PaddingLabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblReference: PaddingLabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headReference: UILabel!
    @IBOutlet weak var headDescription: UILabel!
     var bookingItem : BookingRemindersModel!
       var delegate: BookingRemindersDelegate?
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
       func setDetails(booking: BookingRemindersModel){
           bookingItem = booking
           lblDescription.text = " " + booking.description
           lblReference.text = " " + booking.bookingRef
           lblLanguage.text = " " + booking.bookingLanguage
           lblDuration.text = " " + String(booking.bookingDuration) + " Minutes"
           lblDateTime.text = "Appointment Date : " + booking.appointmentDateUKFormatted + " " + booking.appointmentTimeUKFormatted           
       }
         
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
