//
//  WeatherModel.swift
//  TestBlanja
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import SwiftyJSON
import DateToolsSwift

enum SystemUnit {
    case IMPERIAL
    case METRIC
}

class WeatherAccuModel {
    lazy var weatherName = ""
    lazy var weatherIcon = 0
    lazy var observerDate = Date()
    lazy var temperature = WeatherUnit()
    lazy var realFeelTemp = WeatherUnit()
    lazy var humidity = ""
    lazy var windSpeed = WeatherUnit()
    lazy var windDirection = UnitModel()
    lazy var pressure = WeatherUnit()
    var currentUnitSystem:SystemUnit = .METRIC {
        didSet{
            temperature.unitSysterm = currentUnitSystem
            realFeelTemp.unitSysterm = currentUnitSystem
            windSpeed.unitSysterm = currentUnitSystem
            pressure.unitSysterm = currentUnitSystem
        }
    }
    
    init(_ json:JSON) {
        parse(json)
    }
    
    init(){
        
    }
    
    func parse(_ json:JSON){
        weatherName = json["WeatherText"].stringValue
        weatherIcon = json["WeatherIcon"].intValue
        let date = json["LocalObservationDateTime"].stringValue
        observerDate = Date(dateString: date, format: "")
        temperature = WeatherUnit(json["Temperature"])
        realFeelTemp = WeatherUnit(json["RealFeelTemperature"])
        humidity = json["RelativeHumidity"].stringValue
        windSpeed = WeatherUnit(json["Wind"]["Speed"])
        windDirection = UnitModel()
        windDirection.value = json["Wind"]["Direction"]["Degrees"].stringValue
        windDirection.unit = json["Wind"]["Direction"]["Localized"].stringValue
        pressure = WeatherUnit(json["Pressure"])
    }
}

class WeatherUnit {
    var metric = UnitModel()
    var imperial = UnitModel()
    var unitSysterm:SystemUnit = .METRIC
    var value:String{
        return unitSysterm == .IMPERIAL ? imperial.value : metric.value
    }
    var unit:String{
        return unitSysterm == .IMPERIAL ? imperial.unit : metric.unit
    }
    
    var text:String{
        return "\(value) \(unit)"
    }
    
    init() {
        
    }
    init(_ json:JSON) {
        parse(json)
    }
    func parse(_ json:JSON){
        metric = UnitModel(json["Metric"])
        imperial = UnitModel(json["Imperial"])
    }
}

class UnitModel {
    lazy var value = ""
    lazy var unit = ""
    
    init(){
        
    }
    
    init(_ json:JSON) {
        parse(json)
    }
    
    func parse(_ json:JSON){
        value = json["Value"].stringValue
        unit = json["Unit"].stringValue
    }
}
