//
//  AbsenceTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 18/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class AbsenceTableViewCell: UITableViewCell {

    @IBOutlet weak var headFrom: UILabel!
    @IBOutlet weak var headTo: UILabel!
    @IBOutlet weak var headCanContact: UILabel!
    @IBOutlet weak var headReason: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblCanContact: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
