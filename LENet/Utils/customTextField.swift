//
//  CustomTextField.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 05/03/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class customUITextField: UITextField {
    
    func setup() {
        let border = CALayer()
        let width = CGFloat(1.5)
        let color = UIColor.init(named: LoginUser.getThemeColor)
        border.borderColor = color?.cgColor
        
        border.frame = CGRect(x: 0,
                              y: self.frame.size.height - width,
                              width: self.frame.size.width,
                              height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
