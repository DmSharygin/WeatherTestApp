//
//  TownsListProtocols.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 11.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation

protocol ITownsListView {
    func showLoading()
}

protocol ITownsListPresenter {
    func viewLoaded()
}

protocol ITownsListInteractor {
    func getTownWeatherModel() -> TownWeatherModel?
}

protocol ITownsListWireframe {
    
}
