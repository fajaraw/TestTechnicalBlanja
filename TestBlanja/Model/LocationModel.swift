//
//  LocationModel.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON

struct LocationModel {
    lazy var key = ""
    lazy var localName = ""
    lazy var country = LocationAreaModel()
    lazy var administrativeArea = LocationAreaModel()
}

struct LocationAreaModel{
    lazy var idArea = ""
    lazy var nameArea = ""
    
    func parse(json:JSON)
}
