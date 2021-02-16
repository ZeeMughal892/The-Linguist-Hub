//
//  UpdateNameAddressResponse.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 22/06/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import ObjectMapper
public class UpdateNameAddressResponse : ApiResponse {
    
    public var d = DefaultModel()
    
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
