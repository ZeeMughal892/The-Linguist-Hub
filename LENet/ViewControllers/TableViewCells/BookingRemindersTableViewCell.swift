//
//  RemindersTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
protocol BookingRemindersDelegate {
    func didTapCheck(bookingId: Int, sender: UIButton)
    func didTapDownloadJobsheet(bookingRef: String)
    func didTapAddToCalander(bookingObj: BookingRemindersModel)
     func didTapMap(bookingItem: BookingRemindersModel)
}

class BookingRemindersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblDateTimeDay: UILabel!
    @IBOutlet weak var lblLanguage: PaddingLabel!
    @IBOutlet weak var lblPostcode: PaddingLabel!
    @IBOutlet weak var lblDuration: PaddingLabel!
    @IBOutlet weak var lblReference: PaddingLabel!
    @IBOutlet weak var headReference: UILabel!
    @IBOutlet weak var headDesc: UILabel!
    @IBOutlet weak var headPostcode: UILabel!
    @IBOutlet weak var headLanguage: UILabel!
    @IBOutlet weak var headDuration: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var btnCalendar: UIButton!
    var bookingItem : BookingRemindersModel!
    var delegate: BookingRemindersDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setDetails(booking: BookingRemindersModel){
        bookingItem = booking
        lblDescription.text = " " + booking.description
        lblReference.text = " " + booking.bookingRef
        lblLanguage.text = " " + booking.bookingLanguage
        lblDuration.text = " " + String(booking.bookingDuration) + " Minutes"
        lblDateTimeDay.text = "Appointment Date : " + booking.appointmentDateUKFormatted + " " + booking.appointmentTimeUKFormatted
        lblPostcode.text = " " + booking.postCodeArea
    }
      
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
      }
      @IBAction func actionCheck(_ sender: Any) {
          delegate?.didTapCheck(bookingId: bookingItem.bookingId, sender: btnCheck)
      }
        @IBAction func actionDownloadJobsheet(_ sender: Any) {
          delegate?.didTapDownloadJobsheet(bookingRef: bookingItem.bookingRef!)
      }
      @IBAction func actionAddToCalander(_ sender: Any) {
          delegate?.didTapAddToCalander(bookingObj: bookingItem)
      }
    @IBAction func actionMapClick(_ sender: Any) {
         delegate?.didTapMap(bookingItem: bookingItem)
    }
}
