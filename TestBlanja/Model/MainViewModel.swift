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
import Weathersama


class MainViewModel {
    var place = BehaviorRelay<LocationModel?>(value:nil)
    var weatherCondition = BehaviorRelay<WeatherModel?>(value: nil)
    let disposeBag = DisposeBag()
    var publicIP = ""
    var temp_type = TEMPERATURE_TYPES.Celcius {
        didSet{
            weatherSama = Weathersama(appId: "8631fcc35c0f17a74e1c742b9d975df4", temperature: temp_type, language: LANGUAGES.English, dataResponse: DATA_RESPONSE.JSON)
            requestOpenMap()
        }
    }
    
    fileprivate var weatherSama:Weathersama!
    
    init(){
        weatherSama = Weathersama(appId: "8631fcc35c0f17a74e1c742b9d975df4", temperature: temp_type, language: LANGUAGES.English, dataResponse: DATA_RESPONSE.JSON)
      
        place.bind { (location) in
            self.requestOpenMap()
            //accu weather api
//            if let loc = location {
//                request(APIConstant.currentCondition.replacingOccurrences(of: "#", with: loc.key))
//                    .responseJSON(completionHandler: { (response) in
//                        print("result \(response.error) \(response.result.value)")
//                        if response.result.isSuccess {
//                            let weather = JSON(response.result.value ?? "")
//                            if let temp = weather.arrayValue.first {
//                                let model = WeatherAccuModel(temp)
//                                self.weatherCondition.accept(model)
//                            }
//                        }
//                    })
//            }
        }.disposed(by: disposeBag)
    }
    
    func requestOpenMap(){
        print("place \(place.value?.key)")
        weatherSama.weatherByCityId(cityId: Int(place.value?.key ?? "") ?? 0, requestType: .Weather) { (result, desc, model) -> ()? in
            if let weather = model as? WeatherModel , result {
                self.weatherCondition.accept(weather)
            }
            return ()
        }
    }
    
    func getInitial(){
//        getPublicIp()
        let loc = LocationModel()
        loc.localName = "Jakarta"
        loc.country.nameArea = "ID"
        loc.key = "1642911"
        self.place.accept(loc)
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
