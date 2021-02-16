

import UIKit

import SWRevealViewController

class BaseViewController: UIViewController {

    var leftBarButton : UIBarButtonItem?
    
    var rightBarButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func setupColorNavBar(){
        if let font = UIFont(name: "Roboto-Regular", size: 20){
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor:UIColor.white]
            self.navigationController?.navigationBar.barStyle = .black
        }
        
        UIApplication.shared.statusBarStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 51.0/255.0, green: 141.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = nil
    }

    func setupTransparentNavBar(){
        if let font = UIFont(name: "Roboto-Regular", size: 18){
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor:UIColor.white]
            self.navigationController?.navigationBar.barStyle = .default
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        //        self.navigationController?.navigationBar.barTintColor = UIColor.red //UIColor(red: 189.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.black
            
        self.navigationItem.leftBarButtonItem = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addBackButtonToNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.leftBarButton =  UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }

    
    func addMenuButtonToNavigationBar(){
        self.leftBarButton =  UIBarButtonItem(image: UIImage.init(named: "IcoMenu"), style: UIBarButtonItem.Style.plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
     
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }

    func addrightBtnToNavigationBar()  {
        
        self.rightBarButton =  UIBarButtonItem(image: UIImage.init(named: "ic_left_nav"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showSideMenu))
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
        
    }
    
 
    

    
    @objc func goBack(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showSideMenu(){
        //self.navigationController?.pushViewController(SettingVC(), animated: true)
        //self.sideMenuViewController.presentLeftMenuViewController()
       
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

}

