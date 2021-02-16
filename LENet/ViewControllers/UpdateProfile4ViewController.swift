//
//  UpdateProfile4ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 20/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import SWRevealViewController
import MobileCoreServices
import RappleProgressHUD
import Photos

class UpdateProfile4ViewController: BaseViewController, UITextFieldDelegate {
    
  
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtAddress3: UITextField!
    @IBOutlet weak var txtAddress4: UITextField!
    @IBOutlet weak var txtPostCode: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtFilename: UITextField!
    @IBOutlet weak var btnSelectFile: UIButton!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var headAddress1: UILabel!
    @IBOutlet weak var headAddress2: UILabel!
    @IBOutlet weak var headAddress3: UILabel!
    @IBOutlet weak var headAddress4: UILabel!
    @IBOutlet weak var headPostcode: UILabel!
    @IBOutlet weak var headCounty: UILabel!
    @IBOutlet weak var headCountry: UILabel!
    @IBOutlet weak var headProof: UILabel!
    
    var textView = UITextView(frame: CGRect.zero)
    
    public static var addressExt:String = ""
    public static var address64String:String = ""
    
    public static var firstName:String = ""
    public static var lastName:String = ""
    public static var profileImage:String = ""
    
    public static var nameExt:String = ""
    public static var name64String:String = ""
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var check:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeyboard()
        
        headAddress1.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headAddress2.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headAddress3.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headAddress4.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headPostcode.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headCounty.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headCountry.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headProof.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        self.title = "Address Update"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        txtAddress1.text = LoginUser.getAddressLine1
        txtAddress2.text = LoginUser.getAddressLine2
        txtAddress3.text = LoginUser.getAddressLine3
        txtAddress4.text = LoginUser.getAddressLine4
        txtPostCode.text = LoginUser.getPostcode
        txtCounty.text = LoginUser.getCounty
        txtCountry.text = LoginUser.getCountry
        
        txtAddress1.delegate = self
        txtAddress2.delegate = self
        txtAddress3.delegate = self
        txtAddress4.delegate = self
        txtPostCode.delegate = self
        txtCounty.delegate = self
        txtCountry.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionSkip))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionSkip(){
        /*
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC,animated:true,completion:nil)
 */
        //self.navigationController?.pushViewController(mainVC, animated: true)
        let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.view.window?.rootViewController = sw

        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        sw.pushFrontViewController(newFrontViewController, animated: true)
        
        
    }
   
    @IBAction func actionSelectFile(_ sender: Any) {
        showFileAndImagePickerControllerActionSheet()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 200
            }
        }
    }
    private func save(image: UIImage) -> String? {
        let fileName = "TheLinguistHub-\(LoginUser.getIdCardNo).jpeg"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            try? imageData.write(to: fileURL, options: .atomic)
            let encodedString = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            UpdateProfile4ViewController.address64String = encodedString
            UpdateProfile4ViewController.addressExt = ".jpeg"
            return fileName // ----> Save fileName
        }        
        print("Error saving image")
        return nil
    }
    private func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func actionFinish(_ sender: Any) {
        if(self.txtAddress1.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 1" , ViewController: self)
            self.txtAddress1.becomeFirstResponder()
        }else if (self.txtAddress2.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 2" , ViewController: self)
            self.txtAddress2.becomeFirstResponder()
        }else if(self.txtAddress3.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 3" , ViewController: self)
            self.txtAddress3.becomeFirstResponder()
        }else if(self.txtAddress4.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Address Line 4" , ViewController: self)
            self.txtAddress4.becomeFirstResponder()
        }else if(self.txtPostCode.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Post Code" , ViewController: self)
            self.txtPostCode.becomeFirstResponder()
        }else if(self.txtCounty.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter County" , ViewController: self)
            self.txtCounty.becomeFirstResponder()
        }else if(self.txtCountry.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Country" , ViewController: self)
            self.txtCountry.becomeFirstResponder()
        }else if self.txtAddress1.text == LoginUser.getAddressLine1  &&
            self.txtAddress2.text == LoginUser.getAddressLine2 &&
            self.txtAddress3.text == LoginUser.getAddressLine3 &&
            self.txtAddress4.text == LoginUser.getAddressLine4 &&
            self.txtPostCode.text == LoginUser.getPostcode &&
            self.txtCounty.text == LoginUser.getCounty &&
            self.txtCountry.text == LoginUser.getCountry{
            Modals.CreateAlert(title: "", message:"You have entered old address. Please enter different address" , ViewController: self)
        }else if self.txtAddress1.text == LoginUser.getAddressLine1  ||
            self.txtAddress2.text == LoginUser.getAddressLine2 ||
            self.txtAddress3.text == LoginUser.getAddressLine3 ||
            self.txtAddress4.text == LoginUser.getAddressLine4 ||
            self.txtPostCode.text == LoginUser.getPostcode ||
            self.txtCounty.text == LoginUser.getCounty ||
            self.txtCountry.text == LoginUser.getCountry {
            
            if (self.txtFilename.text ?? "").isEmpty{
                Modals.CreateAlert(title: "", message:"Please select proof of address change" , ViewController: self)
            }else{
                let alert = UIAlertController(title: "Profile Update", message: "Request here if you want to update your profile information", preferredStyle: UIAlertController.Style.alert)
                textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
                textView.backgroundColor = UIColor.systemBackground
                let send = UIAlertAction(title: "Send", style: .default,handler: {
                    (action) in
                    RappleActivityIndicatorView.startAnimating()
                    let request = UpdateNameAddressRequest()
                    request.IDCardNo = LoginUser.getIdCardNo
                    request.FirstName = UpdateProfile4ViewController.firstName
                    request.LastName = UpdateProfile4ViewController.lastName
                    request.ProfileImage = UpdateProfile4ViewController.profileImage
                    request.AddressLine1 = self.txtAddress1.text
                    request.AddressLine2 = self.txtAddress2.text
                    request.AddressLine3 = self.txtAddress3.text
                    request.AddressLine4 = self.txtAddress4.text
                    request.UserPostCode = self.txtPostCode.text
                    request.County = self.txtCounty.text
                    request.Country = self.txtCountry.text
                    request.NameProofFile = UpdateProfile4ViewController.name64String
                    request.NameProofFileExt = UpdateProfile4ViewController.nameExt
                    request.AddressProofFile = UpdateProfile4ViewController.address64String
                    request.AddressProofFileExt = UpdateProfile4ViewController.addressExt
                    request.Reason = self.textView.text
                    
                    ApiManager.api.UpdateNameAddress(method: MethodTypes.Post.rawValue, url: ApiUrls.UpdateNameAddress, request: request, viewController: self).done { response in
                        if response.d.Status != false {
                            let alertSuccess = UIAlertController(title: "Profile Update Successful", message: response.d.Message, preferredStyle: UIAlertController.Style.alert)
                            let OK = UIAlertAction(title: "OK", style: .default,handler: {
                                                        (action) in
                                /*
                                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SWRevealViewController") as! SWRevealViewController
                                mainVC.modalPresentationStyle = .fullScreen
                                self.present(mainVC,animated:true,completion:nil)
 */
                                let sw = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                self.view.window?.rootViewController = sw

                                let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let desController = mainStroyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                                let newFrontViewController = UINavigationController.init(rootViewController:desController)
                                sw.pushFrontViewController(newFrontViewController, animated: true)
                                
                            })
                            alertSuccess.addAction(OK)
                            self.present(alertSuccess, animated: true, completion: nil)
                            RappleActivityIndicatorView.stopAnimation()
                        }
                        else{
                            Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                            RappleActivityIndicatorView.stopAnimation()
                        }
                    }.catch
                        {
                            error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                            RappleActivityIndicatorView.stopAnimation()
                    }
                })
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                send.setValue(UIColor.init(named: "colorLeftMenu"), forKey: "titleTextColor")
                cancel.setValue(UIColor.red, forKey: "titleTextColor")
                send.isEnabled = false
                alert.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
                NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: OperationQueue.main) { (notification) in
                    send.isEnabled = self.textView.text != ""
                }
                alert.view.addSubview(self.textView)
                alert.addAction(send)
                alert.addAction(cancel)
                let device = UIDevice.modelName
                if(device == "iPhone 6" ||
                    device == "iPhone 6s" ||
                    device == "Simulator iPhone 6s" ||
                    device == "Simulator iPhone 8" ||
                    device == "iPhone 7" ||
                    device == "iPhone 8" ||
                    device == "iPhone SE")
                {
                    let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.31)
                    alert.view.addConstraint(height);
                }else{
                    let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.23)
                    alert.view.addConstraint(height);
                }
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin:CGFloat = 84.0
                let marginLR:CGFloat = 8.0
                textView.frame = CGRect.init(x: rect.origin.x + marginLR, y: rect.origin.y + margin, width: rect.width - 2 * marginLR, height: rect.height / 3)
                textView.bounds = CGRect.init(x: rect.origin.x + marginLR, y: rect.origin.y + margin, width: rect.width - 2 * marginLR, height: rect.height / 3)
            }
        }
    }
}



extension UpdateProfile4ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showFileAndImagePickerControllerActionSheet(){
        let storageAction = UIAlertAction(title: "Choose From Storage", style: .default, handler: {(action) in
            let documentPicker = UIDocumentPickerViewController(documentTypes: [(kUTTypeJPEG as String),(kUTTypePNG as String),(kUTTypePDF as String),(kUTTypeText as String),(kUTTypeImage as String)], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            documentPicker.shouldShowFileExtensions = true
            self.present(documentPicker, animated:true, completion:nil)
        })
        let cameraAction = UIAlertAction(title: "Take From Camera", style: .default, handler: {(action) in
            self.showImagePickerController(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        Modals.showAlertWithActions(style: .alert, title: "Choose your Proof File", message: nil, actions: [storageAction,cameraAction,cancelAction], completion: nil, ViewController: self)
    }
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        txtFilename.text = self.save(image: image!)        
        dismiss(animated: true, completion: nil)
    }
}


extension UpdateProfile4ViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileNameArr : [String]! = urls[0].absoluteString.components(separatedBy: "/")
        self.txtFilename.text = fileNameArr[fileNameArr.count - 1]
        let fileExt : [String]! = urls[0].absoluteString.components(separatedBy: ".")
        UpdateProfile4ViewController.addressExt = "." + fileExt[fileExt.count - 1]
        do{
            let filePath = urls[0].absoluteURL
            let fileData = try Data.init(contentsOf: filePath)
            let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            UpdateProfile4ViewController.address64String = fileStream
        }catch {
            print("There is an error occured")
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("User Cancelled")
    }
}
