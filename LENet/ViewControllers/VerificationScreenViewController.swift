//
//  VerificationScreenViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD


class VerificationScreenViewController: UIViewController {
    
    @IBOutlet weak var txtVerificationCode: customUITextField!
    var code:String!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionVerify(_ sender: Any) {
        if(txtVerificationCode.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message: "Please Enter Verification sent to your registered mobile number", ViewController: self)
        }else{
            if LoginUser.getTwoFACode == "" {
                if txtVerificationCode.text == code {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC,animated:true,completion:nil)
                }
            }else{
                if txtVerificationCode.text == LoginUser.getTwoFACode{
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC,animated:true,completion:nil)
                }
            }            
        }
    }
    @IBAction func actionResendCode(_ sender: Any) {        
        RappleActivityIndicatorView.startAnimating()
        let request = ResendCodeRequest()
        request.idCardNo = LoginUser.getIdCardNo
        ApiManager.api.ResendCode(method: MethodTypes.Post.rawValue, url: ApiUrls.resendCode, request: request, viewController: self).done { response in
            if response.d.Status != false{
                Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                self.code = response.d.Data
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
}
