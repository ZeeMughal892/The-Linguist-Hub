//
//  AlertsTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class AlertsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: PaddingLabel!
    @IBOutlet weak var lblTime: PaddingLabel!
    @IBOutlet weak var imgAlert: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
