//
//  LeftMenuTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 04/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    
  @IBOutlet weak var lblMenuItem: PaddingLabel!
    @IBOutlet weak var imgMenu: UIImageView!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
