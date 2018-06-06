//
//  WeatherDetailViewController.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 19.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit
import SnapKit

class WeatherDetailViewController: UIViewController {
    
    var presenter : IWeatherDetailPresenter! = nil
    
    var mainWeatherImageView: UIImageView? = nil
    var locationLabel: UILabel? = nil
    var nowTemperatureLabel: UILabel? = nil
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        guard let presenter = self.presenter else {
            fatalError("WeatherDetailViewController: Presenter is nil")
        }
        presenter.viewLoaded()
    }
    
    private func createUI() {
        
        self.view.backgroundColor = UIColor.appSunnyColor()
        
        // location label
        
        let locationLabel = UILabel()
        locationLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = UIColor.green
        // TODO: Test location, delete later
        locationLabel.text = "Москва"
        locationLabel.textAlignment = .center
        
        self.view.addSubview(locationLabel)
        
        self.locationLabel = locationLabel
        
        // main image
        let mainWeatherImageView = UIImageView()
        mainWeatherImageView.contentMode = .scaleAspectFit
        self.view.addSubview(mainWeatherImageView)
        
        // TODO: test image, delete later
        if let testImage = UIImage(named:"sunny.png") {
            mainWeatherImageView.image = testImage
        }
        self.mainWeatherImageView = mainWeatherImageView
        
        // now temperature label
        let nowTemperatureLabel = UILabel()
        nowTemperatureLabel.font = UIFont.systemFont(ofSize: 64, weight: .ultraLight)
        nowTemperatureLabel.textAlignment = .center
        
        // TODO: test, delete later
        nowTemperatureLabel.text = "+25°"
        self.view.addSubview(nowTemperatureLabel)
        self.nowTemperatureLabel = nowTemperatureLabel
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        var imageWeather : UIImage?
        
        for i in 0...3 {
            switch i {
            case 0:
                imageWeather = UIImage(named: "sunny.png")
                title = "утро"
            case 1:
                imageWeather = UIImage(named: "sunny.png")
                title = "день"
            case 2:
                imageWeather = UIImage(named: "sunny.png")
                title = "вечер"
            case 3:
                imageWeather = UIImage(named: "sunny.png")
                title = "ночь"
                
            default:
                imageWeather = nil
                title = nil
            }
            if let image = imageWeather, let title = title {
                let view = ShortWeatherView.init(image: image, temperature: nil, timeDay: title, insets: UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4))
                stackView.addArrangedSubview(view)
            }
        }
        self.view.addSubview(stackView)
        self.view.addSubview(self.activityIndicator)
        // constraints
        locationLabel.snp.makeConstraints(){
            $0.bottom.equalTo(mainWeatherImageView.snp.top).offset(-16)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
        }
        mainWeatherImageView.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().dividedBy(2).offset(50)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview().dividedBy(4)
        }
        nowTemperatureLabel.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
            $0.top.equalTo(mainWeatherImageView.snp.bottom).offset(48)
        }
        stackView.snp.makeConstraints(){
            $0.centerY.equalToSuperview().multipliedBy(1.6)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
        }
        self.activityIndicator.snp.makeConstraints(){
            $0.top.equalTo(nowTemperatureLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    // Private
    func showAlertController(style: UIAlertControllerStyle, setupBlock: (UIAlertController) -> Void) {
        
        let alertController: UIAlertController = UIAlertController(title: "Ошибка", message: nil, preferredStyle: style)
        setupBlock(alertController)
        if alertController.actions.count < 1 {
            fatalError("No actions provided in alert controller")
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOkAlertController (title: String?, message: String?, callback: (() -> Void)? = nil) {
        self.showAlertController(style: .alert) {
            $0.title = title
            $0.message = message
            let action = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                if callback != nil {
                    callback!()
                }
            })
            $0.addAction(action)
        }
    }
    
}

extension WeatherDetailViewController: IWeatherDetailView {
    func setMainColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    
    func mainImage(_ image: UIImage) {
        //self.mainWeatherImageView?.image = image
    }
    
    func setLocationTitle(_ title: String) {
        guard let locationLabel = self.locationLabel else {
            return
        }
        locationLabel.text = title
    }
    
    func setNowTemperature(_ temperature: Int) {
        guard let nowTemperatureLabel = self.nowTemperatureLabel else { return }
        nowTemperatureLabel.text = String(temperature) + "°"
    }
    
    func setNowWeatherType(_ type: WeatherType){
        if let image = UIImage(named: type.rawValue) {
            self.mainWeatherImageView?.image = image
        }
    }
    func showDownLoading(_ visible: Bool){
        self.activityIndicator.alpha = visible ? 1 : 0
    }
    func showError(message: String? = nil){
        self.showOkAlertController(title: "Ошибка", message: message)
    }
}
