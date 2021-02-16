//
//  NotificationTableViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD
import Alamofire
import LabelSwitch

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: PaddingLabel!
    @IBOutlet weak var viewSwitch: UIView!
    public static var SVC : SettingsViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
          let ls = LabelSwitchConfig(text: "ON",
                                       textColor: .systemBackground,
                                       font: UIFont.boldSystemFont(ofSize: 12),
                                       backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)
            
            let rs = LabelSwitchConfig(text: "OFF",
                                       textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                       font: UIFont.boldSystemFont(ofSize: 12),
                                       backgroundColor: .systemBackground)
            
        let labelSwitch = LabelSwitch(center: .init(x: 16, y: 16), leftConfig: ls, rightConfig: rs)
        labelSwitch.circleShadow = true
        labelSwitch.circleColor = UIColor.init(named: LoginUser.getThemeColor)!
        labelSwitch.fullSizeTapEnabled = true
        labelSwitch.layer.borderWidth = 1.0
        labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        
        labelSwitch.delegate = self
        viewSwitch.addSubview(labelSwitch)
        
        if LoginUser.getIsEmail == 1
        {
            labelSwitch.curState  = .R
        }else{
            labelSwitch.curState  = .L
        }
        NotificationTableViewCell.SVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingsViewController") as SettingsViewController
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension NotificationTableViewCell : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
            RappleActivityIndicatorView.startAnimating()
            let request = EmailNotificationRequest()
            request.idCardNo = LoginUser.getIdCardNo
            request.value = false
            ApiManager.api.EmailNotification(method: MethodTypes.Post.rawValue, url: ApiUrls.updateEmailNotification, request: request, viewController: NotificationTableViewCell.SVC).done { response in
                if response.d.Status != false {
                    LoginUser.isEmail = 0
                    UserDefaults.standard.set(LoginUser.isEmail, forKey: "isEmail")
                    Modals.CreateAlert(title: "", message: "Email Notification disabled", ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
                }
                else{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
            }
        case .R:
            RappleActivityIndicatorView.startAnimating()
            let request = EmailNotificationRequest()
            request.idCardNo = LoginUser.getIdCardNo
            request.value = true
            ApiManager.api.EmailNotification(method: MethodTypes.Post.rawValue, url: ApiUrls.updateEmailNotification, request: request, viewController: NotificationTableViewCell.SVC).done { response in
                if response.d.Status != false {
                    LoginUser.isEmail = 1
                    UserDefaults.standard.set(LoginUser.isEmail, forKey: "isEmail")
                    Modals.CreateAlert(title: "", message: "Email Notification enabled", ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
                }
                else{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: NotificationTableViewCell.SVC)
                    RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
}
