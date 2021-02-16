//
//  PageFourViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 26/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class PageFourViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SignInViewController") as! SignInViewController
            mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC,animated:true,completion:nil)
    }
}
