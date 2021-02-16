//
//  FilterAlertView.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 05/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//
import Foundation
import UIKit
import MessageUI
import RappleProgressHUD

class EmailAlertView : UIView{
    
    static let instance = EmailAlertView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var alertView: CardView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var selectedOption: String?
    var optionList = ["Dashboard",
                      "Filter Bookings",
                      "Available Bookings",
                      "Booking Calendar",
                      "E-Signature Upload",
                      "My Requests" ,
                      "Booking Reminders" ,
                      "Booking Details" ,
                      "My Profile",
                      "Contact Us",
                      "Settings",
                      "PCA",
                      "Absence",
                      "Change Theme Color",
                      "Notification",
                      "Report An Issue",
                      "Alerts Section",
                      "Logout"]
   
    public static var CUVC: ContactUsViewController!
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("EmailAlertView", owner: self, options: nil)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit(){
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        txtDetails.layer.borderColor = UIColor.lightGray.cgColor
        txtCategory.layer.borderColor = UIColor.lightGray.cgColor
        alertView.borderWidth = 1.0
        alertView.borderColor = UIColor.init(named: LoginUser.getThemeColor)
        EmailAlertView.CUVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ContactUsViewController") as? ContactUsViewController
        self.createPickerView()
        self.dismissPickerView()
        btnSend.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        lblTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    func showAlert(){
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func actionSend(_ sender: Any) {
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...")
       
        let request =  ContactUsRequest()
        request.IdCardNo = LoginUser.getIdCardNo
        request.Email = LoginUser.email
        request.DeviceType = LoginUser.getDeviceType
        request.Category = txtCategory.text
        request.Message = txtDetails.text
        ApiManager.api.ContactUs(method: MethodTypes.Post.rawValue, url: ApiUrls.contactUs, request: request, viewController: EmailAlertView.CUVC).done { response in
            if response.d.Status != false {
                RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Sent", completionTimeout: 2.0)
                self.parentView.removeFromSuperview()
            }else{
                self.SuccessAlertView(title: "Failed !",message: response.d.Message)
                RappleActivityIndicatorView.stopAnimation()
                self.parentView.removeFromSuperview()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: EmailAlertView.CUVC)
                RappleActivityIndicatorView.stopAnimation()
                self.parentView.removeFromSuperview()
        }
    }
    @IBAction func actionDismiss(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    func SuccessAlertView(title: String! ,message: String!){
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        dismiss.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Successfull", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(dismiss)
        EmailAlertView.CUVC.present(alert, animated: true, completion: nil)
    }
}
extension  EmailAlertView:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return optionList[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "copperplate-bold", size: 15)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = optionList[row]
        pickerLabel?.textColor = UIColor.label
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = optionList[row]
        txtCategory.text = selectedOption
    }
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtCategory.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(actionDismiss))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtCategory.inputAccessoryView = toolBar
    }
    @objc func actionDismiss(sender: UIPickerView) {
        parentView.endEditing(true)
    }
}
