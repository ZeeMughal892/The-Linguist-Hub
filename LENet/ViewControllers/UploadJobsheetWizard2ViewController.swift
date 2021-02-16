//
//  UploadJobsheetWizard2ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 07/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import Cosmos
import LabelSwitch

class UploadJobsheetWizard2ViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var headSatisfy: UILabel!
    @IBOutlet weak var swtichArrive: UIView!
    @IBOutlet weak var switchManner: UIView!
    @IBOutlet weak var switchIDCard: UIView!
    @IBOutlet weak var switchPreBriefing: UIView!
    @IBOutlet weak var switchCustomerCare: UIView!
    @IBOutlet weak var switchDress: UIView!
    @IBOutlet weak var switchWantSame: UIView!
    
    
    @IBOutlet weak var txtSatisfaction: customUITextField!
    
    
    @IBOutlet weak var starRatingFromCustomer: CosmosView!
    
    @IBOutlet weak var headRating: UILabel!
    
    var selectedOption: String?
    var optionList = ["Very Satisfied", "Satisfied" , "Dis-Satisfied"]
    
    var arriveSwitch = LabelSwitch()
    var mannerSwitch = LabelSwitch()
    var iDCardSwitch = LabelSwitch()
    var preSwitch = LabelSwitch()
    var customerSwitch = LabelSwitch()
    var dressSwitch = LabelSwitch()
    var wantSwitch = LabelSwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        headRating.textColor = UIColor.init(named: LoginUser.getThemeColor)
        let ls = LabelSwitchConfig(text: "YES",
                                   textColor: .systemBackground,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)
        
        let rs = LabelSwitchConfig(text: "NO",
                                   textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: .systemBackground)
        arriveSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        arriveSwitch.circleShadow = true
        arriveSwitch.fullSizeTapEnabled = true
        arriveSwitch.layer.borderWidth = 1.0
        arriveSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        arriveSwitch.delegate = self
        swtichArrive.addSubview(arriveSwitch)
        
        mannerSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        mannerSwitch.circleShadow = true
        mannerSwitch.fullSizeTapEnabled = true
        mannerSwitch.layer.borderWidth = 1.0
        mannerSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        mannerSwitch.delegate = self
        switchManner.addSubview(mannerSwitch)
        
        iDCardSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        iDCardSwitch.circleShadow = true
        iDCardSwitch.fullSizeTapEnabled = true
        iDCardSwitch.layer.borderWidth = 1.0
        iDCardSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        iDCardSwitch.delegate = self
        switchIDCard.addSubview(iDCardSwitch)
        
        preSwitch = LabelSwitch(center: .init(x: 24, y: 32), leftConfig: ls, rightConfig: rs)
        preSwitch.circleShadow = true
        preSwitch.fullSizeTapEnabled = true
        preSwitch.layer.borderWidth = 1.0
        preSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        preSwitch.delegate = self
        switchPreBriefing.addSubview(preSwitch)
         
        customerSwitch = LabelSwitch(center: .init(x: 24, y: 32), leftConfig: ls, rightConfig: rs)
        customerSwitch.circleShadow = true
        customerSwitch.fullSizeTapEnabled = true
        customerSwitch.layer.borderWidth = 1.0
        customerSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        customerSwitch.delegate = self
        switchCustomerCare.addSubview(customerSwitch)
    
        dressSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        dressSwitch.circleShadow = true
        dressSwitch.fullSizeTapEnabled = true
        dressSwitch.layer.borderWidth = 1.0
        dressSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        dressSwitch.delegate = self
        switchDress.addSubview(dressSwitch)
       
        wantSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        wantSwitch.circleShadow = true
        wantSwitch.fullSizeTapEnabled = true
        wantSwitch.layer.borderWidth = 1.0
        wantSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        wantSwitch.delegate = self
        switchWantSame.addSubview(wantSwitch)
        
               
        headSatisfy.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        HideKeyboard()
        
        self.createPickerView()
        self.dismissPickerView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        starRatingFromCustomer.settings.fillMode = .full
        starRatingFromCustomer.settings.updateOnTouch = true
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
        txtSatisfaction.text = selectedOption
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtSatisfaction.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtSatisfaction.inputAccessoryView = toolBar
    }
    @objc func action() {
        if txtSatisfaction.text == "" {
            txtSatisfaction.text = optionList[0]
        }
        view.endEditing(true)
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionNext))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext() {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard3ViewController") as! UploadJobsheetWizard3ViewController
        if arriveSwitch.curState == .R {
            JobsheetInfoRequestModel.ArriveOnTime = "Yes"
        }else{
            JobsheetInfoRequestModel.ArriveOnTime = "No"
        }
        if mannerSwitch.curState == .R {
            JobsheetInfoRequestModel.Intro = "Yes"
        }else{
            JobsheetInfoRequestModel.Intro = "No"
        }
        if iDCardSwitch.curState == .R {
            JobsheetInfoRequestModel.WearLECard = "Yes"
        }else{
            JobsheetInfoRequestModel.WearLECard = "No"
        }
        if dressSwitch.curState == .R {
            JobsheetInfoRequestModel.Dress = "Yes"
        }else{
            JobsheetInfoRequestModel.Dress = "No"
        }
        if preSwitch.curState == .R {
            JobsheetInfoRequestModel.PreAssignment = "Yes"
        }else{
            JobsheetInfoRequestModel.PreAssignment = "No"
        }
        if customerSwitch.curState == .R {
            JobsheetInfoRequestModel.CustomerCare = "Yes"
        }else{
            JobsheetInfoRequestModel.CustomerCare = "No"
        }
        if wantSwitch.curState == .R {
            JobsheetInfoRequestModel.WantSameInterpreter = "Yes"
        }else{
            JobsheetInfoRequestModel.WantSameInterpreter = "No"
        }
        
        if(txtSatisfaction.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Select One Option" , ViewController: self)
            self.txtSatisfaction.becomeFirstResponder()
        }else{
            JobsheetInfoRequestModel.StarRatingFromCustomer = String(Int(starRatingFromCustomer.rating))
            JobsheetInfoRequestModel.Satisfied = txtSatisfaction.text!
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}

extension UploadJobsheetWizard2ViewController : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
            print("Value Off")
        case .R:
            print("Value Off")
        }
    }
}
