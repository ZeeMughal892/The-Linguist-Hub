//
//  DashTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class DashTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var verticalView: UIView! 
    @IBOutlet weak var cardView: CardView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
