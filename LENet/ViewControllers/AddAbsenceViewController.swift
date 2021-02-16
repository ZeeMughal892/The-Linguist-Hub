

import UIKit
import RappleProgressHUD
import LabelSwitch

class AddAbsenceViewController: BaseViewController {
    @IBOutlet weak var lblMessge: UILabel!
    
    @IBOutlet weak var txtStartDate: customUITextField!
    @IBOutlet weak var txtFinishDate: customUITextField!
    @IBOutlet weak var txtReason: customUITextView!
    @IBOutlet weak var headStart: UILabel!
    @IBOutlet weak var headFinish: UILabel!
    @IBOutlet weak var headCanContact: UILabel!
    @IBOutlet weak var headReason: UILabel!

   // @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIButton!
    public static var AVC : AbsenceViewController!
    let startDatePicker = UIDatePicker()
    let finishDatePicker = UIDatePicker()
    var labelSwitch = LabelSwitch()
    @IBOutlet weak var viewSwitch: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButtonToNavigationBar()
        let ls = LabelSwitchConfig(text: "YES",
                                   textColor: .systemBackground,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: UIColor.init(named: LoginUser.getThemeColor)!)
        
        let rs = LabelSwitchConfig(text: "NO",
                                   textColor: UIColor.init(named: LoginUser.getThemeColor)!,
                                   font: UIFont.boldSystemFont(ofSize: 12),
                                   backgroundColor: .systemBackground)
        
        labelSwitch = LabelSwitch(center: .init(x: 28, y: 15), leftConfig: ls, rightConfig: rs)
        labelSwitch.circleShadow = true
        
        labelSwitch.fullSizeTapEnabled = true
        labelSwitch.layer.borderWidth = 1.0
        labelSwitch.layer.borderColor = UIColor.init(named: LoginUser.getThemeColor)?.cgColor
        
        labelSwitch.delegate = self
        viewSwitch.addSubview(labelSwitch)
        self.HideKeyboard()
        
        lblMessge.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headStart.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headFinish.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headCanContact.textColor = UIColor.init(named: LoginUser.getThemeColor)
        headReason.textColor = UIColor.init(named: LoginUser.getThemeColor)
        
        
        btnSave.backgroundColor = UIColor.init(named: LoginUser.getThemeColor)
        
        self.showStartDatePicker()
        self.showFinishDatePicker()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
   
    override func addBackButtonToNavigationBar() {
        self.leftBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    @objc func cancelAction()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func actionSave(_ sender: Any) {
        if(txtStartDate.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please enter start date" , ViewController: self)
            self.txtStartDate.becomeFirstResponder()
        }else if(txtFinishDate.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please enter finish date" , ViewController: self)
            self.txtFinishDate.becomeFirstResponder()
        }else if(txtReason.text ?? "").isEmpty{
            Modals.CreateAlert(title: "", message:"Please enter reason of absence" , ViewController: self)
            self.txtReason.becomeFirstResponder()
        }else{
            RappleActivityIndicatorView.startAnimating()
            let request = CreateAbsenceRequest()
            request.idCardNo = LoginUser.getIdCardNo
            request.dateFrom = txtStartDate.text!
            request.dateTo = txtFinishDate.text!
            request.reason = txtReason.text!
            if self.labelSwitch.curState == .R{
                request.inContact = true
            }else{
                request.inContact = false
            }
            ApiManager.api.CreateAbsence(method: MethodTypes.Post.rawValue, url: ApiUrls.createAbsence, request: request, viewController: self).done { response in
                if response.d.Status != false{
                    RappleActivityIndicatorView.stopAnimation()
                    AbsenceViewController.absenceItems.removeAll()
                    AbsenceViewController.absenceItems.append(contentsOf: response.d.List)
                    AddAbsenceViewController.AVC.tableView.reloadData()
                    AddAbsenceViewController.AVC.tableView.backgroundView = UIView()
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    Modals.CreateAlert(title: "", message: response.d.Message, ViewController: self)
                    self.dismiss(animated: true, completion: nil)
                    RappleActivityIndicatorView.stopAnimation()
                }
            }.catch
                {
                    error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
                    self.dismiss(animated: true, completion: nil)
                    RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
    @IBAction func actionCanContact(_ sender: Any) {
    }
    
    func showStartDatePicker(){
        startDatePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartDatePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtStartDate.inputAccessoryView = toolbar
        txtStartDate.inputView = startDatePicker
    }
    @objc func doneStartDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        txtStartDate.text = formatter.string(from: startDatePicker.date)
        self.view.endEditing(true)
    }
    
    func showFinishDatePicker(){
        finishDatePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneFinishDatePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtFinishDate.inputAccessoryView = toolbar
        txtFinishDate.inputView = finishDatePicker
    }
    @objc func doneFinishDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        txtFinishDate.text = formatter.string(from: finishDatePicker.date)
        self.view.endEditing(true)
    }
    
}

extension AddAbsenceViewController : LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        switch sender.curState {
        case .L:
          print("OFF")
        case .R:
            print("On")
        }
    }
}
