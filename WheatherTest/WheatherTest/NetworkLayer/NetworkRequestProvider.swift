//
//  NetworkRequestProvider.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 16.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkRequestProviderProtocol: NetworkWeatherInfoRequestProtocol {
    
}

class NetworkRequestProvider: NetworkRequestProviderProtocol {
    
    internal let networkWrapper: NetworkRequestWrapper
    internal lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    init(networkWrapper: NetworkRequestWrapper) {
        self.networkWrapper = networkWrapper
    }
    
    internal func runRequest(_ req: ApiRequest, baseUrl url: String, token: String?, _ completion: @escaping (Int, Data?, ApiError?) -> Void) {
        self.networkWrapper.runRequest(req, baseUrl: url, token: token) { (statusCode, data, error) in
            completion(statusCode, data, error)
        }
    }
}

extension NetworkRequestProvider: NetworkWeatherInfoRequestProtocol {
    func getWeatherInfo(cityId: String,callback: @escaping (OpenWeatherMapRespondModel?, ApiError?) -> ()) {
        let request = WeatherInfoRequest.init(cityId: cityId)
        self.runRequest(request, baseUrl: baseURL, token: token) { (_, data, error) in
            if let error = error {
                
                callback(nil, error)
                return
            }
            
            do {
                if let data = data {
                    let jsonResult = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                    let json = JSON(jsonResult)
                    
                    if let weatherModel = OpenWeatherMapRespondModel.createWith(json) {
                        
                        callback(weatherModel, nil)
                    } else {
                        callback(nil, nil)
                    }
                }
            } catch let parseError {
                // TODO: - create parce error type
                callback(nil, error)
            }
        }
    }
}
