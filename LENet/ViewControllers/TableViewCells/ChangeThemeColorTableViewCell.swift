//
//  ChangeThemeColorTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

protocol ChangeThemeColorDelegate {
    func didTapButton(colorCode: String)
}


class ChangeThemeColorTableViewCell: UITableViewCell {

    @IBOutlet weak var btnColor: UIButton!
   
    var delegate: ChangeThemeColorDelegate?
    var colorCode: String!
    var colorName : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setColor(Name: String, Code: String){
        colorCode = Code
        colorName = Name
        btnColor.setTitle(colorName, for: .normal)
        btnColor.backgroundColor = UIColor.init(named: colorCode)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func actionBtnColor(_ sender: Any) {
        delegate?.didTapButton(colorCode: colorCode)
    }
    
}
