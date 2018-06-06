//
//  ShortWeatherView.swift
//  WheatherTest
//
//  Created by Dmitry Sharygin on 19.05.2018.
//  Copyright © 2018 Dmitry Sharygin. All rights reserved.
//

import UIKit
import SnapKit

class ShortWeatherView: UIView {
    
    var imageView: UIImageView? = nil
    var temperatureLabel : UILabel? = nil
    var dayTimeLabel: UILabel? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    convenience init(image: UIImage, temperature: Int?, timeDay: String, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.init()
        
        let container = UIView()
        self.addSubview(container)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)
        
        let dayTimeLabel = UILabel()
        dayTimeLabel.textAlignment = .center
        dayTimeLabel.text = timeDay.uppercased()
        dayTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        container.addSubview(dayTimeLabel)
        
        let temperatureLabel = UILabel()
        temperatureLabel.text = temperature != nil ? String(temperature!) + "°" : "?"
        temperatureLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
        container.addSubview(temperatureLabel)
        
        self.imageView = imageView
        self.temperatureLabel = temperatureLabel
        self.dayTimeLabel = dayTimeLabel
        
        container.snp.makeConstraints(){
            $0.edges.equalToSuperview().inset(insets)
        }
        
        imageView.snp.makeConstraints(){
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
            $0.width.equalToSuperview().dividedBy(2)
        }
        dayTimeLabel.snp.makeConstraints(){
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalTo(imageView.snp.top)
        }
        temperatureLabel.snp.makeConstraints(){
            $0.left.equalTo(imageView.snp.right)
            $0.right.equalToSuperview()
            $0.top.equalTo(imageView)
            $0.bottom.equalTo(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
