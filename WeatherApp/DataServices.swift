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
    var weather : Weather?
    
    func fetchWeatherFromURL(locationString: String) {
        print(locationString)
        let URL_WEATHER = "http://api.apixu.com/v1/current.json?key=7042f000fa43421b98612223172606&q=\(locationString)"
        let URL_STRING = URL(string: URL_WEATHER)
        guard let url = URL_STRING else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) -> Void in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let jsonObject = (try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? Dictionary<AnyHashable,Any> else {return}
            guard let weather = Weather(dictionary: jsonObject) else {
                return
            }
            DispatchQueue.main.async {
                self.weather = weather
                NotificationCenter.default.post(name: NotificationKey.didFetchSuccess, object: nil)
            }
            
        }).resume()
        
        
    }
    
}

func groupText(text: String?) -> String {
    var data = ""
    let stringOfWord = text?.components(separatedBy: " ")
    for word in stringOfWord! {
        data += word
    }
    return data.lowercased()
}

