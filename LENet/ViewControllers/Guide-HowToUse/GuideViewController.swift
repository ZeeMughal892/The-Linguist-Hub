//
//  GuideViewController.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 26/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
    var tabs = [
        ViewPagerTab(title: "", image: UIImage(named: "")),
        ViewPagerTab(title: "", image: UIImage(named: "")),
        ViewPagerTab(title: "", image: UIImage(named: "")),
        ViewPagerTab(title: "", image: UIImage(named: ""))
    ]
    
    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    @IBOutlet weak var pageController: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        options = ViewPagerOptions(viewPagerWithFrame: self.view.bounds)
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        self.addChild(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParent: self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        options.viewPagerFrame = self.view.bounds
    }
}
extension GuideViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return 4
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pageOneController =  mainStoryboard.instantiateViewController(withIdentifier: "PageOneViewController") as! PageOneViewController
        let pageTwoController =  mainStoryboard.instantiateViewController(withIdentifier: "PageTwoViewController") as! PageTwoViewController
        let pageThreeController =  mainStoryboard.instantiateViewController(withIdentifier: "PageThreeViewController") as! PageThreeViewController
        let pageFourController =  mainStoryboard.instantiateViewController(withIdentifier: "PageFourViewController") as! PageFourViewController
        
        if position == 0
        {
            return pageOneController
        }
        if position == 1
        {
            return pageTwoController
        }
        if position == 2
        {
            return pageThreeController
        }
        if position == 3
        {
            return pageFourController
        }
        return pageOneController
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension GuideViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        if index == 0 {
            pageController.currentPage = index
        }else if index == 1 {
            pageController.currentPage = index
        }else if index == 2 {
            pageController.currentPage = index
        }else if index == 3 {
            pageController.currentPage = index
        }
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        if index == 0 {
            pageController.currentPage = index
        }else if index == 1 {
            pageController.currentPage = index
        }else if index == 2 {
            pageController.currentPage = index
        }else if index == 3 {
            pageController.currentPage = index
        }
    }
    
}
