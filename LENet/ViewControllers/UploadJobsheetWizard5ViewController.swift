//
//  UploadJobsheetWizard5ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 12/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import SwiftSignatureView
import RappleProgressHUD
import SWRevealViewController
import Cosmos

class UploadJobsheetWizard5ViewController: BaseViewController, SwiftSignatureViewDelegate {
    @IBOutlet weak var btnMessage: UILabel!
    @IBOutlet weak var btnFinish: UIBarButtonItem!
    public var tempData = [TempDataItem]()
    public var professionalSignature:String! = ""
    @IBOutlet weak var headRating: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var signatureView: SwiftSignatureView!
    @IBOutlet weak var starRatingFromInterpreter: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Complete Jobsheet Info"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        self.loadTempData()
        headRating.textColor = UIColor.init(named: LoginUser.getThemeColor)
        btnMessage.textColor = UIColor.init(named: LoginUser.getThemeColor)
        btnFinish.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        btnClear.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        self.signatureView.delegate = self
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
 
       starRatingFromInterpreter.settings.fillMode = .full
        starRatingFromInterpreter.settings.updateOnTouch = true
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Finish", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionFinish))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionFinish()  {
        if signatureView.getCroppedSignature()?.pngData() == nil {
            Modals.CreateAlert(title: "Error", message: "Please Put Your Signature Below", ViewController: self)
        } else {
            RappleActivityIndicatorView.startAnimating()
            let imgData: Data? = signatureView.getCroppedSignature()?.pngData()
            let encodedString = imgData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            JobsheetInfoRequestModel.InterpreterSignature = encodedString!
            let request = UploadJobsheetInfoRequest()
            request.BookingId = tempData[0].bookingId
            request.IdCardNo = LoginUser.getIdCardNo.replacingOccurrences(of: " ", with: "")
            request.JSSignedBy = tempData[0].jSCompletedBy.replacingOccurrences(of: " ", with: "")
            request.JSPosition = tempData[0].jSCompletedPosition.replacingOccurrences(of: " ", with: "")
            request.Comments = tempData[0].comments.replacingOccurrences(of: " ", with: "")
            request.IsFBNS = tempData[0].qFSubmitted
            request.ArriveOnTime = tempData[0].arriveOnTime.replacingOccurrences(of: " ", with: "")
            request.Intro = tempData[0].introduceThemselves.replacingOccurrences(of: " ", with: "")
            request.WearLECard = tempData[0].wearLECard.replacingOccurrences(of: " ", with: "")
            request.PreAssignment = tempData[0].preAssignmentBriefing.replacingOccurrences(of: " ", with: "")
            request.CustomerCare = tempData[0].showGoodCustomerCare.replacingOccurrences(of: " ", with: "")
            request.Dress = tempData[0].dressAppropriately.replacingOccurrences(of: " ", with: "")
            request.Satisfied = tempData[0].howSatisfied.trimmingCharacters(in: .whitespacesAndNewlines)
            request.ClientArrive = tempData[0].didPatientArrive.replacingOccurrences(of: " ", with: "")
            request.ArrivalTime = tempData[0].arrivalTime.replacingOccurrences(of: " ", with: "")
            request.StartTime = tempData[0].startTime.replacingOccurrences(of: " ", with: "")
            request.WaitingTime = tempData[0].waitingTime.replacingOccurrences(of: " ", with: "")
            request.BreakTime = tempData[0].breakTime.replacingOccurrences(of: " ", with: "")
            request.IsNextDay = tempData[0].isNextDay
            request.FinishTime = tempData[0].finishTime.replacingOccurrences(of: " ", with: "")
            request.Mileage = JobsheetInfoRequestModel.getMileage.replacingOccurrences(of: " ", with: "")
            request.TravelTime = JobsheetInfoRequestModel.getTravelTime.replacingOccurrences(of: " ", with: "")
            request.PublicTransportCost = JobsheetInfoRequestModel.getPublicTransportCost.replacingOccurrences(of: " ", with: "")
            request.OtherExpenses = JobsheetInfoRequestModel.getOtherExpenses.replacingOccurrences(of: " ", with: "")
            request.ProfessionalSignature = self.professionalSignature
            request.InterpreterSignature = JobsheetInfoRequestModel.InterpreterSignature
            request.WantSameInterpreter = tempData[0].sameInterpreterFollowUp.replacingOccurrences(of: " ", with: "")
            request.InterpreterArrived = tempData[0].interpreterArrived.replacingOccurrences(of: " ", with: "")
            request.Miles = tempData[0].miles.replacingOccurrences(of: " ", with: "")
            request.ReturnedHome = JobsheetInfoRequestModel.getReturnedHome.replacingOccurrences(of: " ", with: "")
            request.TyneTunnel = JobsheetInfoRequestModel.TyneTunnel
            request.UploadYourInvoice = JobsheetInfoRequestModel.UploadYourInvoice
            request.UploadYourInvoiceExt = JobsheetInfoRequestModel.UploadYourInvoiceExt
            request.UploadPublicTransportReceipts = JobsheetInfoRequestModel.UploadPublicTransportReceipts
            request.UploadPublicTransportReceiptsExt = JobsheetInfoRequestModel.UploadPublicTransportReceiptsExt
            request.StarRatingFromCustomer = tempData[0].starRatingFromCustomer.replacingOccurrences(of: " ", with: "")
            request.StarRatingFromInterpreter = String(Int(starRatingFromInterpreter.rating)).replacingOccurrences(of: " ", with: "")
            ApiManager.api.UploadJobsheetInfo(method: MethodTypes.Post.rawValue, url: ApiUrls.uploadJobSheetInformation, request: request, viewController: self).done { response in
                if response.d.Status != false {
                    self.SuccessModal(message: response.d.Message, base64String: response.d.Data)
                    RappleActivityIndicatorView.stopAnimation()
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
  
    
    func loadTempData(){
        let request = GetTempDataRequest()
        request.BookingId = JobsheetInfoRequestModel.getBookingId
        ApiManager.api.GetTempData(method: MethodTypes.Post.rawValue, url: ApiUrls.getDisplayTempUploadJobSheet, request: request, viewController: self).done { response in
            if response.d.Status != false && response.d.Data != nil {
                self.tempData = response.d.JobSheetList
                self.professionalSignature = response.d.Data
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "Error!", message: error.localizedDescription, ViewController: self)
        }
    }

    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {    }
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {    }
    func SuccessModal(message: String, base64String:String){
        let download = UIAlertAction(title: "Download & Open Jobsheet", style: .default,handler: {
            (action) in
            guard
                var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
                let convertedData = Data(base64Encoded: base64String)
                else {
                    return
            }
            documentsURL.appendPathComponent("\(JobsheetInfoRequestModel.getBookingId).pdf")
            do {
                try convertedData.write(to: documentsURL)
            } catch {
            }
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"PDFViewController") as! PDFViewController
            mainVC.modalPresentationStyle = .fullScreen
            PDFViewController.pdfUrl = documentsURL
            PDFViewController.check = "1"
           // self.present(mainVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(mainVC, animated: true)
        })
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
            (action) in
            /*
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(mainVC, animated: true, completion: nil)
            */
            let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.view.window?.rootViewController = sw

            let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            sw.pushFrontViewController(newFrontViewController, animated: true)
            
            
            
        })
        download.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        dismiss.setValue(UIColor.red, forKey: "titleTextColor")
        let alert = UIAlertController(title: "Successfull !!!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(download)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
}
