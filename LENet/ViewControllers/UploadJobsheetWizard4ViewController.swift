//
//  UploadJobsheetWizard4ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD
import MobileCoreServices

class UploadJobsheetWizard4ViewController: BaseViewController,UITextFieldDelegate  {
    
    @IBOutlet weak var head3: UILabel!
    @IBOutlet weak var head4: UILabel!
    @IBOutlet weak var head2: UILabel!
    @IBOutlet weak var head1: UILabel!
    @IBOutlet weak var txtTraveTimeOver: customUITextField!
    @IBOutlet weak var txtMileageOver: customUITextField!
    @IBOutlet weak var txtPublicTransport: customUITextField!
    @IBOutlet weak var txtOtherExpenses: customUITextField!
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Travel Time Info"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()

        self.HideKeyboard()
        
        txtPublicTransport.delegate = self
        txtOtherExpenses.delegate = self
        txtMileageOver.delegate = self
        txtTraveTimeOver.delegate = self        
        
        
        head1.textColor = UIColor.init(named: LoginUser.getThemeColor)
        head2.textColor = UIColor.init(named: LoginUser.getThemeColor)
        head3.textColor = UIColor.init(named: LoginUser.getThemeColor)
        head4.textColor = UIColor.init(named: LoginUser.getThemeColor)
       
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
               navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]      
    }
     @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height
               }
           }
       }
       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionNext))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext()  {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard7ViewController") as! UploadJobsheetWizard7ViewController
        JobsheetInfoRequestModel.TravelTime = txtTraveTimeOver.text!
        JobsheetInfoRequestModel.Mileage = txtMileageOver.text!
        JobsheetInfoRequestModel.PublicTransportCost = txtPublicTransport.text!
        JobsheetInfoRequestModel.OtherExpenses = txtOtherExpenses.text!
        mainVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(mainVC, animated: true)
    
}
}
