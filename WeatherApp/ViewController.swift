//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController  {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temporaryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var viewForecast: UIButton!
    //Location MAnager
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        return locationManager
    }()
    var weather: Weather? {
        willSet {
            self.weather = DataServices.shared.weather
        }
        didSet{
            initView()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerNotification()
        viewForecast.isHidden = true
        locationManager.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NotificationKey.didFetchSuccess, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        self.weather = DataServices.shared.weather
    }
    
    func initView() {
        let weather = DataServices.shared.weather
        guard weather != nil else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = Date(timeIntervalSince1970: (weather?.today)!)
        dateLabel.text = "Today, \(dateFormatter.string(from: date))"
        temporaryLabel.text = String(describing: (weather?.tempC)!)
        locationLabel.text = (weather?.cityName)! + ", " + (weather?.country)!
        weatherLabel.text = weather?.conditionText
        let url = "http:" + (weather?.conditionIcon)!
        weatherImage.dowloadImage(from: url)
        viewForecast.isHidden = false
    }
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            // City
            if let city = placeMark.addressDictionary?["City"] as? String {
                let trimmedString = city.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                DataServices.shared.city = city
                let text = ConvertHelper.convertVN(trimmedString).lowercased()
                DataServices.shared.searchKey = text
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
            }
        })
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

