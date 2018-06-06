//
//  OpenWeatherMapRespondModel.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 11.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit
import SwiftyJSON

/*
 {"coord":
 {"lon":145.77,"lat":-16.92},
 "weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],
 "base":"cmc stations",
 "main":{"temp":293.25,"pressure":1019,"humidity":83,"temp_min":289.82,"temp_max":295.37},
 "wind":{"speed":5.1,"deg":150},
 "clouds":{"all":75},
 "rain":{"3h":3},
 "dt":1435658272,
 "sys":{"type":1,"id":8166,"message":0.0166,"country":"AU","sunrise":1435610796,"sunset":1435650870},
 "id":2172797,
 "name":"Cairns",
 "cod":200}
*/

class OpenWeatherMapRespondModel {

    var coord : [String : Float]? = nil
    var weather : TownWeatherModel? = nil
    var base : String? = nil
    var main : [String : Float]? = nil
    var wind : [String : Float]? = nil
    var clouds : [String: Float]? = nil
    var dt : Int? = nil
    var sys : [String: Float]? = nil
    var id : Int? = nil
    var name : String? = nil
    var cod: Int? = nil
    
    static func createWith(_ json: JSON) -> OpenWeatherMapRespondModel? {
        let model = OpenWeatherMapRespondModel()
        model.coord = json["coord"].dictionaryObject as? [String : Float]
        if let weatherJSON = json["weather"].dictionaryObject {
            model.weather = TownWeatherModel.createWithDictionary(weatherJSON)
        }
        if let weatherJson = json["weather"].array?.first {
            model.weather = TownWeatherModel.createWith(weatherJson)
        }
        model.base = json["base"].string
        model.main = json["main"].dictionaryObject as? [String : Float]
        model.wind = json["wind"].dictionaryObject as? [String : Float]
        model.clouds = json["clouds"].dictionaryObject as? [String : Float]
        model.dt = json["dt"].int
        model.name = json["name"].string
        model.cod = json["cod"].int
        
        return model
    }
    
    func getTemperature() -> Int? {
        guard let mainInfo = self.main else { return nil }
        if let kelvinTemperature = mainInfo["temp"] {
            return Int(kelvinTemperature - 273) //
        }
        return nil
    }
    
    func getType() -> WeatherType {
        guard let weather = self.weather , let main = weather.main else { return .none}
        switch main {
        case "Clouds":
            return .clouds
        case "Rain":
            return .rains
        case "Clear":
            return .sunny
        default:
            return .none
        }
    }
}
