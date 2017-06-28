//
//  DataServices.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation
class DataServices {
    static let shared: DataServices = DataServices()
    var searchKey: String = "" {
        didSet {
            fetchWeatherFromURL(locationString: searchKey)
        }
    }
    var city: String = ""
    var weather : Weather?
    private var _weatherOfHour: [WeatherOfHour]?
    
    var weatherOfHour: [WeatherOfHour]! {
        set {
            _weatherOfHour = newValue
        }
        get {
            if _weatherOfHour == nil {
                getHours()
            }
            return _weatherOfHour ?? []
        }
    }
    
    func getHours() {
        if let currentTime = weather?.today {
            _weatherOfHour = weather?.weatherOfDays[0].weatherOfHours.filter { $0.time_Hour > currentTime}
        }
    }
    func fetchWeatherFromURL(locationString: String) {
        print(locationString)
        let URL_WEATHER = "http://api.apixu.com/v1/forecast.json?&days=7&key=7042f000fa43421b98612223172606&q=\(locationString)"
        let URL_STRING = URL(string: URL_WEATHER)
        guard let url = URL_STRING else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? Dictionary<AnyHashable,Any> else {return}
            guard let weather = Weather(json: jsonObject) else {
                return
            }
            DispatchQueue.main.async {
                self.weather = weather
                NotificationCenter.default.post(name: NotificationKey.didFetchSuccess, object: nil)
            }
            
        }).resume()
        
        
    }
    
}
