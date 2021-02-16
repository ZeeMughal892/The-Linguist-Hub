//
//  DBSRowTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 22/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class DBSRowTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: PaddingLabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lblPercentage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
