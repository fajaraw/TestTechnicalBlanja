//
//  MainViewModel.swift
//  TestBlanja
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

class MainViewModel {
    var place = BehaviorRelay<LocationModel?>(value:nil)
    var weatherCondition = BehaviorRelay<WeatherModel?>(value: nil)
    let disposeBag = DisposeBag()
    var publicIP = ""
    
    init(){
        place.bind { (location) in
            if let loc = location {
                request(APIConstant.currentCondition.replacingOccurrences(of: "#", with: loc.key))
                    .responseJSON(completionHandler: { (response) in
                        print("result \(response.error) \(response.result.value)")
                        if response.result.isSuccess {
                            let weather = JSON(response.result.value ?? "")
                            if let temp = weather.arrayValue.first {
                                let model = WeatherModel(temp)
                                self.weatherCondition.accept(model)
                            }
                        }
                    })
            }
        }.disposed(by: disposeBag)
    }
    
    func getInitial(){
        getPublicIp()
    }
    
    private func getLocationIP(){
        let url = "\(APIConstant.locationByIP)\(publicIP)"
        print("url \(url)")
        request(url)
            .responseJSON { (response) in
                if response.result.isSuccess {
                    let json = JSON(response.result.value ?? "")
                    let loc = LocationModel(json)
                    self.place.accept(loc)
                }
            }
    }
    
    private func getPublicIp(){
        request(APIConstant.getPublicIp)
            .responseString { (response) in
                if let val = response.result.value , response.result.isSuccess {
                    self.publicIP = val.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.getLocationIP()
                }
        }
    }
}
