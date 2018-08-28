//
//  LocationModel.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON

class LocationModel {
    lazy var key = ""
    lazy var localName = ""
    lazy var country = LocationAreaModel()
    lazy var administrativeArea = LocationAreaModel()
    init(){
        
    }
    init(_ json:JSON) {
        parse(json: json)
    }
    
    func parse(json:JSON){
        key = json["Key"].stringValue
        localName = json["LocalizedName"].stringValue
        country = LocationAreaModel(json["Country"])
        administrativeArea = LocationAreaModel(json["AdministrativeArea"])
    }
}

class LocationAreaModel{
    lazy var idArea = ""
    lazy var nameArea = ""
    
    init() {
        
    }
    
    init(_ json:JSON) {
        parse(json: json)
    }
    
    func parse(json:JSON){
        idArea = json["ID"].stringValue
        nameArea = json["LocalizedName"].stringValue
    }
}
