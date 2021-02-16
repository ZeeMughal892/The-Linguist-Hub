//
//  UploadJobsheetWizard3ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import SwiftSignatureView
import SWRevealViewController
import RappleProgressHUD

class UploadJobsheetWizard3ViewController: BaseViewController, SwiftSignatureViewDelegate {
    
    @IBOutlet weak var headArrival: UILabel!
    @IBOutlet weak var lblBookingDateTime: UILabel!
    @IBOutlet weak var lblDurationReq: UILabel!
    @IBOutlet weak var headDateTime: UILabel!
    @IBOutlet weak var headFinish: UILabel!
    @IBOutlet weak var headDurationReq: UILabel!
    @IBOutlet weak var headWaiting: UILabel!
    @IBOutlet weak var headStart: UILabel!
    @IBOutlet weak var headMessage: UILabel!

    @IBOutlet weak var lblArrivalTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblWaitingTime: UILabel!
    @IBOutlet weak var lblFinishTime: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var signatureView: SwiftSignatureView!
    var signature:String = ""
    
    public static var bookingStartTime:String = ""
    public static var duration:Int = 0
    
    public static var bookingLanguage:String = ""
    public static var rateType:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Confirm Details"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        btnClear.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        
        headMessage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headDateTime.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headDurationReq.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headStart.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headArrival.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headWaiting.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headFinish.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        
        lblDurationReq.text = String(UploadJobsheetWizard3ViewController.duration) + " Minutes"
        lblBookingDateTime.text = UploadJobsheetWizard3ViewController.bookingStartTime
        lblArrivalTime.text = JobsheetInfoRequestModel.getArrivalTime
        lblStartTime.text = JobsheetInfoRequestModel.getStartTime
        lblWaitingTime.text = JobsheetInfoRequestModel.getWaitingTime
        lblFinishTime.text = JobsheetInfoRequestModel.getFinishTime
        
        self.signatureView.delegate = self
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionNext))

        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext()  {
        if signatureView.getCroppedSignature()?.pngData() == nil {
            Modals.CreateAlert(title: "Error", message: "Please Put Your Signature Below", ViewController: self)
        } else {
            RappleActivityIndicatorView.startAnimating()
            let imgData: Data? = signatureView.getCroppedSignature()?.pngData()
            let encodedString = imgData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
            let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.view.window?.rootViewController = sw

            let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
           

            
            JobsheetInfoRequestModel.ProfessionalSignature = encodedString!
            let request = CustomerJobsheetInfoRequest()
            request.BookingId = JobsheetInfoRequestModel.getBookingId
            request.IdCardNo = Int(LoginUser.getIdCardNo)
            request.JSSignedBy = JobsheetInfoRequestModel.getJSSignedBy
            request.JSPosition = JobsheetInfoRequestModel.getJSPosition
            request.Comments = JobsheetInfoRequestModel.getComments
            request.IsFBNS = JobsheetInfoRequestModel.getIsFBNS
            request.ArriveOnTime = JobsheetInfoRequestModel.getArriveOnTime
            request.Intro = JobsheetInfoRequestModel.getIntro
            request.WearLECard = JobsheetInfoRequestModel.getWearLECard
            request.PreAssignment = JobsheetInfoRequestModel.getPreAssignment
            request.CustomerCare = JobsheetInfoRequestModel.getCustomerCare
            request.Dress = JobsheetInfoRequestModel.getDress
            request.Satisfied = JobsheetInfoRequestModel.getSatisfied
            request.ClientArrive = JobsheetInfoRequestModel.getClientArrive
            request.ArrivalTime = JobsheetInfoRequestModel.getArrivalTime
            request.StartTime = JobsheetInfoRequestModel.getStartTime
            request.WaitingTime = JobsheetInfoRequestModel.getWaitingTime
            request.BreakTime = JobsheetInfoRequestModel.getBreakTime
            request.IsNextDay = JobsheetInfoRequestModel.getIsNextDay
            request.FinishTime = JobsheetInfoRequestModel.getFinishTime
            request.ProfessionalSignature = JobsheetInfoRequestModel.ProfessionalSignature
            request.WantSameInterpreter = JobsheetInfoRequestModel.getWantSameInterpreter
            request.InterpreterArrived = JobsheetInfoRequestModel.getInterpreterArrived
            request.Miles = JobsheetInfoRequestModel.getMiles
            request.ReturnedHome = JobsheetInfoRequestModel.getReturnedHome
            request.StarRatingFromCustomer = JobsheetInfoRequestModel.getStarRatingFromCustomer
            ApiManager.api.CustomerJobsheetInfo(method: MethodTypes.Post.rawValue, url: ApiUrls.insertTempJobSheetInformation, request: request, viewController: self).done { response in
                if response.d.Status != false {
                    RappleActivityIndicatorView.stopAnimation()
                    //mainVC.modalPresentationStyle = .fullScreen
                    let ok = UIAlertAction(title: "OK", style: .default,handler: {
                        (action) in
                      //self.present(mainVC, animated: true, completion: nil)
                        sw.pushFrontViewController(newFrontViewController, animated: true)
                    })
                    ok.setValue(UIColor.systemBlue, forKey: "titleTextColor")
                    let alert = UIAlertController(title: "Successful", message: response.d.Message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                    RappleActivityIndicatorView.stopAnimation()
            }
         }
    }
    
   
    @IBAction func actionClear(_ sender: Any) {
        signatureView.clear()
    }
    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {    }    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {    }
}
