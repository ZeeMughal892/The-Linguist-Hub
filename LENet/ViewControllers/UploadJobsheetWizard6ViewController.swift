//
//  UploadJobsheetWizard6ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 23/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class UploadJobsheetWizard6ViewController: BaseViewController {

    @IBOutlet weak var headParking: UILabel!
    @IBOutlet weak var txtParking: customUITextField!
    @IBOutlet weak var headTyneTunnel: UILabel!
    @IBOutlet weak var txtTunnel: customUITextField!
    @IBOutlet weak var headPublicTransport: UILabel!
    @IBOutlet weak var txtPublicTransport: customUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Other Expenses"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()

        
        headParking.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headTyneTunnel.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPublicTransport.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
       
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionNext))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext()  {
        if(txtParking.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Parking Charges" , ViewController: self)
            self.txtParking.becomeFirstResponder()
        }else if(txtTunnel.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Tyne Tunnel Charges" , ViewController: self)
            self.txtTunnel.becomeFirstResponder()
        }else if(txtPublicTransport.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Public Transport Expenses" , ViewController: self)
            self.txtPublicTransport.becomeFirstResponder()
        }else{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard7ViewController") as! UploadJobsheetWizard7ViewController
            JobsheetInfoRequestModel.TyneTunnel = txtTunnel.text!
            JobsheetInfoRequestModel.PublicTransportCost = txtPublicTransport.text!
            JobsheetInfoRequestModel.OtherExpenses = txtParking.text!
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}
