//
//  ComplaintDetailsViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class ComplaintDetailsViewController: BaseViewController {

    public static var complaintItem = Compliant()
    
    @IBOutlet weak var lblComplainantName: PaddingLabel!
    @IBOutlet weak var lblBookingRef: PaddingLabel!
    @IBOutlet weak var lblComplaintDate: PaddingLabel!
    @IBOutlet weak var lblComplaintDetails: PaddingLabel!
    @IBOutlet weak var lblApologiseBy: PaddingLabel!
    @IBOutlet weak var lblApologiseDate: PaddingLabel!
    @IBOutlet weak var lblResponsePerson: PaddingLabel!
    @IBOutlet weak var lblResponseDate: PaddingLabel!
    @IBOutlet weak var lblComplaintBreach: PaddingLabel!
    @IBOutlet weak var lblResponseDetails: PaddingLabel!
    
    @IBOutlet weak var headComplainantName: UILabel!
    @IBOutlet weak var headBookingRef: UILabel!
    @IBOutlet weak var headComplaintDate: UILabel!
    @IBOutlet weak var headComplaintDetails: UILabel!
    @IBOutlet weak var headApologiseBy: UILabel!
    @IBOutlet weak var headApologiseDate: UILabel!
    @IBOutlet weak var headResponsePerson: UILabel!
    @IBOutlet weak var headResponseDate: UILabel!
    @IBOutlet weak var headComplaintBreach: UILabel!
    @IBOutlet weak var headResponseDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Complaint Details"
        self.addBackButtonToNavigationBar()
        headComplainantName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headBookingRef.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headComplaintDate.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headComplaintDetails.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headApologiseBy.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headApologiseDate.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headResponsePerson.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headResponseDate.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headComplaintBreach.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headResponseDetails.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        
        lblComplainantName.text = ComplaintDetailsViewController.complaintItem.complaintMadeBy
        lblBookingRef.text = ComplaintDetailsViewController.complaintItem.bookingRef
        lblComplaintDate.text = ComplaintDetailsViewController.complaintItem.complaintDateToUKFormate
        lblComplaintDetails.text = ComplaintDetailsViewController.complaintItem.natureOfComplaintDetails
        lblApologiseBy.text = ComplaintDetailsViewController.complaintItem.apologiseBy
        lblApologiseDate.text = ComplaintDetailsViewController.complaintItem.apologiseDateToUKFormate
        lblResponsePerson.text = ComplaintDetailsViewController.complaintItem.responseUpdatedBy
        lblResponseDate.text = ComplaintDetailsViewController.complaintItem.responseUpdatedDateToUKFormate
        lblComplaintBreach.text = ComplaintDetailsViewController.complaintItem.identifyComplaintBreach
        lblResponseDetails.text = ComplaintDetailsViewController.complaintItem.responseDetails
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
  
}
