//
//  Constant.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//


struct APIConstant {
    static let apiKey = "75SESj1jEAmcNGjLc6mDducMXqL97FvY"
    static let BaseURL = "http://dataservice.accuweather.com/"
    static let searchCity = BaseURL + "/locations/v1/cities/id/search?apikey=\(apiKey)&q="
    static let autocompleteSearch = BaseURL + "/locations/v1/cities/autocomplete?apikey=\(apiKey)&q="
    static let adminCity = BaseURL + "locations/v1/adminareas/id?apikey=" + apiKey
    static let forecastCurrent = ""
    
    static let iconWeather = "https://developer.accuweather.com/sites/default/files/#-s.png"
}
