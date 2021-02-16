//
//  AllBookingsViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 30/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import RappleProgressHUD
enum selectedScope:Int {
    case title = 0
    case reference = 1
    case date = 2
}
class AllBookingsViewController: BaseViewController {
    
    @IBOutlet weak var tableViewMax: NSLayoutConstraint!
    @IBOutlet weak var stackViewMax: NSLayoutConstraint!
    @IBOutlet weak var tableViewFull: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalHours: UILabel!
    let searchController = UISearchController(searchResultsController: nil)
    
    public var lstBookings  : [AllBookings] = []
    public var lstFilteredBookings : [AllBookings] = []
    
    public var lstComplaints  : [Compliant] = []
    public var lstFilteredComplaints  : [Compliant] = []
    
    
    public static var placeholderImage:UIImage!
    public static var placeholderTitle:String!
    
    var totalHours = 0
    public static var headTitle :String!
    public static var Title :String!
    public static var type :String!
    
    public static var dateFrom:String = ""
    public static var dateTo:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  = "Bookings"
        self.addBackButtonToNavigationBar()
        loadAllBookings()
        
        self.HideKeyboard()
        
        self.title = AllBookingsViewController.headTitle
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: LoginUser.getThemeColor) ]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.scopeButtonTitles = ["Title", "Reference","Date"]
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(named: LoginUser.getThemeColor)
        searchController.searchBar.selectedScopeButtonIndex = 0
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        
    }    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    @IBAction func actionFilter(_ sender: Any) {
        FilterAlertView.instance.showAlert()
    }
  
    func loadAllBookings(){
        RappleActivityIndicatorView.startAnimating()
        let request = AllBookingsRequest()
        request.IdCardNo = LoginUser.getIdCardNo
        request.Title = AllBookingsViewController.Title
        request.type = AllBookingsViewController.type
        ApiManager.api.AllBookings(method: MethodTypes.Post.rawValue, url: ApiUrls.allBookings, request: request, viewController: self).done { response in
            if response.d.BookingList != nil && response.d.BookingList.count != 0  {
                self.lstBookings.append(contentsOf: response.d.BookingList)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }else if response.d.BookingLateList != nil && response.d.BookingLateList.count != 0  {
                self.lstBookings.append(contentsOf: response.d.BookingLateList)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }else if response.d.BookingDnaList != nil && response.d.BookingDnaList.count != 0  {
                self.lstBookings.append(contentsOf: response.d.BookingDnaList)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }else if response.d.CompliantList != nil && response.d.CompliantList.count != 0  {
                self.lstComplaints.append(contentsOf: response.d.CompliantList)
                RappleActivityIndicatorView.stopAnimation()
                self.tableView.reloadData()
            }else{
                self.setupEmptyBackgroundView()
                RappleActivityIndicatorView.stopAnimation()
            }
        }.catch
            {
                error in Modals.CreateAlert(title: "", message: error.localizedDescription, ViewController: self)
        }
    }
    
    func setupEmptyBackgroundView() {
        let image = AllBookingsViewController.placeholderImage.withRenderingMode(.alwaysTemplate)
        let topMessage = AllBookingsViewController.placeholderTitle!
        let bottomMessage = "You don't have any \(AllBookingsViewController.placeholderTitle!). All your \(AllBookingsViewController.placeholderTitle!) will show up here."
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        self.tableView.backgroundView = emptyBackgroundView
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    func filterTableView(scope:Int, text: String) {
        switch scope {
        case selectedScope.title.rawValue:
            lstFilteredBookings = lstBookings.filter({(bookings: AllBookings) -> Bool in
                return bookings.description.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.reference.rawValue:
            lstFilteredBookings = lstBookings.filter({(bookings: AllBookings) -> Bool in
                return bookings.bookingRef.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.date.rawValue:
            lstFilteredBookings = lstBookings.filter({(bookings: AllBookings) -> Bool in
                return bookings.appointmentDateTimeUkFormatted.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print(scope)
        }
    }    
}
extension AllBookingsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            lstFilteredBookings = lstBookings
            self.tableView.reloadData()
        }else{
            filterTableView(scope: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
}
extension AllBookingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering && lstBookings.count != 0 {
            return lstFilteredBookings.count
        }else if !isFiltering && lstBookings.count != 0 {
             return lstBookings.count
        }else if isFiltering && lstComplaints.count != 0{
            return lstFilteredComplaints.count
        }else{
            return lstComplaints.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if AllBookingsViewController.Title == "Hour" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalHoursTableViewCell") as! TotalHoursTableViewCell
            if isFiltering {
                let filteredBooking = lstFilteredBookings[indexPath.row]
                cell.setDetails(booking: filteredBooking)
                //lblTotalHours.text = " " + String(CalculateTotalHours(lstBookings: lstFilteredBookings)) + " Hours"
            }else{
                let booking = lstBookings[indexPath.row]
                cell.setDetails(booking: booking)
                //lblTotalHours.text = " " + String(CalculateTotalHours(lstBookings: lstBookings)) + " Hours"
            }
            cell.imgRight.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            //stackViewMax.isActive = true
            //tableViewMax.isActive = true
            //tableViewFull.isActive = false
            
            cell.selectedBackgroundView = UIView()
            return cell
        }
        else if AllBookingsViewController.Title == "Complaint" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsTableViewCell") as! ComplaintsTableViewCell
            if isFiltering {
                let filteredComplaint = lstFilteredComplaints[indexPath.row]
                cell.setDetails(complaint: filteredComplaint)
            }else{
                let complaint = lstComplaints[indexPath.row]
                cell.setDetails(complaint: complaint)
            }
            //stackViewMax.isActive = false
            //tableViewMax.isActive = false
            //tableViewFull.isActive = true
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllBookingsTableViewCell") as! AllBookingsTableViewCell
            if isFiltering {
                let filteredBooking = lstFilteredBookings[indexPath.row]
                cell.setDetails(booking: filteredBooking)
            }else{
                let booking = lstBookings[indexPath.row]
                cell.setDetails(booking: booking)
            }
            stackViewMax.isActive = false
            tableViewMax.isActive = false
            tableViewFull.isActive = true
            cell.imgRight.tintColor = UIColor.init(named: LoginUser.getThemeColor)
            cell.lblDesc.textColor = UIColor.init(named: LoginUser.getThemeColor)
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
            cell.selectedBackgroundView = UIView()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if AllBookingsViewController.Title == "Complaint"{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"ComplaintDetailsViewController") as! ComplaintDetailsViewController
            ComplaintDetailsViewController.complaintItem = lstComplaints[indexPath.row]
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else{
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier:"SearchBookingDetailsViewController") as! SearchBookingDetailsViewController
            SearchBookingDetailsViewController.bookingItem = lstBookings[indexPath.row]
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    func CalculateTotalHours(lstBookings: [AllBookings]) -> Int{
        for i in 0...lstBookings.count-1{
            totalHours += lstBookings[i].actualInterpreterTime
        }
        return totalHours/60
    }
}
