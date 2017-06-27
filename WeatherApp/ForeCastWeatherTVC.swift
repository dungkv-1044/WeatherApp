//
//  ForeCastWeatherTVC.swift
//  WeatherApp
//
//  Created by Dung on 6/27/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import UIKit

class ForeCastWeatherTVC: UITableViewController {
    @IBOutlet var dayOfWeekCell: [UILabel]!
    @IBOutlet var iconCell: [UIImageView]!
    @IBOutlet var maxDegreeCell: [UILabel]!
    @IBOutlet var minDegreeCell: [UILabel]!
    
    @IBOutlet weak var maxDegree: UILabel!
    @IBOutlet weak var minDegree: UILabel!
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var colectionView: UICollectionView!
    
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var today: UILabel!
    var identifierCountry = "en_US"
    var weatherOfDay: WeatherOfDay? {
        willSet {
            self.weatherOfDay = DataServices.shared.weather?.weatherOfDays[0]
        }
        didSet {
            let currentDay = weatherOfDay?.date ?? 0
            dayOfWeek.text = dayWeek(day: currentDay)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        today.isHidden = true
        colectionView.isHidden = true
        initData()
        navigationItem.title = DataServices.shared.weather?.cityName
        currentTemp.text = DataServices.shared.weather?.tempC
        currentWeather.text = DataServices.shared.weather?.conditionText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        today.isHidden = false
        colectionView.isHidden = false
        colectionView.reloadData()
        self.weatherOfDay = DataServices.shared.weather?.weatherOfDays[0]
        maxDegree.text = "\(weatherOfDay?.maxTemp_Date ?? 0)ºC"
        minDegree.text = "\(weatherOfDay?.minTemp_Date ?? 0)ºC"
        
        for index in 0..<dayOfWeekCell.count {
            
            let weatherDays = DataServices.shared.weather?.weatherOfDays[index+1]
            guard let date = weatherDays?.date else {
                return
            }
            dayOfWeekCell[index].text = dayWeek(day: date)
            print(dayWeek(day: date))
            guard let icon = weatherDays?.icon_Date else {
                return
            }
            iconCell[index].dowloadImage(from: icon)
            guard let tempCMax = weatherDays?.maxTemp_Date else {
                return
            }
            maxDegreeCell[index].text = "\(tempCMax)ºC"
            guard let tempCMin = weatherDays?.minTemp_Date else {
                return
            }
            minDegreeCell[index].text = "\(tempCMin)ºC"
            
            
            
        }
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return colectionView
    }
    
}

extension ForeCastWeatherTVC {
    func dayWeek(day: TimeInterval) -> String {
        let create = Date(timeIntervalSince1970: day)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: identifierCountry)
        let dayVI = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: create) - 1]
        return dayVI
    }
    
    func hourDay(hour: TimeInterval) -> String {
        let create = Date(timeIntervalSince1970: hour)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: identifierCountry)
        dateFormatter.timeStyle = .short
        let hourVI = dateFormatter.string(from: create)
        return hourVI
    }
    
}

extension ForeCastWeatherTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServices.shared.weatherOfHour.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if indexPath.row == 0 {
            let weather = DataServices.shared.weather
            cell.time.text = "Today"
            let url = "http:" + (weather?.conditionIcon)!
            cell.imageView.dowloadImage(from: url)
            cell.temporature.text = weather?.tempC
        } else {
            let weather = DataServices.shared.weatherOfHour[indexPath.row - 1]
            cell.temporature.text = "\(weather.tempC_Hour)ºC"
            cell.imageView.dowloadImage(from: weather.icon_Hour)
            cell.time.text = "\(hourDay(hour: weather.time_Hour))"
        }
        return cell
    }
    
}
