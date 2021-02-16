//
//  UploadJobsheetWizard7ViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 26/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import MobileCoreServices

class UploadJobsheetWizard7ViewController: BaseViewController {
    
   
    @IBOutlet weak var headInvoice: UILabel!
    @IBOutlet weak var headReceipt: UILabel!
    @IBOutlet weak var txtInvoice: customUITextField!
    @IBOutlet weak var txtReceipt: customUITextField!
    
    var btn:Int = 0
    
    public static var inoviceExt:String = ""
    public static var inovice64String:String = ""
    
    public static var receiptExt:String = ""
    public static var receipt64String:String = ""
   
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Upload Evidence"
        self.addBackButtonToNavigationBar()
        self.addrightBtnToNavigationBar()
        headInvoice.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headReceipt.textColor = UIColor.init(named: LoginUser.getThemeColor)

        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    @IBAction func actionInvoice(_ sender: Any) {
        self.btn = 0
        showFileAndImagePickerControllerActionSheet()
    }
    @IBAction func actionReceipt(_ sender: Any) {
        self.btn = 1
       showFileAndImagePickerControllerActionSheet()
    }
    override func addrightBtnToNavigationBar() {
        self.rightBarButton = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionNext))

        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    @objc func actionNext() {
        if(txtInvoice.text ?? "").isEmpty && (txtReceipt.text ?? "").isEmpty  {
            JobsheetInfoRequestModel.UploadYourInvoice = ""
            JobsheetInfoRequestModel.UploadPublicTransportReceipts = ""
            JobsheetInfoRequestModel.UploadPublicTransportReceiptsExt = ""
            JobsheetInfoRequestModel.UploadPublicTransportReceipts = ""
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard5ViewController") as! UploadJobsheetWizard5ViewController
            mainVC.modalPresentationStyle = .fullScreen
          self.navigationController?.pushViewController(mainVC, animated: true)
        }else{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"UploadJobsheetWizard5ViewController") as! UploadJobsheetWizard5ViewController
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }

    private func save(image: UIImage, name: String) -> String? {
        let fileName = "TheLinguistHub-\(name).jpeg"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            try? imageData.write(to: fileURL, options: .atomic)
            if self.btn == 0 {
                let encodedString = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                JobsheetInfoRequestModel.UploadYourInvoice = encodedString
                JobsheetInfoRequestModel.UploadYourInvoiceExt = ".jpeg"
            }else{
                let encodedString = imageData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                JobsheetInfoRequestModel.UploadPublicTransportReceipts = encodedString
                JobsheetInfoRequestModel.UploadPublicTransportReceiptsExt = ".jpeg"
            }
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
}

extension UploadJobsheetWizard7ViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if btn == 0 {
            let fileNameArr : [String]! = urls[0].absoluteString.components(separatedBy: "/")
            self.txtInvoice.text = fileNameArr[fileNameArr.count - 1]
            let fileExt : [String]! = urls[0].absoluteString.components(separatedBy: ".")
            JobsheetInfoRequestModel.UploadYourInvoiceExt = "." + fileExt[fileExt.count - 1]
            do{
                let filePath = urls[0].absoluteURL
                let fileData = try Data.init(contentsOf: filePath)
                let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                JobsheetInfoRequestModel.UploadYourInvoice = fileStream
            }catch {
                print("There is an error occured")
            }
        }else{
            let fileNameArr : [String]! = urls[0].absoluteString.components(separatedBy: "/")
            self.txtReceipt.text = fileNameArr[fileNameArr.count - 1]
            let fileExt : [String]! = urls[0].absoluteString.components(separatedBy: ".")
            JobsheetInfoRequestModel.UploadPublicTransportReceiptsExt = "." + fileExt[fileExt.count - 1]
            do{
                let filePath = urls[0].absoluteURL
                let fileData = try Data.init(contentsOf: filePath)
                let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                JobsheetInfoRequestModel.UploadPublicTransportReceipts = fileStream
            }catch {
                print("There is an error occured")
            }
        }        
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("User Cancelled")
    }
    
}
extension UploadJobsheetWizard7ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        if self.btn == 0 {
            txtInvoice.text = self.save(image: image!, name: "Invoice")
        }else{
             txtReceipt.text = self.save(image: image!, name: "Receipt")
        }
        dismiss(animated: true, completion: nil)
    }
}
