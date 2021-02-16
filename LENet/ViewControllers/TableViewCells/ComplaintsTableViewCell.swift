//
//  ComplaintsTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class ComplaintsTableViewCell: UITableViewCell {

    @IBOutlet weak var headComplaintName: UILabel!
    @IBOutlet weak var lblCompliantName: UILabel!
    @IBOutlet weak var headRef: UILabel!
    @IBOutlet weak var lblBookingRef: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    var complaintItem : Compliant!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        func setDetails(complaint: Compliant){
            complaintItem = complaint
            lblCompliantName.text = complaint.complaintMadeBy
            lblBookingRef.text = complaint.bookingRef
            lblDate.text = complaint.complaintDateToUKFormate
            imgRight.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            headRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
            headComplaintName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
