//
//  AllBookingsTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 30/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit


class AllBookingsTableViewCell: UITableViewCell {

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
        
        if booking.getStatus == "Canceled"{
            lblStatus.textColor = UIColor.init(named: "colorRedLogo")
            lblStatus.text = "Cancelled"
        }else if booking.getStatus == "Active"{
            lblStatus.textColor = UIColor.init(named: "colorGreen")
            lblStatus.text = "Completed"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
