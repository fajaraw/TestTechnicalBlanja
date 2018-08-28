//
//  ViewController.swift
//  TestBlanja
//
//  Created by Fajar on 8/27/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var imageTemp: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelUnit: UILabel!
    @IBOutlet weak var labelFeelTemperature: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelPreasure: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    
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
    }
    
    private func setWeather(weather:WeatherModel?){
        if let w = weather {
            self.imageTemp.setImageURL(url: APIConstant.iconWeather.replacingOccurrences(of: "#", with: String(format: "%02d", w.weatherIcon)))
            self.labelTemperature.text = w.temperature.value
            self.labelUnit.text = w.temperature.unit
            self.labelFeelTemperature.text = w.realFeelTemp.text
            self.labelDate.text = w.observerDate.format(with: "dd MMMM yyy, HH:mm")
            self.labelHumidity.text = w.humidity
            self.labelPreasure.text = w.pressure.text
            self.labelWindSpeed.text = w.windSpeed.text
            self.labelDirection.text = w.windDirection.value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchOnClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        vc.vm.selectedLocation.bind(to: vm.place).disposed(by: vc.vm.disposeBag)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

