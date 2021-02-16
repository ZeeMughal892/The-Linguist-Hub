//
//  HelpUsImproveViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 16/05/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import MessageUI
import RappleProgressHUD

class HelpUsImproveViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtDetails: customUITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var headMesage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMenuButtonToNavigationBar()
        self.title = "Help Us Improve"
        txtDetails.delegate = self
        txtDetails.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.HideKeyboard()
        btnSubmit.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        headMesage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func Keyboard(notification: Notification)
    {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        if(txtDetails.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Some Details" , ViewController: self)
            self.txtDetails.becomeFirstResponder()
        }else{
            let request =  HelpUsImproveRequest()
            request.IdCardNo = LoginUser.getIdCardNo
            request.Email = LoginUser.email
            request.DeviceType = LoginUser.getDeviceType
            request.Message = txtDetails.text
            ApiManager.api.HelpUsImprove(method: MethodTypes.Post.rawValue, url: ApiUrls.helpUsImprove, request: request, viewController: self).done { response in
                if response.d.Status != false {
                    Modals.CreateAlert(title: "Successfull !!!", message: response.d.Message, ViewController: self)
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
extension HelpUsImproveViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC =  mainStoryboard.instantiateViewController(withIdentifier: "HelpUsImproveViewController") as! HelpUsImproveViewController
        switch result {
        case .cancelled:
            Modals.CreateAlert(title: "Cancelled", message: "", ViewController: VC)
        case .failed:
            Modals.CreateAlert(title: "Failed", message: error!.localizedDescription, ViewController: VC)
        case .saved:
            Modals.CreateAlert(title: "Saved", message: "", ViewController: VC)
        case .sent:
            Modals.CreateAlert(title: "Sent", message: "Thank you. We have received your enquiry and we will get in touch shortly", ViewController: VC)
        default:
            print(error!.localizedDescription)
        }
        controller.dismiss(animated: true)
    }
}
extension UIViewController {
    func HideKeyboard(){
        let Tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}
