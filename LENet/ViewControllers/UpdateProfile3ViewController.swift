//
//  UpdateProfile3ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD

class UpdateProfile3ViewController: BaseViewController {
    
   
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtVerificationCode: UITextField!
    @IBOutlet weak var headContact: UILabel!
    @IBOutlet weak var headVerification: UILabel!
    @IBOutlet weak var stackVerification: UIStackView!
    @IBOutlet weak var viewVerification: UIView!
    
    var verificationCode:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        self.title = "Contact Update"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        headContact.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headVerification.textColor = UIColor.init(named: LoginUser.getThemeColor)
        btnNext.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        btnNext.setTitleColor(.systemBackground, for: .normal)
        
        btnNext.setTitle("Send Code", for: .normal)        
        stackVerification.isHidden = true
        viewVerification.isHidden = true
        txtContactNumber.text = LoginUser.getMobile
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionSkip))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionSkip(){
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile4ViewController") as! UpdateProfile4ViewController
        mainVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
  
    
    @IBAction func actionNext(_ sender: Any) {
        if btnNext.titleLabel!.text == "Send Code" {
            if txtContactNumber.text != LoginUser.getEmail {
                RappleActivityIndicatorView.startAnimating()
                let request = UpdatePhoneRequest()
                request.IDCardNo = LoginUser.getIdCardNo
                ApiManager.api.UpdatePhone(method: MethodTypes.Post.rawValue, url: ApiUrls.updatePhone, request: request, viewController: self).done { response in
                    if response.d.Status != false {
                        Modals.CreateAlert(title: "Code Sent", message: "A 6-digit verification code has been sent to \(LoginUser.getEmail)", ViewController: self)
                        self.verificationCode = response.d.Data
                        self.stackVerification.isHidden = false
                        self.viewVerification.isHidden = false
                        self.btnNext.setTitle("Verify", for: .normal)
                        RappleActivityIndicatorView.stopAnimation()
                    }
                    else{
                        Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                    }
                }.catch
                    {
                        error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                }
            }
            else {
                Modals.CreateAlert(title: "", message: "You have entered the same phone number. Please enter a different phone number", ViewController: self)
            }
        }
        else if  btnNext.titleLabel!.text == "Verify" {
            if (self.txtVerificationCode.text ?? "").isEmpty{
                Modals.CreateAlert(title: "Error !!", message: "Please Enter Verification Code Sent to \(LoginUser.getEmail)", ViewController: self)
            }
            else if verificationCode == txtVerificationCode.text! {
                RappleActivityIndicatorView.startAnimating()
                let request = UpdatePhoneConfirmRequest()
                request.IDCardNo = LoginUser.getIdCardNo
                request.NewMobile = txtContactNumber.text!
                request.AuthConfirm = 1
                ApiManager.api.UpdatePhoneConfirm(method: MethodTypes.Post.rawValue, url: ApiUrls.updatePhoneConfirm, request: request, viewController: self).done { response in
                    if response.d.Status != false {
                        Modals.CreateAlert(title: "Success !!!", message: response.d.Message, ViewController: self)
                        LoginUser.mobile = self.txtContactNumber.text!
                        UserDefaults.standard.set(LoginUser.mobile, forKey: "email")
                        
                        self.viewVerification.isHidden = true
                        self.stackVerification.isHidden = true
                        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile4ViewController") as! UpdateProfile4ViewController
                        mainVC.modalPresentationStyle = .fullScreen
//                        self.present(mainVC,animated:true,completion:nil)
                        self.navigationController?.pushViewController(mainVC, animated: true)
                        RappleActivityIndicatorView.stopAnimation()
                    }
                    else{
                        Modals.CreateAlert(title: "Error !!!", message: response.d.Message, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                    }
                }.catch
                    {
                        error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                        RappleActivityIndicatorView.stopAnimation()
                }
            }
        }
    }
}
