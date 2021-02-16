//
//  ChangeThemeColorViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 24/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class ChangeThemeColorViewController: BaseViewController {
    
    var colorNamesArr:Array = [String]()
    var colorCodeArr:Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Theme Color"
        self.addBackButtonToNavigationBar()
        colorNamesArr = [ "Neon Pink",
                          "Purple",
                          "Pink",
                          "Red",
                          "Green",
                          "Orange",
                          "Blue"]
        colorCodeArr = [ "colorNeonPinkLogo",
                         "colorPurpleLogo",
                         "colorPinkLogo",
                         "colorRedLogo",
                         "colorGreenLogo",
                         "colorOrangeLogo",
                         "colorBlueLogo"
        ]
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
  
}
extension ChangeThemeColorViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorNamesArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colorNames = colorNamesArr[indexPath.row]
        let colorCodes = colorCodeArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeThemeColorTableViewCell") as! ChangeThemeColorTableViewCell
        cell.setColor(Name: colorNames, Code: colorCodes)
        cell.delegate = self
        tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
        tableView.tableFooterView = UIView()
        return cell
    }
}
extension ChangeThemeColorViewController : ChangeThemeColorDelegate {
    func didTapButton(colorCode: String) {
        let restart = UIAlertAction(title: "Restart App", style: .default,handler: {
            (action) in
            LoginUser.themeColor = colorCode
            UserDefaults.standard.set(LoginUser.themeColor, forKey: "themeColor")
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SplashViewController") as! SplashViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC,animated:true,completion:nil)
        })
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        restart.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        dismiss.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Attention !!!", message: "Application Needs Restart to Apply Changes", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(restart)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
}
