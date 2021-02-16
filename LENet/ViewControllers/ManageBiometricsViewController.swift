//
//  ManageTouchIDViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 16/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import LabelSwitch

class ManageBiometricsViewController: BaseViewController {
    
    @IBOutlet weak var lblTouch: UILabel!
    @IBOutlet weak var lblAcceptance: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
 
    
    @IBOutlet weak var smallPoints: NSLayoutConstraint!
    @IBOutlet weak var largePoints: NSLayoutConstraint!
    @IBOutlet weak var smallView: NSLayoutConstraint!
    @IBOutlet weak var largeView: NSLayoutConstraint!
    
    @IBOutlet weak var viewSwitch: UIView!
    
    public static var check:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButtonToNavigationBar()
        self.title = "Manage Touch ID"
        let ls = LabelSwitchConfig(text: "ON",
                                   textColor: .systemBackground,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)
        
        let rs = LabelSwitchConfig(text: "OFF",
                                   textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: .systemBackground)
        
        let device = UIDevice.modelName
        if device == "Simulator iPhone 6s"  ||
            device == "iPhone 6" ||
            device == "iPhone 6s" ||
            device == "iPhone 7" ||
            device == "iPhone 8" ||
            device == "Simulator iPhone 6s Plus" ||
            device == "iPhone 6 Plus" ||
            device == "iPhone 6s Plus" ||
            device == "iPhone 7 Plus" ||
            device == "iPhone 8 Plus" {
           
                   
            let labelSwitch = LabelSwitch(center: .init(x: 16, y: 32), leftConfig: ls, rightConfig: rs)
            labelSwitch.circleShadow = true
           
            labelSwitch.fullSizeTapEnabled = true
            labelSwitch.layer.borderWidth = 1.0
            labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
          
            labelSwitch.delegate = self
            viewSwitch.addSubview(labelSwitch)
            
            if UserDefaults.standard.bool(forKey: "touchID") == true {
              labelSwitch.curState  = .R
            }
            smallView.isActive = true
            smallPoints.isActive = true
            largeView.isActive = false
            largePoints.isActive = false
            
            lblPoints.text =  "\u{2022} Please ensure that no unknown fingerprints are saved in your phone.\n\n \u{2022} Once Touch ID will be enabled, you can login the app & perform functions by using your fingerprint.\n\n \u{2022} If Touch ID prompt is cancelled, you can still login the app & perform functions with the help of your The Linguist Hub Account Email and Password. \n\n \u{2022} You must activate the fingerprint identity sensor on the Permitted Mobile Device and register at least one of your fingerprints to control access to the Permitted Mobile Device. \n\n \u{2022} Upon successful registration for Fingerprint Authentication, All finger prints stored on the Permitted Mobile Device registered for Fingerprint Authentication at the time of or after registration can be used to access The Linguist Hub.\n\n \u{2022} You mist use the App or Fingerprint Authentication on Permitted Mobile Phones."
            lblPoints.sizeToFit()
            lblTouch.text = "Use Touch ID for Login"
            lblAcceptance.text = "Acceptance of Touch ID Terms & Conditions"
            self.title = "Manage Touch ID"
        }else if device == "Simulator iPhone 11" ||
            device == "iPhone 11" ||
            device == "iPhone XR" ||
            device == "Simulator iPhone 11 Pro" ||
            device == "iPhone 11 Pro" ||
            device == "iPhone XS"  ||
            device == "iPhone X" ||
            device == "iPhone 12 mini" ||
            device == "Simulator iPhone 12 mini" ||
            device == "Simulator iPhone 11 Pro Max" ||
            device == "iPhone 11 Pro Max" ||
            device == "iPhone XS Max"{
            let labelSwitch = LabelSwitch(center: .init(x: 16, y: 42), leftConfig: ls, rightConfig: rs)
            labelSwitch.circleShadow = true
            labelSwitch.circleColor = UIColor.init(named: LoginUser.getThemeColor)!
            labelSwitch.fullSizeTapEnabled = true
            labelSwitch.layer.borderWidth = 1.0
            labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
            
            labelSwitch.delegate = self
            viewSwitch.addSubview(labelSwitch)
            if UserDefaults.standard.bool(forKey: "faceID") == true {
                labelSwitch.curState  = .R
            }
            lblPoints.text =  "\u{2022} Please ensure that no unknown faces are saved in your phone.\n\n \u{2022} Once Face ID will be enabled, you can login the app & perform functions by using your facial recognition.\n\n \u{2022} If Face ID prompt is cancelled, you can still login the app & perform functions with the help of your The Linguist Hub Account Email and Password. \n\n \u{2022} You must activate the facial recoginition identity sensor on the Permitted Mobile Device and register at least one of your faces to control access to the Permitted Mobile Device. \n\n \u{2022} Upon successful registration for facial recoginition Authentication, All faces stored on the Permitted Mobile Device registered for Facial Recoginition Authentication at the time of or after registration can be used to access The Linguist Hub.\n\n \u{2022} You mist use the App or Facial Recoginition Authentication on Permitted Mobile Phones."
            lblPoints.sizeToFit()
            lblTouch.text = "Use Face ID for Login"
            self.title = "Manage Face ID"
            lblAcceptance.text = "Acceptance of Face ID Terms & Conditions"
            smallView.isActive = false
            smallPoints.isActive = false            
            
            largeView.isActive = true
            largePoints.isActive = true
        }else if device == "Simulator iPhone 12 Pro Max" ||
                    device == "iPhone 12 Pro Max"
                {
                  
                }
                else{
            let labelSwitch = LabelSwitch(center: .init(x: 16, y: 32), leftConfig: ls, rightConfig: rs)
            labelSwitch.circleShadow = true
            labelSwitch.circleColor = UIColor.init(named: LoginUser.getThemeColor)!
            labelSwitch.fullSizeTapEnabled = true
            labelSwitch.layer.borderWidth = 1.0
            labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
            
            labelSwitch.delegate = self
            viewSwitch.addSubview(labelSwitch)
            if UserDefaults.standard.bool(forKey: "touchID") == true {
                labelSwitch.curState  = .R
            }
            lblPoints.text =  "\u{2022} Please ensure that no unknown fingerprints are saved in your phone.\n\n \u{2022} Once Touch ID will be enabled, you can login the app & perform functions by using your fingerprint.\n\n \u{2022} If Touch ID prompt is cancelled, you can still login the app & perform functions with the help of your The Linguist Hub Account Email and Password. \n\n \u{2022} You must activate the fingerprint identity sensor on the Permitted Mobile Device and register at least one of your fingerprints to control access to the Permitted Mobile Device. \n\n \u{2022} Upon successful registration for Fingerprint Authentication, All finger prints stored on the Permitted Mobile Device registered for Fingerprint Authentication at the time of or after registration can be used to access The Linguist Hub.\n\n \u{2022} You mist use the App or Fingerprint Authentication on Permitted Mobile Phones."
            lblPoints.sizeToFit()
            lblTouch.text = "Use Touch ID for Login"
            lblAcceptance.text = "Acceptance of Touch ID Terms & Conditions"
            self.title = "Manage Touch ID"
            smallView.isActive = true
            smallPoints.isActive = true
            
            largeView.isActive = false
            largePoints.isActive = false
        }
        
        
      
        lblTouch.textColor = UIColor.init(named: LoginUser.getThemeColor)
        lblAcceptance.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    override func addBackButtonToNavigationBar() {
        self.leftBarButton =  UIBarButtonItem(image: UIImage.init(named: "chevron"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionBack))
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    @objc func actionBack()  {
        if ManageBiometricsViewController.check == "1" {
            //dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension ManageBiometricsViewController : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
            let labelSwitch = LabelSwitch()
            labelSwitch.circleColor = UIColor.init(named: LoginUser.getThemeColor)!
            if self.title == "Manage Touch ID"  {
                LoginUser.touchID = false
                UserDefaults.standard.set(LoginUser.touchID, forKey: "touchID")
            }else if self.title == "Manage Face ID" {
                LoginUser.touchID = false
                UserDefaults.standard.set(LoginUser.faceID, forKey: "faceID")
            }else{
                
            }
        case .R:
            let labelSwitch = LabelSwitch()
            labelSwitch.circleColor = .white
            if self.title == "Manage Touch ID"  {
                LoginUser.touchID = true
                UserDefaults.standard.set(LoginUser.touchID, forKey: "touchID")
            }else if self.title == "Manage Face ID" {
                LoginUser.touchID = true
                UserDefaults.standard.set(LoginUser.faceID, forKey: "faceID")
            }else{
                
            }
        }
    }
}
