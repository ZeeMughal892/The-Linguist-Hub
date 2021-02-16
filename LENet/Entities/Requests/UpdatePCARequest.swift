//
//  UpdatePCARequest.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 01/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
public class UpdatePCARequest {
    public var idCardNo : String!
    public var excludedPca: Array = [String]()
    public var postcodeOnly : Int!
}
