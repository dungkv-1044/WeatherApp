//
//  Constant.swift
//  WeatherApp
//
//  Created by Dung on 6/26/17.
//  Copyright © 2017 Dung. All rights reserved.
//

import Foundation
struct NotificationKey {
    static var didFetchSuccess = Notification.Name.init("didFetchLocationFromURL")
    static var didGetCurrentLocation = Notification.Name.init("didGetCurrentLocation")
}
