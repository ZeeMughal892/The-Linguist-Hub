

import UIKit

class AlertsViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
  
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Alerts"
        self.addBackButtonToNavigationBar()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named:LoginUser.getThemeColor) ]
               navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertsTableViewCell", for: indexPath) as! AlertsTableViewCell
        cell.lblTitle.text = LoginUser.noticeBoardTitle
        cell.lblTime.text  = "2 days ago"
        cell.imgAlert.image = UIImage(named: "ImgSplashLogo")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:AlertsTableViewCell = tableView.cellForRow(at: indexPath) as! AlertsTableViewCell
        if cell.lblTitle.text! == LoginUser.getNoticeBoardTitle
        {
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
            self.present(alert, animated: true, completion: nil)}
    }
   
}
