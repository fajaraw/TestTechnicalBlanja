//
//  SearchViewModel.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

class SearchViewModel {
    var query = BehaviorRelay<String>(value:"")
    var data = BehaviorRelay<[LocationModel]>(value:[])
    var selectedLocation = BehaviorRelay<LocationModel?>(value:nil)
    let disposeBag = DisposeBag()
    
    init() {
        if PlaceHelper.instance.dataFile.value.count == 0 {
            PlaceHelper.instance.dataFile.bind(to: data).disposed(by: disposeBag)
        }else{
             data.accept(PlaceHelper.instance.dataFile.value)
        }
        //accu weather
//        query.throttle(0.4, scheduler: MainScheduler.instance).bind { (str) in
//            request("\(APIConstant.autocompleteSearch)\(str)")
//                .responseJSON(completionHandler: { (response) in
//                    print("respon value \(response.result.value)")
//                    if response.result.isSuccess {
//                        let respon = JSON(response.result.value ?? "")
//                        var temp = [LocationModel]()
//                        respon.arrayValue.forEach({ (json) in
//                            let loc = LocationModel(json)
//                            temp.append(loc)
//                        })
//                        self.data.accept(temp)
//                    }
//                })
//        }.disposed(by: disposeBag)
        
        query.bind { (str) in
            self.data.accept(PlaceHelper.instance.dataFile.value.filter{$0.localName.lowercased().contains(str.lowercased())})
        }.disposed(by: disposeBag)
    }

}
