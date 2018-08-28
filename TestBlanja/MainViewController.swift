//
//  ViewController.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit
import Weathersama

class MainViewController: UIViewController {

    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var imageTemp: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelUnit: UILabel!
    @IBOutlet weak var labelMin: UILabel!
    @IBOutlet weak var labelMax: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelPreasure: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    @IBOutlet weak var holderLoading: UIView!
    
    let vm = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        vm.weatherCondition.bind { (weather) in
            self.setWeather(weather: weather)
        }.disposed(by: vm.disposeBag)
        vm.place.bind { (location) in
            if let loc = location {
                self.labelPlace.text = "\(loc.localName), \(loc.country.nameArea)"
            }
        }.disposed(by: vm.disposeBag)
        vm.getInitial()
        if PlaceHelper.instance.dataFile.value.count == 0 {
            PlaceHelper.instance.dataFile.bind(onNext: { (loc) in
                if loc.count != 0 {
                    self.holderLoading.isHidden = true
                }
            }).disposed(by: vm.disposeBag)
        }else{
            self.holderLoading.isHidden = true
        }
    }
    
    private func setWeather(weather:WeatherModel?){
        if let w = weather {
            print("icon \(w.weather.first?.icon)")
            self.imageTemp.setImageURL(url: APIConstant.openWeatherIcon.replacingOccurrences(of: "#", with: w.weather.first?.icon ?? ""))
            self.labelTemperature.text = "\(w.main.temperature ?? 0)"
            switch vm.temp_type {
            case .Celcius:
                self.labelUnit.text = "C"
                break
            case .Fahrenheit :
                self.labelUnit.text = "F"
                break
            case .Kelvin:
                self.labelUnit.text = "K"
                break
            }
            
            self.labelMin.text = "\(w.main.temperatureMin ?? 0)"
            self.labelMax.text = "\(w.main.temperatureMax ?? 0)"
            self.labelDate.text = Date().format(with: "dd MMMM yyy, HH:mm")
            self.labelHumidity.text = "\(w.main.humidity ?? 0)"
            self.labelPreasure.text = "\(w.main.pressure ?? 0)"
            self.labelWindSpeed.text = "\(w.wind.speed ?? 0)"
            self.labelDirection.text = "\(w.wind.deg ?? 0)"
        }
    }
//    accu weather
//    private func setWeather(weather:WeatherAccuModel?){
//        if let w = weather {
//            self.imageTemp.setImageURL(url: APIConstant.iconWeather.replacingOccurrences(of: "#", with: String(format: "%02d", w.weatherIcon)))
//            self.labelTemperature.text = w.temperature.value
//            self.labelUnit.text = w.temperature.unit
//            self.labelFeelTemperature.text = w.realFeelTemp.text
//            self.labelDate.text = w.observerDate.format(with: "dd MMMM yyy, HH:mm")
//            self.labelHumidity.text = w.humidity
//            self.labelPreasure.text = w.pressure.text
//            self.labelWindSpeed.text = w.windSpeed.text
//            self.labelDirection.text = w.windDirection.value
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tempChanged(_ sender: Any) {
        print("changed")
        guard let segmen = sender as? UISegmentedControl else {return}
        print("changed")
        switch segmen.selectedSegmentIndex {
        case 0:
            vm.temp_type = .Celcius
            break
        case 1:
            vm.temp_type = .Fahrenheit
            break
        case 2:
            vm.temp_type = .Kelvin
            break
        default:
            break
        }
    }
    @IBAction func searchOnClick(_ sender: Any) {
        print("search")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        vc.vm.selectedLocation.bind(to: vm.place).disposed(by: vc.vm.disposeBag)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

