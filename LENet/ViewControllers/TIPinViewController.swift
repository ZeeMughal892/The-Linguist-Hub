//
//  TIPinViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 07/08/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import SWRevealViewController
import RappleProgressHUD

class TIPinViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnShowPin: UIButton!
    @IBOutlet weak var txtPin: customUITextField!
    @IBOutlet weak var lblSQ1: UILabel!
    @IBOutlet weak var txtAns1: UITextField!
    @IBOutlet weak var lblSQ2: UILabel!
    @IBOutlet weak var txtAns2: UITextField!
    @IBOutlet weak var lblSQ3: UILabel!
    @IBOutlet weak var txtAns3: UITextField!
    
    @IBOutlet weak var stackSQ: UIStackView!
    
    @IBOutlet weak var btnSubmit: UIBarButtonItem!
    var btn = 0
    var ans1 = ""
    var ans2 = ""
    var ans3 = ""
    
    var pin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HideKeyboard()
        self.btnSubmit.isEnabled = false
        self.stackSQ.isHidden = true
        self.loadQuestions()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        btnMenu.tintColor =  UIColor.init(named: LoginUser.getThemeColor)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named:LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func someAction() {

    }
    @IBAction func actionShowPin(_ sender: Any) {
        if btn == 0 {
            stackSQ.isHidden = false
            self.btnSubmit.isEnabled = true
            btnShowPin.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            btn = 1
        }else if btn == 1{
            stackSQ.isHidden = true
            self.btnSubmit.isEnabled = false
            btnShowPin.setImage(UIImage(systemName: "square"), for: .normal)
            btn = 0
        }else{
            stackSQ.isHidden = true
            self.btnSubmit.isEnabled = false
            btnShowPin.setImage(UIImage(systemName: "square"), for: .normal)
            txtPin.text =  "*** ***"
            btn = 0
        }
    }
    @IBAction func actionSubmit(_ sender: Any) {
        if txtAns1.text == ans1 && txtAns2.text == ans2 && txtAns3.text == ans3 {
            txtPin.text = pin
            stackSQ.isHidden = true
            self.btnSubmit.isEnabled = false
            btnShowPin.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
         
            btn = 2
        }else{
            Modals.CreateAlert(title: "Error", message: "Your security answers are not correct.", ViewController: self)
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 50 {
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
    func loadQuestions(){
        RappleActivityIndicatorView.startAnimating()
        let request = GetShowPinRequest()
        request.IdCardNo = LoginUser.getUserID
        ApiManager.api.GetShowPin(method: MethodTypes.Post.rawValue, url: ApiUrls.getShowPin, request: request, viewController: self).done { response in
            if response.d.Status != false {
                self.lblSQ1.text = response.d.SecurityQuestion1
                self.lblSQ2.text = response.d.SecurityQuestion2
                self.lblSQ3.text = response.d.SecurityQuestion3
                
                self.ans1 = response.d.SecurityQuestion1Answer
                self.ans2 = response.d.SecurityQuestion2Answer
                self.ans3 = response.d.SecurityQuestion3Answer
                
                self.pin = response.d.Data
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
