//
//  TotalHoursTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class TotalHoursTableViewCell: UITableViewCell {
    
     @IBOutlet weak var lblDesc: UILabel!
        @IBOutlet weak var lblBookingRef: UILabel!
        @IBOutlet weak var lblDate: UILabel!
        @IBOutlet weak var lblStatus: UILabel!
        
        @IBOutlet weak var imgRight: UIImageView!
           
        
       var bookingItem : AllBookings!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        func setDetails(booking: AllBookings){
            bookingItem = booking
            lblDesc.text = booking.description
            lblBookingRef.text = booking.bookingRef
            lblDate.text = booking.appointmentDateTimeUkFormatted
            lblStatus.text = String(booking.actualInterpreterTime) + " Minutes"
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
