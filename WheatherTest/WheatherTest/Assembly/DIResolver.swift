//
//  DIResolver.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 21.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import Foundation
import UIKit

class DIResolver {
    
    func weatherDetailController() -> UIViewController {
        let vc = WeatherDetailViewController()
        let interactor = WeatherDetailInteractor(networkProvider: NetworkRequestProvider(networkWrapper: MoyaRequestWrapper()))
        let wireframe = WeatherDetailWireframe()
        let presenter = WeatherDetailPresenter.init(view: vc, interactor: interactor, wireFrame: wireframe)
        vc.presenter = presenter
        
        return vc
    }
}
