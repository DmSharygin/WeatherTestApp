//
//  TownWeatherModel.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 11.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit
import SwiftyJSON

/*
 {"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}
*/

class TownWeatherModel {

    var id: Int = 0
    var main: String? = nil
    var description: String? = nil
    var icon : String? = nil
    
    static func createWith(_ json: JSON) -> TownWeatherModel? {
        let model = TownWeatherModel()
        guard let id = json["id"].int else { return nil }
        model.id = id
        model.main = json["main"].string
        model.description = json["description"].string
        model.icon = json["icon"].string
        
        return model
    }
    
    static func createWithDictionary(_ dictionary: [String : Any]) -> TownWeatherModel? {
        let model = TownWeatherModel()
        guard let id = dictionary["id"] as? Int else { return nil }
        model.id = id
        model.main = dictionary["main"] as? String
        model.description = dictionary["description"] as? String
        model.icon = dictionary["icon"] as? String
        
        return model
    }
    
}
