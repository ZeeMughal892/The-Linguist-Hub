//
//  AlertViews.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 28/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import UIKit

public class Modals {
    public static var confirmBox = UIAlertController(title:"",message:"",preferredStyle:UIAlertController.Style.alert)
    public static var alertBox = UIAlertController(title:"",message:"",preferredStyle:UIAlertController.Style.alert)
   
    
    
    
    public static func CreateConfirm(title:String,message:String,ViewController:UIViewController)
    {
        confirmBox = UIAlertController(title:title,message:message,preferredStyle:UIAlertController.Style.alert)
        ViewController.present(confirmBox,animated:true,completion:nil)
    }
  
    
    public static func CreateAlert(title:String,message:String,ViewController:UIViewController)
    {
        let alert = UIAlertController(title:title,message:message,preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK",style:UIAlertAction.Style.default,handler:{ (action) in
            alert.dismiss(animated:true,completion:nil)
        }))
        ViewController.present(alert,animated:true,completion:nil)
    }
    
    
    public static func CustomAlertBox(title:String,message:String,ViewController:UIViewController)
    {
        alertBox = UIAlertController(title:title,message:message,preferredStyle:UIAlertController.Style.alert)
        ViewController.present(alertBox,animated:true,completion:nil)
    }
    public static func showAlertWithActions(style:UIAlertController.Style, title:String?, message:String?, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)],completion:  (() -> Swift.Void)? = nil, ViewController:UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        ViewController.present(alert,animated:true,completion:nil)
    }
    
    
    
}


