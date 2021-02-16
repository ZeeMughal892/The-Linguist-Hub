//
//  UpdateProfile1ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 19/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import Kingfisher
import MobileCoreServices
import Photos

class UpdateProfile1ViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var headFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var headLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFilename: UITextField!
    @IBOutlet weak var btnSelectFile: UIButton!
    @IBOutlet weak var headProof: UILabel!
    @IBOutlet weak var btnNext: UIButton!

    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var check:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeyboard()
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        
        headerView.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        headProof.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headFirstName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headLastName.textColor = UIColor.init(named: LoginUser.getThemeColor)
        self.title = "Personal Infromation"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        
        
        
        txtFirstName.text =  LoginUser.getFirstName
        txtLastName.text = LoginUser.getLastName
        let str = ApiUrls.imgProfile + LoginUser.profileImage
        let url = URL(string: str)!
        
        let resource = ImageResource(downloadURL: url, cacheKey: str)
        self.imgProfile.kf.setImage(with: resource)
        
//        let device = UIDevice.modelName
//        if device == "Simulator iPhone 6s"  ||
//            device == "Simulator iPhone 8"  ||
//            device == "iPhone 6" ||
//            device == "iPhone 6s" ||
//            device == "iPhone 7" ||
//            device == "iPhone 8" {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 54
//            imgProfile.clipsToBounds = true
//        }else if device == "Simulator iPhone 6s Plus" ||
//            device == "Simulator iPhone 8 Plus" ||
//            device == "iPhone 6 Plus" ||
//            device == "iPhone 6s Plus" ||
//            device == "iPhone 7 Plus" ||
//            device == "iPhone 8 Plus"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 60
//            imgProfile.clipsToBounds = true
//        }else if device == "Simulator iPhone 11 Pro" ||
//            device == "iPhone 11 Pro" ||
//            device == "iPhone XS"  ||
//            device == "iPhone X"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 56
//            imgProfile.clipsToBounds = true
//        }else if device == "Simulator iPhone 11" ||
//            device == "iPhone 11" ||
//            device == "iPhone XR"  {
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 64
//            imgProfile.clipsToBounds = true
//        }
//        else if device == "Simulator iPhone 11 Pro Max" ||
//            device == "iPhone 11 Pro Max" ||
//            device == "iPhone XS Max"{
//            imgProfile.layer.borderWidth = 5.0
//            imgProfile.layer.masksToBounds = false
//            imgProfile.layer.borderColor = UIColor.white.cgColor
//            imgProfile.layer.cornerRadius = 75
//            imgProfile.clipsToBounds = true
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
               navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.layer.borderWidth = 5.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds = true
    }
    @IBAction func actionSelectImage(_ sender: Any) {
            check = "1"
           showImagePickerControllerActionSheet()
    }
    
    @IBAction func actionSelectFile(_ sender: Any) {
        check = "2"
        self.showFileAndImagePickerControllerActionSheet()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 50 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
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
    private func save(image: UIImage) -> String? {
        let fileName = "TheLinguistHub-\(LoginUser.getIdCardNo).jpeg"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 0.5) {
           try? imageData.write(to: fileURL, options: .atomic)
            let encodedString = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            UpdateProfile4ViewController.name64String = encodedString
            UpdateProfile4ViewController.nameExt = ".jpeg"
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
    
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionSkip))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionSkip(){
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile2ViewController") as! UpdateProfile2ViewController
        mainVC.modalPresentationStyle = .fullScreen
        //self.present(mainVC,animated:true,completion:nil)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    @IBAction func actionNext(_ sender: Any) {
        if(self.txtFirstName.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter First Name" , ViewController: self)
            self.txtFirstName.becomeFirstResponder()
        }else if (self.txtLastName.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please Enter Last Name" , ViewController: self)
            self.txtLastName.becomeFirstResponder()
        }else if UpdateProfile4ViewController.profileImage.isEmpty {
            if self.txtFirstName.text == LoginUser.getFirstName && self.txtLastName.text == LoginUser.getLastName {
                Modals.CreateAlert(title: "", message:"You have entered the Old First and Last Names. Please enter new ones" , ViewController: self)
            } 
            else if self.txtFirstName.text != LoginUser.getFirstName || self.txtLastName.text != LoginUser.getLastName{
                if (self.txtFilename.text ?? "").isEmpty{
                    Modals.CreateAlert(title: "", message:"Please select proof of name change" , ViewController: self)
                }else {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile2ViewController") as! UpdateProfile2ViewController
                    UpdateProfile4ViewController.firstName = txtFirstName.text!
                    UpdateProfile4ViewController.lastName = txtLastName.text!
                    mainVC.modalPresentationStyle = .fullScreen
                    //self.present(mainVC,animated:true,completion:nil)
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            }
        } else if !UpdateProfile4ViewController.profileImage.isEmpty {          
            if self.txtFirstName.text != LoginUser.getFirstName || self.txtLastName.text != LoginUser.getLastName{
                if (self.txtFilename.text ?? "").isEmpty{
                    Modals.CreateAlert(title: "", message:"Please select proof of name change" , ViewController: self)
                }else {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile2ViewController") as! UpdateProfile2ViewController
                    UpdateProfile4ViewController.firstName = txtFirstName.text!
                    UpdateProfile4ViewController.lastName = txtLastName.text!
                    mainVC.modalPresentationStyle = .fullScreen
                    //self.present(mainVC,animated:true,completion:nil)
                    self.navigationController?.pushViewController(mainVC, animated: true)
                }
            }else {
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile2ViewController") as! UpdateProfile2ViewController
                UpdateProfile4ViewController.firstName = txtFirstName.text!
                UpdateProfile4ViewController.lastName = txtLastName.text!
                mainVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        } else{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdateProfile2ViewController") as! UpdateProfile2ViewController
            UpdateProfile4ViewController.firstName = txtFirstName.text!
            UpdateProfile4ViewController.lastName = txtLastName.text!
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }

}
extension UpdateProfile1ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerControllerActionSheet(){
        let photoLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: {(action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        })
        let cameraAction = UIAlertAction(title: "Take From Camera", style: .default, handler: {(action) in
            self.showImagePickerController(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        Modals.showAlertWithActions(style: .alert, title: "Choose your Image", message: nil, actions: [photoLibraryAction,cameraAction,cancelAction], completion: nil, ViewController: self)
    }
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
        if check == "1" {
            imgProfile.image = image
        }else {
            txtFilename.text = self.save(image: image!)
        }        
        dismiss(animated: true, completion: nil)
    }
}

extension UpdateProfile1ViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileNameArr : [String]! = urls[0].absoluteString.components(separatedBy: "/")
        self.txtFilename.text = fileNameArr[fileNameArr.count - 1]
        let fileExt : [String]! = urls[0].absoluteString.components(separatedBy: ".")
        UpdateProfile4ViewController.nameExt = "." + fileExt[fileExt.count - 1]
        
        do{
            let filePath = urls[0].absoluteURL
            let fileData = try Data.init(contentsOf: filePath)
            let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            UpdateProfile4ViewController.name64String = fileStream
        }catch {
             print("There is an error occured")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("User Cancelled")
    }
}
