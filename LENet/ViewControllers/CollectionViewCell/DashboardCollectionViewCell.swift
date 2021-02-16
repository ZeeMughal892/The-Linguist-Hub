//
//  DashboardCollectionViewCell.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 21/07/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import UIKit
import KDCircularProgress

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var circularView: KDCircularProgress!
    @IBOutlet weak var lblTitle: PaddingLabel!
    @IBOutlet weak var cardView: CardView!
}
