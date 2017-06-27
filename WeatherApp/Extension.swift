//
//  Extension.swift
//  WeatherApp
//
//  Created by Dung on 6/27/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    func dowloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
}
