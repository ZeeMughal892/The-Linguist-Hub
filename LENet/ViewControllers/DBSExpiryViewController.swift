//
//  DBSExpiryViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class DBSExpiryViewController: BaseViewController {
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    public static var DBSValue :String!
    public static var headTitle :String!
    @IBOutlet weak var lblValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        head.textColor = UIColor.init(named: LoginUser.getThemeColor)
        self.addBackButtonToNavigationBar()
        self.title = "DBS Expiry"
        head.text = "Your DBS Will Expire In"
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        self.title = DBSExpiryViewController.headTitle
        if DBSExpiryViewController.DBSValue == "NA" {
            lblMessage.isHidden = true
            lblValue.text = "Sorry, we don't have your DBS Details. Please contact our admin at\n updates@empire-groupuk.com"
        }else if DBSExpiryViewController.DBSValue == "Expired"{
            lblMessage.isHidden = true
            lblValue.text = "Sorry, Your DBS has been Expired. Please contact our admin at\n updates@empire-groupuk.com"
        }else{
            lblValue.text = DBSExpiryViewController.DBSValue
        }
    }
   
}
