//
//  CreateAbsenceResponse.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 02/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper

public class CreateAbsenceResponse : ApiResponse {
    
    public var d = AbsenceModel()
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        d <- map["d"]
    }
    public override init() {
        super.init()
    }
    public required init?(map: Map) {
        super.init(map: map)
    }
}
