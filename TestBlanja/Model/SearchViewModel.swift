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
    var data = BehaviorRelay<[JSON]>(value:[])
    let disposeBag = DisposeBag()
    
    init() {
        query.throttle(0.4, scheduler: MainScheduler.instance).bind { (str) in
            request("\(APIConstant.autocompleteSearch)\(str)")
                .responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        let respon = JSON(response.result.value ?? "")
                        data.accept(respon.arrayValue)
                    }
                })
        }.disposed(by: disposeBag)
    }
    
}
