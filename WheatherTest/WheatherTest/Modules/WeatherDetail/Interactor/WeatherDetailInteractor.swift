//
//  WeatherDetailInteractor.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 21.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit

class WeatherDetailInteractor: NSObject {
    
    var networkProvider: NetworkWeatherInfoRequestProtocol! = nil
    
    init(networkProvider: NetworkWeatherInfoRequestProtocol) {
        self.networkProvider = networkProvider
    }

}

extension WeatherDetailInteractor: IWeatherDetailInteractor {
    func getNowWeather(cityId: String, callback: @escaping (OpenWeatherMapRespondModel?, Error?) -> Void) {
        self.networkProvider.getWeatherInfo(cityId: cityId, callback: callback)
    }
}
