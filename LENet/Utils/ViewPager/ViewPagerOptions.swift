

import UIKit
import Foundation

public class ViewPagerOptions {
    
    public var viewPagerFrame:CGRect = CGRect.zero
    
    // Tabs Customization
    public var tabType:ViewPagerTabType = .basic
    public var isTabHighlightAvailable:Bool = false
    public var isTabIndicatorAvailable:Bool = false
    public var tabViewBackgroundDefaultColor:UIColor = Color.tabViewBackground
    public var tabViewBackgroundHighlightColor:UIColor = Color.tabViewHighlight
    public var tabViewTextDefaultColor:UIColor = Color.textDefault
    public var tabViewTextHighlightColor:UIColor = Color.textHighlight!
    
    // Booleans
    
    /// Width of each tab is equal to the width of the largest tab. Tabs are laid out from Left - Right and are scrollable
    public var isEachTabEvenlyDistributed:Bool = false
    /// All the tabs are squeezed to fit inside the screen width. Tabs are not scrollable. Also it overrides isEachTabEvenlyDistributed
    public var fitAllTabsInView:Bool = false
    
    // Tab Properties
    public var tabViewHeight:CGFloat = 50.0
    public var tabViewPaddingLeft:CGFloat = 10.0
    public var tabViewPaddingRight:CGFloat = 10.0
    public var tabViewTextFont:UIFont = UIFont.systemFont(ofSize: 16)
    public var tabViewImageSize:CGSize = CGSize(width: 25, height: 25)
    public var tabViewImageMarginTop:CGFloat = 5
    public var tabViewImageMarginBottom:CGFloat = 5
    
    // Tab Indicator
    public var tabIndicatorViewHeight:CGFloat = 3
    public var tabIndicatorViewBackgroundColor:UIColor = Color.tabIndicator!
    
    // ViewPager
    public var viewPagerTransitionStyle:UIPageViewController.TransitionStyle = .scroll
    
    /**
     * Initializes Options for ViewPager. The frame of the supplied UIView in view parameter is
     * used as reference for ViewPager width and height.
     */
    public init(viewPagerWithFrame frame:CGRect) {
        self.viewPagerFrame = frame
    }
    
    fileprivate struct Color {
        
        static let tabViewBackground = UIColor.systemBackground
        
        static let tabViewHighlight = UIColor.systemBackground
        
        static let textDefault = UIColor.from(r: 93, g: 93, b: 93)
        
        static let textHighlight = UIColor.init(named: LoginUser.getThemeColor)
       
        static let tabIndicator = UIColor.init(named: LoginUser.getThemeColor)
    }
}

fileprivate extension UIColor {
    
    class func from(r: CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
