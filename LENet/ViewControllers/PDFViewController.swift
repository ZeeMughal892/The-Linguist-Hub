//
//  PDFViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 09/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import WebKit
import SWRevealViewController

class PDFViewController: BaseViewController {
    
    @IBOutlet weak var pdfView: WKWebView!
    public static var pdfUrl:URL!
    
    public static var check:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jobsheet"
        self.addBackButtonToNavigationBar()
        let req = NSURLRequest(url: PDFViewController.pdfUrl)
        pdfView.load(req as URLRequest)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    override func addBackButtonToNavigationBar() {
        self.leftBarButton = UIBarButtonItem(title: "Jobsheet", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionClose))
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    @objc func actionClose()  {
        if PDFViewController.check == "1"{
            /*
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
            mainVC.modalPresentationStyle = .fullScreen
            //self.navigationController?.present(mainVC, animated: true, completion: nil)
            self.present(mainVC,animated:true,completion:nil)
 */
            let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.view.window?.rootViewController = sw

            let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            sw.pushFrontViewController(newFrontViewController, animated: true)
            
        }else{
            self.navigationController?.popViewController(animated: true)
            
        }
    }

    
}
