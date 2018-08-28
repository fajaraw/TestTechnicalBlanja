//
//  Constant.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//


struct APIConstant {
    static let apiKey = "75SESj1jEAmcNGjLc6mDducMXqL97FvY"
    static let BaseURL = "https://dataservice.accuweather.com/"
    static let versionUrl = "v1"
    static let searchCity = BaseURL + "locations/\(versionUrl)/cities/id/search?apikey=\(apiKey)&q="
    static let autocompleteSearch = BaseURL + "locations/\(versionUrl)/cities/autocomplete?apikey=\(apiKey)&q="
    static let adminCity = BaseURL + "locations/\(versionUrl)/adminareas/id?apikey=" + apiKey
    static let locationByIP = BaseURL + "locations/\(versionUrl)/cities/ipaddress?apikey=\(apiKey)&q="
    
    static let forecastCurrent = BaseURL + ""
    static let currentCondition = BaseURL + "currentconditions/\(versionUrl)/#?apikey=\(apiKey)&details=true"
    
//    static let iconWeather = "https://developer.accuweather.com/sites/default/files/#-s.png"
    
    static let openWeatherIcon = "https://openweathermap.org/img/w/#.png"
    static let getPublicIp = "https://icanhazip.com/"
}
