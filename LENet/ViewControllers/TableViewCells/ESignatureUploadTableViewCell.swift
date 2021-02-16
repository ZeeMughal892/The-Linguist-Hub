//
//  ESignatureUploadTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 25/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
protocol ESignatureUploadDelegate {
    func didTapUpload(bookingItem: UploadJobsheetModel)
}
class ESignatureUploadTableViewCell: UITableViewCell {
    @IBOutlet weak var headDesc: UILabel!
  
    
    @IBOutlet weak var lblIncomplete: UILabel!
    @IBOutlet weak var lblView: UIStackView!
    @IBOutlet weak var headDate: UILabel!
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headRef: UILabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblReference: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var btnUploadSignature: UIButton!
    
    var bookingItem : UploadJobsheetModel!
    var delegate: ESignatureUploadDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setDetails(booking: UploadJobsheetModel){
        bookingItem = booking
        lblDescription.text = " " + booking.description
        lblDate.text =  " " + booking.appointmentDateUKFormatted! + " " + booking.appointmentTimeUKFormatted!
        lblReference.text = " " + booking.bookingRef
        lblLanguage.text = " " + booking.bookingLanguage
        lblDuration.text = " " + String(booking.bookingDuration!) + " Minutes"
       
    }
    
    @IBAction func actionUploadClick(_ sender: Any) {
        delegate?.didTapUpload(bookingItem: bookingItem)
    }
}
