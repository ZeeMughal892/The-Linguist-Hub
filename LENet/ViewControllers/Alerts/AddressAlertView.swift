//
//  AddressAlertView.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import UIKit

class AddressAlertView : UIView{
    
    static let instance = AddressAlertView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alertView: CardView!
  
    var selectedOption: String?
   
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtAddress3: UITextField!
    @IBOutlet weak var txtAddress4: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    var UPVC : UserProfileViewController!
    @IBOutlet weak var btnSave: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AddressAlertView", owner: self, options: nil)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit(){
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        btnSave.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
       
        txtAddress1.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtAddress2.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtAddress3.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtAddress4.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtPostCode.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtCounty.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        txtCountry.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        UPVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "UserProfileViewController")
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    func showAlert(){
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func actionSave(_ sender: Any) {
        if(txtAddress1.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 1" , ViewController: UPVC)
            self.txtAddress1.becomeFirstResponder()
        }
        else  if(txtAddress2.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 2" , ViewController: UPVC)
            self.txtAddress2.becomeFirstResponder()
        }
        else  if(txtAddress3.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 3" , ViewController: UPVC)
            self.txtAddress3.becomeFirstResponder()
        }
        else  if(txtAddress4.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 4" , ViewController: UPVC)
            self.txtAddress4.becomeFirstResponder()
        }
        else  if(txtPostCode.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Post Code" , ViewController: UPVC)
            self.txtPostCode.becomeFirstResponder()
        }
        else  if(txtCounty.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter County" , ViewController: UPVC)
            self.txtAddress2.becomeFirstResponder()
        }
        else  if(txtCountry.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Country" , ViewController: UPVC)
            self.txtAddress2.becomeFirstResponder()
        }else{
            UserProfileViewController.addressLine1 = txtAddress1.text!
            UserProfileViewController.addressLine2 = txtAddress2.text!
            UserProfileViewController.addressLine3 = txtAddress3.text!
            UserProfileViewController.addressLine4 = txtAddress4.text!
            UserProfileViewController.userPostCode = txtPostCode.text!
            UserProfileViewController.county = txtCounty.text!
            UserProfileViewController.country = txtCountry.text! 
            
            let string =  UserProfileViewController.addressLine1 + " " + UserProfileViewController.addressLine2 + " " + UserProfileViewController.addressLine3 + " " + UserProfileViewController.addressLine4 + " " + UserProfileViewController.userPostCode + " " + UserProfileViewController.county + " " + UserProfileViewController.country
            UserDefaults.standard.set(string, forKey: "NewAddress")
            superview?.layoutIfNeeded()
            superview?.reloadInputViews()
            parentView.removeFromSuperview()
        }
    }
    @IBAction func actionDismiss(_ sender: Any) {
        parentView.removeFromSuperview()
        
    }
    
}
