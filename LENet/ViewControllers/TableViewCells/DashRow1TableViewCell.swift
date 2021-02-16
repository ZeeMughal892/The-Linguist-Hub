//
//  DashRow1TableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import KDCircularProgress
import SwiftProgressView

class DashRow1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardViewLeft: CardView!
    @IBOutlet weak var cardViewRight: CardView!
    @IBOutlet weak var circleLeft: ProgressRingView!
    @IBOutlet weak var lblLeft: PaddingLabel!
    @IBOutlet weak var lblLeftValue: UILabel!
    @IBOutlet weak var circleRight: ProgressRingView!
    @IBOutlet weak var lblRight: PaddingLabel!
    @IBOutlet weak var lblRightValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
