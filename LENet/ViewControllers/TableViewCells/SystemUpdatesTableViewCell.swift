//
//  SystemUpdatesTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class SystemUpdatesTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblDateImplemented: UILabel!
    @IBOutlet weak var lblIssueDetails: UILabel!
    
    @IBOutlet weak var lblDetailsOfChanges: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
