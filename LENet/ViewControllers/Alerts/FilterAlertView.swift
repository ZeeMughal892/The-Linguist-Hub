//
//  FilterAlertView.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 05/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCrashlytics

class FilterAlertView : UIView{
    
    static let instance = FilterAlertView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var alertView: CardView!

    @IBOutlet weak var txtDateFrom: UITextField!
    @IBOutlet weak var txtDateTo: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    let DateFromPicker = UIDatePicker()
    let DateToPicker = UIDatePicker()
    public static var ABVC : AllBookingsViewController!
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FilterAlertView", owner: self, options: nil)
        
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func actionFilter(_ sender: Any) {
       let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC =  mainStoryboard.instantiateViewController(withIdentifier: "AllBookingsViewController") as! AllBookingsViewController
        if(txtDateFrom.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Select Date From" , ViewController: VC)
            self.txtDateFrom.becomeFirstResponder()
        }else if (txtDateTo.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Select Date To" , ViewController: VC)
            self.txtDateTo.becomeFirstResponder()
        }else{
            AllBookingsViewController.dateFrom = txtDateFrom.text!
            AllBookingsViewController.dateTo = txtDateTo.text!
            FilterAlertView.ABVC.tableView.reloadData()
         FilterAlertView.ABVC.tableView.backgroundView = UIView()
         parentView.removeFromSuperview()
         }
       
    }
   
    private func commonInit(){
        showDateFromPicker()
        showDateToPicker()
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        btnFilter.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        lblTitle.textColor = UIColor.init(named: LoginUser.getThemeColor)
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    func showAlert(){
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func actionDismiss(_ sender: Any) {
        parentView.removeFromSuperview()
    }
   func showDateFromPicker(){
        DateFromPicker.datePickerMode = .date       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDateFromPicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtDateFrom.inputAccessoryView = toolbar
        txtDateFrom.inputView = DateFromPicker
    }
    @objc func doneDateFromPicker(sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDateFrom.text = formatter.string(from: DateFromPicker.date)
        txtDateFrom.resignFirstResponder()
    }
    
   func showDateToPicker(){
       DateToPicker.datePickerMode = .date
       let toolbar = UIToolbar()
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDateToPicker))
       toolbar.setItems([doneButton], animated: false)
       toolbar.isUserInteractionEnabled = true
       txtDateTo.inputAccessoryView = toolbar
       txtDateTo.inputView = DateToPicker
   }
   @objc func doneDateToPicker(sender:UIDatePicker){
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       txtDateTo.text = formatter.string(from: DateToPicker.date)
       txtDateTo.resignFirstResponder()
   }
}
