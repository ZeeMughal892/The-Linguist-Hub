//
//  DashboardViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import KDCircularProgress
import SWRevealViewController
import RappleProgressHUD
import SwiftProgressView

class DashboardViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var dashItems = [DashItem]()
    //@IBOutlet weak var btnAlert: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var btnMenu: UIBarButtonItem!
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var lblWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        self.addMenuButtonToNavigationBar()
        //self.addrightBtnToNavigationBar()
        loadDashboard()
        // Do any additional setup after loading the view.
        if isFirstLaunch() {
            let readMore = UIAlertAction(title: "Read More", style: .default,handler: {
                (action) in
                UIApplication.shared.open(URL(string: LoginUser.getNoticeBoardLink)!)
            })
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            readMore.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            dismiss.setValue(UIColor.red, forKey: "titleTextColor")
            let alert = UIAlertController(title: LoginUser.getNoticeBoardTitle, message: LoginUser.getNoticeBoard, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(readMore)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
        let revealController = revealViewController()
        revealController?.panGestureRecognizer()
        revealController?.tapGestureRecognizer()
        
        let device = UIDevice.modelName
        if device == "Simulator iPhone 6s"  || device == "Simulator iPhone 8"  ||
            device == "iPhone 6" ||
            device == "iPhone 6s" ||
            device == "iPhone 7" ||
            device == "iPhone 8" ||
            device == "Simulator iPhone 6s Plus" ||
            device == "iPhone 6 Plus" ||
            device == "iPhone 6s Plus" ||
            device == "iPhone 7 Plus" ||
            device == "iPhone 8 Plus" {
            if UserDefaults.standard.bool(forKey: "touchID") == false  {
                BiometricAlertView(biometric: "Touch ID")
            }
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
            if UserDefaults.standard.bool(forKey: "faceID")  == false {
                BiometricAlertView(biometric: "Face ID")
            }
        }
        else if device == "Simulator iPhone 12 Pro Max" ||
            device == "iPhone 12 Pro Max"
        {
          
        }
        
        else{
            if UserDefaults.standard.bool(forKey: "touchID") == false  {
                BiometricAlertView(biometric: "Touch ID")
            }
        }
//        btnMenu.target = revealViewController()
//        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
//        btnMenu.tintColor = UIColor.init(named: LoginUser.getThemeColor)
//        btnAlert.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        lblWelcome.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton =  UIBarButtonItem(image: UIImage.init(named: "IcoNotifications"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(openAlertsViewController))
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func openAlertsViewController()  {
        
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AlertsViewController") as! AlertsViewController
                self.navigationController?.pushViewController(mainVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dashItems.count + 1) / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DBSRowTableViewCell") as! DBSRowTableViewCell
            cell.lblTitle.text = dashItems[indexPath.row + 3].Title
            cell.lblValue.text = dashItems[indexPath.row + 3].Value
            cell.cardView.borderColor =  .white
            cell.cardView.borderColor =  .white
            if cell.lblValue.text == "NA"  {
                cell.progressView.progress = 0.0
                cell.lblPercentage.text = "0 %"
                if isFirstLaunch() {
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                dismiss.setValue(UIColor.systemBlue, forKey: "titleTextColor")
                let alert = UIAlertController(title: "Attention !!!", message: "Sorry, we don't have your DBS Details. Please send us new DBS Certificate at\n updates@empire-groupuk.com", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
                }
            }else if cell.lblValue.text == "Expired" {
                cell.progressView.progress = 0.0
                cell.lblPercentage.text = "0 %"
                if isFirstLaunch() {
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                dismiss.setValue(UIColor.systemBlue, forKey: "titleTextColor")
                let alert = UIAlertController(title: "Attention !!!", message: "Sorry, Your DBS has been Expired. Please send us new DBS Certificate at\n updates@empire-groupuk.com", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
                }
            }else{
                let eDate = dashItems[indexPath.row + 3].Description
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let date = dateFormatter.date(from: eDate!)
                var dateComponent = DateComponents()
                dateComponent.year = -1
                
                let newDate = Calendar.current.date(byAdding: dateComponent, to: date!)
                let cDate = dateFormatter.string(from: Date())
                let sDate = dateFormatter.string(from: newDate!)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let startDate = formatter.date(from: sDate)!.timeIntervalSince1970
                let endDate = formatter.date(from: eDate!)!.timeIntervalSince1970
                let currentDate = formatter.date(from: cDate)!.timeIntervalSince1970
                
                let percentage = (currentDate - startDate) / (endDate - startDate)
                
                cell.progressView.progress = Float(percentage)
                cell.lblPercentage.text = String(Int(percentage * 100)) + " %"
                if Int(percentage * 100) < 20 {
                    if isFirstLaunch() {
                    let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    dismiss.setValue(UIColor.systemBlue, forKey: "titleTextColor")
                    let alert = UIAlertController(title: "Attention !!!", message: "Your DBS is near to expire. Please send us new DBS Certificate at\n updates@empire-groupuk.com", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(dismiss)
                    self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashRow1TableViewCell") as! DashRow1TableViewCell
            if indexPath.row == 0 {                cell.lblLeft.text = dashItems[indexPath.row].Title
                cell.lblLeftValue.text = dashItems[indexPath.row].Value
                cell.lblRight.text = dashItems[indexPath.row + 1].Title
                cell.lblRightValue.text = dashItems[indexPath.row + 1].Value
                cell.circleLeft.progressColor = .systemGreen
                cell.circleRight.progressColor = .systemTeal
                cell.cardViewLeft.borderColor =  .white
                cell.cardViewRight.borderColor =  .white
                cell.lblLeftValue.textColor = .systemGreen
                cell.lblRightValue.textColor = .systemTeal
                
                self.animate(view: cell.circleLeft)
                self.animate(view: cell.circleRight)
                self.incrementLabel(to: (cell.lblLeftValue.text! as NSString).integerValue, label: cell.lblLeftValue)
                self.incrementLabel(to: (cell.lblRightValue.text! as NSString).integerValue, label: cell.lblRightValue)
            }
            if indexPath.row == 1 {
                cell.lblLeft.text = dashItems[indexPath.row + 1].Title
                cell.lblLeftValue.text = dashItems[indexPath.row + 1].Value
                cell.lblRight.text = dashItems[indexPath.row + 2].Title
                cell.lblRightValue.text = dashItems[indexPath.row + 2].Value
             
                cell.circleLeft.progressColor = .systemIndigo
                cell.circleRight.progressColor = .systemRed
               cell.cardViewLeft.borderColor =  .white
                cell.cardViewRight.borderColor =  .white
               
                cell.lblLeftValue.textColor = .systemIndigo
                cell.lblRightValue.textColor = .systemRed
                self.animate(view: cell.circleLeft)
                self.animate(view: cell.circleRight)
                self.incrementLabel(to: (cell.lblLeftValue.text! as NSString).integerValue, label: cell.lblLeftValue)
                self.incrementLabel(to: (cell.lblRightValue.text! as NSString).integerValue, label: cell.lblRightValue)
            }
            if indexPath.row == 2 {
                cell.lblLeft.text = dashItems[indexPath.row + 2].Title
                cell.lblLeftValue.text = dashItems[indexPath.row + 2].Value
                cell.lblRight.text = dashItems[indexPath.row + 3].Title
                cell.lblRightValue.text = dashItems[indexPath.row + 3].Value
                cell.circleLeft.progressColor = .systemOrange
                cell.circleRight.progressColor = .brown
                cell.cardViewLeft.borderColor =  .white
                cell.cardViewRight.borderColor =  .white
                cell.lblLeftValue.textColor = .systemOrange
                cell.lblRightValue.textColor = .brown
                self.animate(view: cell.circleLeft)
                self.animate(view: cell.circleRight)
                self.incrementLabel(to: (cell.lblLeftValue.text! as NSString).integerValue, label: cell.lblLeftValue)
                self.incrementLabel(to: (cell.lblRightValue.text! as NSString).integerValue, label: cell.lblRightValue)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 120.0
        }
        return 200
    }
    
    func incrementLabel(to endValue: Int, label: UILabel) {
        let duration: Double  = 0.5 //seconds
        if endValue != 0 {
            DispatchQueue.global().async {
                for i in 0 ..< (endValue + 1) {
                    let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        label.text = "\(i)"
                    }
                }
            }
        }
    }
    func animate(view: ProgressRingView) {
        var progress: CGFloat = view.progress
        progress = 1.0
        view.setProgress(progress, animated: true)
    }
    func isFirstLaunch() -> Bool {
        if (!UserDefaults.standard.bool(forKey: "launched_before")) {
            UserDefaults.standard.set(true, forKey: "launched_before")
            return true
        }
        return false
    }
    func BiometricAlertView(biometric: String!){
        let readMore = UIAlertAction(title: "Enable", style: .default,handler: {
            (action) in
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ManageBiometricsViewController") as! ManageBiometricsViewController
            mainVC.modalPresentationStyle = .fullScreen
            ManageBiometricsViewController.check = "0"
            self.navigationController?.pushViewController(mainVC,animated:true)
        })
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        readMore.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        dismiss.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Enable \(biometric!)", message: "Enable your \(biometric!) to login without entering email and password", preferredStyle: UIAlertController.Style.alert)
        
        if biometric == "Touch ID"
        {
            let image = UIImage(named: "touchid")
            alert.addImage(image: image!)
        }else{
            let image = UIImage(named: "faceid")
            alert.addImage(image: image!)
        }
        alert.addAction(readMore)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
//    @IBAction func actionAlerts(_ sender: Any) {
//
//        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"AlertsViewController") as! AlertsViewController
//        self.navigationController?.pushViewController(mainVC, animated: true)
//
//    }
    func loadDashboard(){
        //RappleActivityIndicatorView.startAnimating()
        let request = DashboardRequest()
        request.idcardno = LoginUser.getIdCardNo
        ApiManager.api.Dashboard(method: MethodTypes.Post.rawValue, url: ApiUrls.dashboard, request: request, viewController: self).done { response in
            if response.d.Status != false {
                self.dashItems.append(contentsOf: response.d.List)
                //RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }
            else{
                Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                //RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                //RappleActivityIndicatorView.stopAnimation()
        }
    }
}
