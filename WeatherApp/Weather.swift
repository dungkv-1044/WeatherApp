//
//  Location.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>
struct Weather {
    var today: Double?
    var cityName: String = ""
    var country: String = ""
    var conditionText: String = ""
    var conditionIcon: String = ""
    var tempC : String = "0 °C"
    var weatherOfDays: [WeatherOfDay] = []
    
    init?(json: JSON) {
        guard let location = json["location"] as? JSON else {
            return
        }
        
        self.cityName = location["name"] as? String ?? ""
        self.country = location["country"] as? String ?? ""
        
        guard let current = json["current"] as? JSON else {
            return
        }
        self.today = current["last_updated_epoch"] as? Double ?? 0
        let tempC = current["temp_c"] as? Double ?? 0
        self.tempC = String(format: "%.0f °C", tempC)
        
        guard let condition = current["condition"] as? JSON else {
            return
        }
        
        guard let forecast = json["forecast"] as? JSON,
            let forecastDays = forecast["forecastday"] as? [JSON]
            else {
                return nil
        }
        
        for forecastDay in forecastDays {
            if let weatherDay = WeatherOfDay(json: forecastDay) {
                weatherOfDays.append(weatherDay)
            }
        }

        self.conditionText = condition["text"] as? String ?? ""
        self.conditionIcon = condition["icon"] as? String ?? ""
        
    }
}

struct WeatherOfDay {
    var date: TimeInterval
    var icon_Date: String
    var maxTemp_Date: Int
    var minTemp_Date: Int
    var weatherOfHours: [WeatherOfHour] = []
    
    init?(json: JSON) {
        
        guard let dateEpoch = json["date_epoch"] as? TimeInterval else {
            return nil
        }
        
        guard let day = json["day"] as? JSON,
            let tempMax = day["maxtemp_c"] as? Int,
            let tempMin = day["mintemp_c"] as? Int
            else {
                return nil
        }
        
        guard let conditionDay = day["condition"] as? JSON,
            let iconDay = conditionDay["icon"] as? String
            else {
                return nil
        }
        
        guard let hoursOfDay = json["hour"] as? [JSON] else {
            return nil
        }
        
        for hourOfDay in hoursOfDay {
            if let weatherHour = WeatherOfHour(json: hourOfDay) {
                weatherOfHours.append(weatherHour)
            }
        }
        
        self.date = dateEpoch
        self.icon_Date = "http:\(iconDay)"
        self.maxTemp_Date = tempMax
        self.minTemp_Date = tempMin
    }

}

struct WeatherOfHour {
    var time_Hour: TimeInterval
    var tempC_Hour: Int
    var icon_Hour: String
    
    init?(json: JSON) {
        
        guard let hourEpoch = json["time_epoch"] as? TimeInterval else {
            return nil
        }
        
        guard let tempHour = json["temp_c"] as? Int else {
            return nil
        }
        
        guard let conditionHour = json["condition"] as? JSON,
            let iconHour = conditionHour["icon"] as? String
            else {
                return nil
        }
        
        self.time_Hour = hourEpoch
        self.tempC_Hour = tempHour
        self.icon_Hour = "http:\(iconHour)"
    }

}
