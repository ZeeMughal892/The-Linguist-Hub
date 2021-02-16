//
//  PCATableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
protocol PCADelegate {
    func didTapBtnCheck(PCAName: String,PCAIsChecked: Bool)
}
class PCATableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPCA: PaddingLabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var PCAItem : PCAs!
    var delegate: PCADelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }   
    func setDetails(pca: PCAs){
        PCAItem = pca
        lblPCA.text = PCAItem.Name
        if PCAItem.IsChecked == true{
            btnCheck.setImage(checkedImage, for: .normal)
        }else{
            btnCheck.setImage(uncheckedImage, for: .normal)
        }        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func actionCheck(_ sender: Any) {
        delegate?.didTapBtnCheck(PCAName: PCAItem.Name, PCAIsChecked: PCAItem.IsChecked)
    }
    
}
