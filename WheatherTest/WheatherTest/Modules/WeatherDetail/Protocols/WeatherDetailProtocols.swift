//
//  WeatherDetailProtocols.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 16.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import UIKit

// Row value is name of image
enum WeatherType: String {
    case sunny = "sunny.png"
    case sunWithClouds = "occasional.png"
    case clouds = "overcast.png"
    case rains = "rain.png"
    case snow = "snowflake.png"
    case none = "none"
}

enum TimeOfDay {
    case morning
    case aferternoon
    case evening
    case night
}

protocol IWeatherDetailView: class {
    func mainImage(_ image: UIImage)
    func setMainColor(_ color: UIColor)
    func setLocationTitle(_ title: String)
    func setNowTemperature(_ temperature: Int)
    func setNowWeatherType(_ type: WeatherType)
    func showDownLoading(_ visible:Bool)
    func showError(message: String?)
}

protocol IWeatherDetailPresenter: class {
    func viewLoaded()
    
}

protocol IWeatherDetailInteractor: class {
    func getNowWeather(cityId: String, callback: @escaping (_ model: OpenWeatherMapRespondModel?, _ error: Error?) -> Void)
//    func
}

protocol IWeatherDetailWireFrame: class {
    
}


