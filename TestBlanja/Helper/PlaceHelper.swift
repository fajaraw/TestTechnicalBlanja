//
//  PlaceHelper.swift
//  TestBlanja
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

class PlaceHelper {
    static let instance = PlaceHelper()
    var dataFile = BehaviorRelay<[LocationModel]>(value:[])
    
    init(){
        DispatchQueue.global(qos: .background).async {
            self.getFile()
        }
    }
    
    fileprivate func getFile(){
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json"){
            do {
                let data = try Data(contentsOf:
                    URL(fileURLWithPath: path), options: .mappedIfSafe)
                print("add")
                let json = try JSON(data: data).arrayValue.filter{$0["country"].stringValue == "ID"}
                var temp = [LocationModel]()
                print("adds \(json.count)")
                json.forEach({ (json) in
                    let model = LocationModel()
                    model.parseOpen(json: json)
                    temp.append(model)
                })
                DispatchQueue.main.async {
                    self.dataFile.accept(temp)
                }
            }catch let e{
                print("error \(e)")
            }
        }
    }
}
