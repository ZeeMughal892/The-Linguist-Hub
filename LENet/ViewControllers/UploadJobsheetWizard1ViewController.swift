//
//  UploadJobsheetWizard1ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 07/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import LabelSwitch

class UploadJobsheetWizard1ViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var headBStart: UILabel!
    @IBOutlet weak var headDurationReq: UILabel!
    @IBOutlet weak var headFinish: UILabel!
    @IBOutlet weak var headStart: UILabel!
    @IBOutlet weak var headArrival: UILabel!
    @IBOutlet weak var headWaiting: UILabel!
    @IBOutlet weak var headBreak: UILabel!
    @IBOutlet weak var switchClient: UIView!
    
    @IBOutlet weak var lblBookingStartTime: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var txtArrivalTime: customUITextField!
    @IBOutlet weak var txtStartTime: customUITextField!
    @IBOutlet weak var txtWaitingTime: customUITextField!
    @IBOutlet weak var txtBreakTime: customUITextField!
    @IBOutlet weak var txtFinishTime: customUITextField!
    
    @IBOutlet weak var switchPolice: UIView!
    @IBOutlet weak var stackPoliceTime: UIStackView!
    @IBOutlet weak var lblPoliceTime: UILabel!
    
    let arrivalTimePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let waitingTimePicker = UIDatePicker()
    let breakTimePicker = UIDatePicker()
    let finishTimePicker = UIDatePicker()
    
    public static var bookingStartTime:String = ""
    public static var duration:Int = 0 
    public static var clientId:Int = 0
    
    @IBOutlet weak var headFeedback: PaddingLabel!
    @IBOutlet weak var headName: UILabel!
    
    @IBOutlet weak var headComments: UILabel!
    @IBOutlet weak var headPos: UILabel!
    @IBOutlet weak var txtNameOfProfessional: customUITextField!
    @IBOutlet weak var txtPosition: customUITextField!
    @IBOutlet weak var txtComments: customUITextView!
    
    @IBOutlet weak var stackName: UIStackView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var stackPosition: UIStackView!
    @IBOutlet weak var viewPosition: UIView!
    @IBOutlet weak var stackComments: UIStackView!
    @IBOutlet weak var viewComments: UIView!
    
    @IBOutlet weak var viewSwitch: UIView!
     
    var clientSwitch = LabelSwitch()
    
    var selectedOption: String?
    var labelSwitch = LabelSwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Jobsheet Info"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        let ls = LabelSwitchConfig(text: "YES",
                                   textColor: .systemBackground,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)
        
        let rs = LabelSwitchConfig(text: "NO",
                                   textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: .systemBackground)
        labelSwitch = LabelSwitch(center: .init(x: 20, y: 50), leftConfig: ls, rightConfig: rs)
        labelSwitch.circleShadow = true
        labelSwitch.fullSizeTapEnabled = true
        labelSwitch.layer.borderWidth = 1.0
        labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        labelSwitch.delegate = self
        viewSwitch.addSubview(labelSwitch)
        
        clientSwitch = LabelSwitch(center: .init(x: 24, y: 30), leftConfig: ls, rightConfig: rs)
        clientSwitch.circleShadow = true
        clientSwitch.fullSizeTapEnabled = true
        clientSwitch.layer.borderWidth = 1.0
        clientSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        clientSwitch.delegate = self
        switchClient.addSubview(clientSwitch)
        
        
        HideKeyboard()
        txtWaitingTime.isEnabled = false
        stackPoliceTime.isHidden = true
        lblPoliceTime.isHidden = true
        
        
        headFeedback.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPos.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headComments.textColor = UIColor.init(named: LoginUser.getThemeColor)        
        
        if UploadJobsheetWizard1ViewController.clientId == 828 ||
            UploadJobsheetWizard1ViewController.clientId == 829 ||
            UploadJobsheetWizard1ViewController.clientId == 830 ||
            UploadJobsheetWizard1ViewController.clientId == 831 ||
            UploadJobsheetWizard1ViewController.clientId == 840 ||
            UploadJobsheetWizard1ViewController.clientId == 841 ||
            UploadJobsheetWizard1ViewController.clientId == 842 {
            stackPoliceTime.isHidden = false
            lblPoliceTime.isHidden = false
        }else{
            stackPoliceTime.isHidden = true
            lblPoliceTime.isHidden = true
        }
        
        Modals.CreateAlert(title: "Disclaimer", message: "Please note that all job sheets are sent to the Client for verification and in the event of any fraudulent activity on your part, (which includes but is not limited to: a job sheet uploaded for an unattended booking, a job sheet uploaded with a forged signature, a job sheet uploaded with changed/altered times), you will be reported to Action Fraud. We reserve the right to commence legal proceedings and to inform the Police to take further action.", ViewController: self)
        
        
        headBStart.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headDurationReq.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headArrival.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headStart.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headWaiting.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headBreak.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        headFinish.textColor =  UIColor.init(named: LoginUser.getThemeColor)
        
        self.showArrivalTimePicker()
        self.showStartTimePicker()
        self.showFinishTimePicker()
        
        
        txtStartTime.delegate = self
        txtFinishTime.delegate = self
        txtArrivalTime.delegate = self
        txtWaitingTime.delegate = self
        txtBreakTime.delegate = self
        txtNameOfProfessional.delegate = self
        txtPosition.delegate = self
        txtComments.delegate = self
        
        lblDuration.text = String(UploadJobsheetWizard1ViewController.duration) + " Minutes"
        lblBookingStartTime.text = UploadJobsheetWizard1ViewController.bookingStartTime
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "HH:mm"
        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        let interval = time2.timeIntervalSince(time1)
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let hour = interval / 3600;
        
        return String(format: "%02d:%02d", Int(hour), Int(minute))
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
    func showArrivalTimePicker(){
        arrivalTimePicker.datePickerMode = .time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneArrivalTimePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtArrivalTime.inputAccessoryView = toolbar
        txtArrivalTime.inputView = arrivalTimePicker
    }
    @objc func doneArrivalTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        txtArrivalTime.text = formatter.string(from: arrivalTimePicker.date)
        self.view.endEditing(true)
    }
    func showStartTimePicker(){
        startTimePicker.datePickerMode = .time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartTimePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtStartTime.inputAccessoryView = toolbar
        txtStartTime.inputView = startTimePicker
    }
    @objc func doneStartTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        txtStartTime.text = formatter.string(from: startTimePicker.date)
        txtWaitingTime.text = findDateDiff(time1Str: txtArrivalTime.text!, time2Str: txtStartTime.text!)
        self.view.endEditing(true)
    }
    func showFinishTimePicker(){
        finishTimePicker.datePickerMode = .time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneFinishTimePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtFinishTime.inputAccessoryView = toolbar
        txtFinishTime.inputView = finishTimePicker
    }
    @objc func doneFinishTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        txtFinishTime.text = formatter.string(from: finishTimePicker.date)
        self.view.endEditing(true)
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionNext))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext() {
        if clientSwitch.curState == .R {
            JobsheetInfoRequestModel.InterpreterArrived = "Yes"
        }else{
            JobsheetInfoRequestModel.InterpreterArrived = "No"
        }
        if(txtArrivalTime.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Arrival Time Of Interpreter" , ViewController: self)
            self.txtArrivalTime.becomeFirstResponder()
        }else if(txtStartTime.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Start Time Of Interpretation" , ViewController: self)
            self.txtStartTime.becomeFirstResponder()
        }else if(txtWaitingTime.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Waiting Time Of Interpretation" , ViewController: self)
            self.txtWaitingTime.becomeFirstResponder()
        }else if(txtBreakTime.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Break Time Of Interpretation" , ViewController: self)
            self.txtBreakTime.becomeFirstResponder()
        }else if(txtFinishTime.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Finish Time Of Interpretation" , ViewController: self)
            self.txtFinishTime.becomeFirstResponder()
        }else if(txtNameOfProfessional.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Professional's Name" , ViewController: self)
            self.txtNameOfProfessional.becomeFirstResponder()
        }else if(txtPosition.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Professional's Position" , ViewController: self)
            self.txtPosition.becomeFirstResponder()
        }
        else if(txtComments.text ?? "").isEmpty{
            let yes = UIAlertAction(title: "Yes", style: .default,handler: {
                (action) in
                if self.labelSwitch.curState == .L {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard3ViewController") as! UploadJobsheetWizard3ViewController
                    JobsheetInfoRequestModel.IsFBNS = false
                    JobsheetInfoRequestModel.ArrivalTime = self.txtArrivalTime.text!
                    JobsheetInfoRequestModel.StartTime = self.txtStartTime.text!
                    JobsheetInfoRequestModel.WaitingTime = self.txtWaitingTime.text!
                    JobsheetInfoRequestModel.BreakTime  = self.txtBreakTime.text!
                    JobsheetInfoRequestModel.FinishTime = self.txtFinishTime.text!
                    JobsheetInfoRequestModel.JSSignedBy = self.txtNameOfProfessional.text!
                    JobsheetInfoRequestModel.JSPosition = self.txtPosition.text!
                    JobsheetInfoRequestModel.Comments = ""
                    mainVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }else{
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard2ViewController") as! UploadJobsheetWizard2ViewController
                    JobsheetInfoRequestModel.IsFBNS = true
                    JobsheetInfoRequestModel.ArrivalTime = self.txtArrivalTime.text!
                    JobsheetInfoRequestModel.StartTime = self.txtStartTime.text!
                    JobsheetInfoRequestModel.WaitingTime = self.txtWaitingTime.text!
                    JobsheetInfoRequestModel.BreakTime  = self.txtBreakTime.text!
                    JobsheetInfoRequestModel.FinishTime = self.txtFinishTime.text!
                    JobsheetInfoRequestModel.JSSignedBy = self.txtNameOfProfessional.text!
                    JobsheetInfoRequestModel.JSPosition = self.txtPosition.text!
                    JobsheetInfoRequestModel.Comments = ""
                    mainVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            })
            let no = UIAlertAction(title: "No", style: .cancel, handler:{
                (action) in
                self.txtComments.becomeFirstResponder()
            })
            yes.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            no.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: "Confirmation", message: "Are You Sure You Want to Leave Comments/Notes Empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            if self.labelSwitch.curState == .L  {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard3ViewController") as! UploadJobsheetWizard3ViewController
                JobsheetInfoRequestModel.IsFBNS = false
                JobsheetInfoRequestModel.ArrivalTime = txtArrivalTime.text!
                JobsheetInfoRequestModel.StartTime = txtStartTime.text!
                JobsheetInfoRequestModel.WaitingTime = txtWaitingTime.text!
                JobsheetInfoRequestModel.BreakTime  = txtBreakTime.text!
                JobsheetInfoRequestModel.FinishTime = txtFinishTime.text!
                JobsheetInfoRequestModel.JSSignedBy = txtNameOfProfessional.text!
                JobsheetInfoRequestModel.JSPosition = txtPosition.text!
                JobsheetInfoRequestModel.Comments = txtComments.text!
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }else{
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard2ViewController") as! UploadJobsheetWizard2ViewController
                JobsheetInfoRequestModel.IsFBNS = true
                JobsheetInfoRequestModel.ArrivalTime = txtArrivalTime.text!
                JobsheetInfoRequestModel.StartTime = txtStartTime.text!
                JobsheetInfoRequestModel.WaitingTime = txtWaitingTime.text!
                JobsheetInfoRequestModel.BreakTime  = txtBreakTime.text!
                JobsheetInfoRequestModel.FinishTime = txtFinishTime.text!
                JobsheetInfoRequestModel.JSSignedBy = txtNameOfProfessional.text!
                JobsheetInfoRequestModel.JSPosition = txtPosition.text!
                JobsheetInfoRequestModel.Comments = txtComments.text!
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
            
        }
    }
    
    
    
}

extension UploadJobsheetWizard1ViewController : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
            print("Feedback On")
        case .R:
            print("Feedback Off")
        }
    }
}
