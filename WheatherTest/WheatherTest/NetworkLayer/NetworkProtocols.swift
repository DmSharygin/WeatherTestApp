//
//  NetworkProtocols.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 12.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation

protocol NetworkRequestWrapper {
    func runRequest(_ request: ApiRequest, baseUrl: String, token: String?, completion: @escaping (Int, Data?, ApiError?) -> Void)
}

protocol NetworkWeatherInfoRequestProtocol {
    func getWeatherInfo(cityId: String, callback: @escaping (_ weatherInfo: OpenWeatherMapRespondModel?, _ error: ApiError?) -> ())
}

