//
//  Acronym.swift
//  AcronymFinder
//
//  Created by Diamond on 1/16/17.
//  Copyright © 2017 ethanthomas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Acronym {
    
    var longForm: String?
    
    init(json: JSON) {
        longForm = json["lf"].stringValue
    }
}
