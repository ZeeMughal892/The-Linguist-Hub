//
//  SocialLinksTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 25/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class SocialLinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!    
    @IBOutlet weak var btnLinkedin: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func actionFacebook(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/LanguageEmpireLtd/")!)
    }
    @IBAction func actionTwitter(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/LanguageEmpire")!)
    }
    @IBAction func actionLinkedin(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.linkedin.com/company/language-empire/")!)
    }
}
