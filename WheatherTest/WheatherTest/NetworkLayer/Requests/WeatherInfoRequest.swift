//
//  WeatherInfoRequest.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 12.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation

struct WeatherInfoRequest: GetApiRequest {
    
    public var cityId: String
    var path: String {
        // TODO main url and API version in const
        return "/weather"
    }
    
    var params: [String : Any] {
        return ["id": self.cityId,
                "APPID": token]
    }
    
}
