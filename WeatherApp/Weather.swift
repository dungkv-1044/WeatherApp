//
//  Location.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation

struct Weather {
    var today: Double?
    var cityName: String = ""
    var country: String = ""
    var conditionText: String = ""
    var conditionIcon: String = ""
    var tempC : String = "0 °C"
    
    init?(dictionary: Dictionary<AnyHashable,Any>) {
        guard let location = dictionary["location"] as? Dictionary<AnyHashable,Any> else {
            return
        }
        
        self.cityName = location["name"] as? String ?? ""
        self.country = location["country"] as? String ?? ""
        
        guard let current = dictionary["current"] as? Dictionary<AnyHashable,Any> else {
            return
        }
        self.today = current["last_updated_epoch"] as? Double ?? 0
        let tempC = current["temp_c"] as? Double ?? 0
        self.tempC = String(format: "%.0f °C", tempC)
        
        guard let condition = current["condition"] as? Dictionary<AnyHashable,Any> else {
            return
        }
        self.conditionText = condition["text"] as? String ?? ""
        self.conditionIcon = condition["icon"] as? String ?? ""
        
    }
    
}
