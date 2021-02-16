//
//  PhoneTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 25/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: PaddingLabel!
    @IBOutlet weak var verticalView: UIView!
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblPhone: PaddingLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
