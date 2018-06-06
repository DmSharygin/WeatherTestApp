//
//  WeatherDetailPresenter.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 21.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit

class WeatherDetailPresenter: NSObject {

    var interactor : IWeatherDetailInteractor
    var view: IWeatherDetailView
    var wireFrame: IWeatherDetailWireFrame
    let cityId = "524894"
    
    init(view: IWeatherDetailView, interactor: IWeatherDetailInteractor, wireFrame: IWeatherDetailWireFrame) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    // private
    
    func configureViewWithWeatherType(_ type: WeatherType) {
        if let mainImage = UIImage(named: type.rawValue){
            self.view.mainImage(mainImage)
        }
    }
}

extension WeatherDetailPresenter: IWeatherDetailPresenter {
    
    func viewLoaded(){
        self.view.showDownLoading(true)
        self.interactor.getNowWeather(cityId: self.cityId) { (model, error) in
            DispatchQueue.main.async {
                self.view.showDownLoading(false)
            }
            if error != nil {
                if let error = error as? ApiErrorStruct {
                    DispatchQueue.main.async {
                        self.view.showError(message: error.messageForError())
                    }
                }
                return
            }
            guard let model = model, let temperature = model.getTemperature() else {
                DispatchQueue.main.async {
                    self.view.showError(message: "Нет данных от сервера")
                }
                return
            }
            DispatchQueue.main.async {
                self.view.setNowTemperature(temperature)
                self.configureViewWithWeatherType(model.getType())
            }
        }
    }
    
}
